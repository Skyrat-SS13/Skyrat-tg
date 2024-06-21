/datum/component/simple_farm
	///whether we limit the amount of plants you can have per turf
	var/one_per_turf = TRUE
	///the reference to the movable parent the component is attached to
	var/atom/atom_parent
	///the amount of pixels shifted (x,y)
	var/list/pixel_shift = 0

/datum/component/simple_farm/Initialize(set_plant = FALSE, set_turf_limit = TRUE, list/set_shift = list(0, 0))
	//we really need to check if its movable
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE
	atom_parent = parent
	//important to allow people to just straight up set allowing to plant
	one_per_turf = set_turf_limit
	pixel_shift = set_shift
	//now lets register the signals
	RegisterSignal(atom_parent, COMSIG_ATOM_ATTACKBY, PROC_REF(check_attack))
	RegisterSignal(atom_parent, COMSIG_ATOM_EXAMINE, PROC_REF(check_examine))
	RegisterSignal(atom_parent, COMSIG_QDELETING, PROC_REF(delete_farm))

/datum/component/simple_farm/Destroy(force, silent)
	//lets not hard del
	UnregisterSignal(atom_parent, list(COMSIG_ATOM_ATTACKBY, COMSIG_ATOM_EXAMINE, COMSIG_QDELETING))
	atom_parent = null
	return ..()

/**
 * check_attack is meant to listen for the COMSIG_ATOM_ATTACKBY signal, where it essentially functions like the attackby proc
 */
/datum/component/simple_farm/proc/check_attack(datum/source, obj/item/attacking_item, mob/user)
	SIGNAL_HANDLER

	//if its a seed, lets try to plant
	if(istype(attacking_item, /obj/item/seeds))
		var/obj/structure/simple_farm/locate_farm = locate() in get_turf(atom_parent)

		if(one_per_turf && locate_farm)
			atom_parent.balloon_alert_to_viewers("cannot plant more seeds here!")
			return

		locate_farm = new(get_turf(atom_parent))
		user.mind.adjust_experience(/datum/skill/primitive, 5)
		locate_farm.pixel_x = pixel_shift[1]
		locate_farm.pixel_y = pixel_shift[2]
		locate_farm.layer = atom_parent.layer + 0.1
		if(ismovable(atom_parent))
			var/atom/movable/movable_parent = atom_parent
			locate_farm.glide_size = movable_parent.glide_size
		attacking_item.forceMove(locate_farm)
		locate_farm.planted_seed = attacking_item
		locate_farm.attached_atom = atom_parent
		atom_parent.balloon_alert_to_viewers("seed has been planted!")
		locate_farm.update_appearance()
		locate_farm.late_setup()

/**
 * check_examine is meant to listen for the COMSIG_ATOM_EXAMINE signal, where it will put additional information in the examine
 */
/datum/component/simple_farm/proc/check_examine(datum/source, mob/user, list/examine_list)
	examine_list += span_notice("<br>You are able to plant seeds here!")

/**
 * delete_farm is meant to be called when the parent of this component has been deleted-- thus deleting the ability to grow the simple farm
 * it will delete the farm that can be found on the turf of the parent of this component
 */
/datum/component/simple_farm/proc/delete_farm()
	SIGNAL_HANDLER

	var/obj/structure/simple_farm/locate_farm = locate() in get_turf(atom_parent)
	if(locate_farm)
		qdel(locate_farm)

/obj/structure/simple_farm
	name = "simple farm"
	desc = "A small little plant that has adapted to the surrounding environment."
	//it needs to be able to be walked through
	density = FALSE
	//it should not be pulled by anything
	anchored = TRUE
	///the atom the farm is attached to
	var/atom/attached_atom
	///the seed that is held within
	var/obj/item/seeds/planted_seed
	///the max amount harvested from the plants
	var/max_harvest = 3
	///the cooldown amount between each harvest
	var/harvest_cooldown = 1 MINUTES
	///the extra potency applied to the seed
	var/bonus_potency = 0
	//the cooldown between each harvest
	COOLDOWN_DECLARE(harvest_timer)

/obj/structure/simple_farm/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)
	COOLDOWN_START(src, harvest_timer, harvest_cooldown)

/obj/structure/simple_farm/Destroy()
	STOP_PROCESSING(SSobj, src)

	if(planted_seed)
		planted_seed.forceMove(get_turf(src))
		planted_seed = null

	if(attached_atom)
		if(ismovable(attached_atom))
			UnregisterSignal(attached_atom, COMSIG_MOVABLE_MOVED)

		attached_atom = null

	return ..()

/obj/structure/simple_farm/examine(mob/user)
	. = ..()
	. += span_notice("<br>[src] will be ready for harvest in [DisplayTimeText(COOLDOWN_TIMELEFT(src, harvest_timer))]")
	if(max_harvest < 6)
		. += span_notice("<br>You can use sinew or worm fertilizer to lower the time between each harvest!")
	if(harvest_cooldown > 30 SECONDS)
		. += span_notice("You can use goliath hides or worm fertilizer to increase the amount dropped per harvest!")
	if(bonus_potency < 50)
		. += span_notice("You can use worm fertilizer to increase the potency of dropped crops!")

/obj/structure/simple_farm/process(seconds_per_tick)
	update_appearance()

/obj/structure/simple_farm/update_appearance(updates)
	if(!planted_seed)
		return

	icon = planted_seed.growing_icon

	if(COOLDOWN_FINISHED(src, harvest_timer))
		if(planted_seed.icon_harvest)
			icon_state = planted_seed.icon_harvest

		else
			icon_state = "[planted_seed.icon_grow][planted_seed.growthstages]"

		name = lowertext(planted_seed.plantname)

	else
		icon_state = "[planted_seed.icon_grow]1"
		name = lowertext("harvested [planted_seed.plantname]")

	return ..()

/obj/structure/simple_farm/attack_hand(mob/living/user, list/modifiers)
	if(!COOLDOWN_FINISHED(src, harvest_timer))
		balloon_alert(user, "plant not ready for harvest!")
		return

	COOLDOWN_START(src, harvest_timer, harvest_cooldown)
	create_harvest()
	user.mind.adjust_experience(/datum/skill/primitive, 5)
	update_appearance()
	return ..()

/obj/structure/simple_farm/attackby(obj/item/attacking_item, mob/user, params)
	//if its a shovel or knife, dismantle
	if(attacking_item.tool_behaviour == TOOL_SHOVEL || attacking_item.tool_behaviour == TOOL_KNIFE)
		var/turf/src_turf = get_turf(src)
		src_turf.balloon_alert_to_viewers("the plant crumbles!")
		Destroy()
		return

	//if its sinew, lower the cooldown
	else if(istype(attacking_item, /obj/item/stack/sheet/sinew))
		var/obj/item/stack/sheet/sinew/use_item = attacking_item

		if(!use_item.use(1))
			return

		decrease_cooldown(user)
		user.mind.adjust_experience(/datum/skill/primitive, 5)
		return

	//if its goliath hide, increase the amount dropped
	else if(istype(attacking_item, /obj/item/stack/sheet/animalhide/goliath_hide))
		var/obj/item/stack/sheet/animalhide/goliath_hide/use_item = attacking_item

		if(!use_item.use(1))
			return

		increase_yield(user)
		user.mind.adjust_experience(/datum/skill/primitive, 5)
		return

	else if(istype(attacking_item, /obj/item/stack/worm_fertilizer))

		var/obj/item/stack/attacking_stack = attacking_item

		if(!allow_yield_increase() && !allow_decrease_cooldown())
			balloon_alert(user, "plant is already fully upgraded")
			return

		if(!attacking_stack.use(1))
			balloon_alert(user, "unable to use [attacking_item]")
			return

		if(!decrease_cooldown(user, silent = TRUE) && !increase_yield(user, silent = TRUE) && !increase_potency(user, silent = TRUE))
			balloon_alert(user, "plant is already fully upgraded")

		else
			balloon_alert(user, "plant was upgraded")
			user.mind.adjust_experience(/datum/skill/primitive, 5)

		return

	else if(istype(attacking_item, /obj/item/storage/bag/plants))
		if(!COOLDOWN_FINISHED(src, harvest_timer))
			return

		COOLDOWN_START(src, harvest_timer, harvest_cooldown)
		create_harvest(attacking_item, user)
		user.mind.adjust_experience(/datum/skill/primitive, 5)
		update_appearance()
		return

	return ..()

/**
 * a proc that will check if we can increase the yield-- without increasing it
 */
/obj/structure/simple_farm/proc/allow_yield_increase()
	if(max_harvest >= 6)
		return FALSE

	return TRUE

/**
 * a proc that will increase the amount of items the crop could produce (at a maximum of 6, from base of 3)
 */
/obj/structure/simple_farm/proc/increase_yield(mob/user, var/silent = FALSE)
	if(!allow_yield_increase())
		if(!silent)
			balloon_alert(user, "plant is at maximum yield")

		return FALSE

	max_harvest++

	if(!silent)
		balloon_alert_to_viewers("plant will have increased yield")

	return TRUE

/**
 * a proc that will check if we can decrease the time-- without increasing it
 */
/obj/structure/simple_farm/proc/allow_decrease_cooldown()
	if(harvest_cooldown <= 30 SECONDS)
		return FALSE

	return TRUE

/**
 * a proc that will decrease the amount of time it takes to be ready for harvest (at a maximum of 30 seconds, from a base of 1 minute)
 */
/obj/structure/simple_farm/proc/decrease_cooldown(mob/user, var/silent = FALSE)
	if(!allow_decrease_cooldown())
		if(!silent)
			balloon_alert(user, "already at maximum growth speed!")

		return FALSE

	harvest_cooldown -= 10 SECONDS

	if(!silent)
		balloon_alert_to_viewers("plant will grow faster")

	return TRUE

/**
 * a proc that will increase the potency the crop grows at
 */
/obj/structure/simple_farm/proc/increase_potency(mob/user, var/silent = FALSE)
	if(bonus_potency >= 50)
		if(!silent)
			balloon_alert(user, "plant is at maximum potency")

		return FALSE

	bonus_potency += 10

	if(!silent)
		balloon_alert_to_viewers("plant will have increased potency")

	return TRUE

/**
 * used during the component so that it can move when its attached atom moves
 */
/obj/structure/simple_farm/proc/late_setup()
	if(!ismovable(attached_atom))
		return
	RegisterSignal(attached_atom, COMSIG_MOVABLE_MOVED, PROC_REF(move_plant))

/**
 * a simple proc to forcemove the plant on top of the movable atom its attached to
 */
/obj/structure/simple_farm/proc/move_plant()
	forceMove(get_turf(attached_atom))

/**
 * will create a harvest of the seeds product, with a chance to create a mutated version
 */
/obj/structure/simple_farm/proc/create_harvest(var/obj/item/storage/bag/plants/plant_bag, var/mob/user)
	if(!planted_seed)
		return

	for(var/i in 1 to rand(1, max_harvest))
		var/obj/item/seeds/seed
		if(prob(15) && length(planted_seed.mutatelist))
			var/type = pick(planted_seed.mutatelist)
			seed = new type
			balloon_alert_to_viewers("something special drops!")
		else
			seed = new planted_seed.type(null)

		seed.potency = 50 + bonus_potency

		var/harvest_type = seed.product || seed.type
		var/harvest = new harvest_type(get_turf(src), seed)
		plant_bag?.atom_storage?.attempt_insert(harvest, user, TRUE)

/turf/open/misc/asteroid/basalt/getDug()
	. = ..()
	AddComponent(/datum/component/simple_farm)

/turf/open/misc/asteroid/basalt/refill_dug()
	. = ..()
	qdel(GetComponent(/datum/component/simple_farm))

/turf/open/misc/asteroid/snow/getDug()
	. = ..()
	AddComponent(/datum/component/simple_farm)

/turf/open/misc/asteroid/snow/refill_dug()
	. = ..()
	qdel(GetComponent(/datum/component/simple_farm))
