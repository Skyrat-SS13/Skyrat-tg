/datum/component/simple_farm
	///whether you can actually farm it at the moment
	var/allow_plant = FALSE
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
	allow_plant = set_plant
	one_per_turf = set_turf_limit
	pixel_shift = set_shift
	//now lets register the signals
	RegisterSignal(atom_parent, COMSIG_PARENT_ATTACKBY, .proc/check_attack)
	RegisterSignal(atom_parent, COMSIG_PARENT_EXAMINE, .proc/check_examine)

/datum/component/simple_farm/Destroy(force, silent)
	//lets not hard del
	UnregisterSignal(atom_parent, list(COMSIG_PARENT_ATTACKBY, COMSIG_PARENT_EXAMINE))
	atom_parent = null
	return ..()

/**
 * check_attack is meant to listen for the comsig_parent_attackby signal, where it essentially functions like the attackby proc
 */
/datum/component/simple_farm/proc/check_attack(datum/source, obj/item/attacking_item, mob/user)
	SIGNAL_HANDLER
	//if it behaves like a shovel
	if(attacking_item.tool_behaviour == TOOL_SHOVEL)
		//flip the allow plant-- we either cover or uncover the plantable bit
		allow_plant = !allow_plant
		atom_parent.balloon_alert_to_viewers("[allow_plant ? "uncovered" : "covered"] the growing place!")

	//if its a seed, lets try to plant
	if(istype(attacking_item, /obj/item/seeds))
		var/obj/structure/simple_farm/locate_farm = locate() in get_turf(atom_parent)

		if(one_per_turf && locate_farm)
			atom_parent.balloon_alert_to_viewers("cannot plant more seeds here!")
			return

		locate_farm = new(get_turf(atom_parent))
		locate_farm.pixel_x = pixel_shift[1]
		locate_farm.pixel_y = pixel_shift[2]
		locate_farm.layer = atom_parent.layer + 0.1
		attacking_item.forceMove(locate_farm)
		locate_farm.planted_seed = attacking_item
		locate_farm.attached_atom = atom_parent
		atom_parent.balloon_alert_to_viewers("seed has been planted!")
		locate_farm.update_appearance()
		locate_farm.late_setup()

/**
 * check_examine is meant to listen for the comsig_parent_examine signal, where it will put additional information in the examine
 */
/datum/component/simple_farm/proc/check_examine(datum/source, mob/user, list/examine_list)
	if(allow_plant)
		examine_list += span_notice("You are able to plant seeds here!")

	else
		examine_list += span_warning("You need to use a shovel before you can plant seeds here!")

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
	///the amount of harvests from using a regen core
	var/regen_harvest_num = 4
	///the cooldown amount between each harvest
	var/harvest_cooldown = 1 MINUTES
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
	. += span_notice("<br>You can use sinew to lower the time between each harvest!")
	. += span_notice("You can use goliath hides to increase the amount dropped per harvest!")
	. += span_notice("You can use a regenerative core to force the plant to drop four harvests!")

/obj/structure/simple_farm/process(delta_time)
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
		if(harvest_cooldown <= 30 SECONDS)
			balloon_alert(user, "the plant already grows fast!")
			return

		var/obj/item/stack/sheet/sinew/use_item = attacking_item

		if(!use_item.use(1))
			return

		harvest_cooldown -= 15 SECONDS
		balloon_alert_to_viewers("the plant grows faster!")
		return

	//if its goliath hide, increase the amount dropped
	else if(istype(attacking_item, /obj/item/stack/sheet/animalhide/goliath_hide))
		if(max_harvest >= 6)
			balloon_alert(user, "the plant already drops a lot!")
			return

		var/obj/item/stack/sheet/animalhide/goliath_hide/use_item = attacking_item

		if(!use_item.use(1))
			return

		max_harvest++
		balloon_alert_to_viewers("the plant drops more!")
		return

	//if its a regen core, then create four harvests
	else if(istype(attacking_item, /obj/item/organ/internal/regenerative_core))
		qdel(attacking_item)
		for(var/i in 1 to regen_harvest_num)
			create_harvest()
		return

	return ..()

/**
 * used during the component so that it can move when its attached atom moves
 */
/obj/structure/simple_farm/proc/late_setup()
	if(!ismovable(attached_atom))
		return
	RegisterSignal(attached_atom, COMSIG_MOVABLE_MOVED, .proc/move_plant)

/**
 * a simple proc to forcemove the plant on top of the movable atom its attached to
 */
/obj/structure/simple_farm/proc/move_plant()
	forceMove(get_turf(attached_atom))

/**
 * will create a harvest of the seeds product, with a chance to create a mutated version
 */
/obj/structure/simple_farm/proc/create_harvest()
	if(!planted_seed)
		return

	for(var/i in 1 to rand(1, max_harvest))
		var/obj/creating_obj

		if(prob(15) && length(planted_seed.mutatelist))
			var/obj/item/seeds/choose_seed = pick(planted_seed.mutatelist)
			creating_obj = initial(choose_seed.product)

			if(!creating_obj)
				creating_obj = choose_seed

			new creating_obj(get_turf(src))
			balloon_alert_to_viewers("something special drops!")
			continue

		creating_obj = planted_seed.product

		if(!creating_obj)
			creating_obj = planted_seed.type

		new creating_obj(get_turf(src))

/turf/open/misc/asteroid/basalt/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_farm)
