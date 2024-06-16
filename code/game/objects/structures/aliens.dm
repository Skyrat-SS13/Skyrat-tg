/* Alien shit!
 * Contains:
 * structure/alien
 * Resin
 * Weeds
 * Egg
 */


/obj/structure/alien
	icon = 'icons/mob/nonhuman-player/alien.dmi'
	max_integrity = 100

/obj/structure/alien/run_atom_armor(damage_amount, damage_type, damage_flag = 0, attack_dir)
	if(damage_flag == MELEE)
		switch(damage_type)
			if(BRUTE)
				damage_amount *= 0.25
			if(BURN)
				damage_amount *= 2
	. = ..()

/obj/structure/alien/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BRUTE)
			if(damage_amount)
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
			else
				playsound(src, 'sound/weapons/tap.ogg', 50, TRUE)
		if(BURN)
			if(damage_amount)
				playsound(loc, 'sound/items/welder.ogg', 100, TRUE)

/*
 * Generic alien stuff, not related to the purple lizards but still alien-like
 */

/obj/structure/alien/gelpod
	name = "gelatinous mound"
	desc = "A mound of jelly-like substance encasing something inside."
	icon = 'icons/obj/fluff/general.dmi'
	icon_state = "gelmound"

/obj/structure/alien/gelpod/atom_deconstruct(disassembled = TRUE)
	new /obj/effect/mob_spawn/corpse/human/damaged(get_turf(src))

/*
 * Resin
 */
/obj/structure/alien/resin
	name = "resin"
	desc = "Looks like some kind of thick resin."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	density = TRUE
	opacity = TRUE
	anchored = TRUE
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ALIEN_RESIN
	canSmoothWith = SMOOTH_GROUP_ALIEN_RESIN
	max_integrity = 200
	var/resintype = null
	can_atmos_pass = ATMOS_PASS_DENSITY


/obj/structure/alien/resin/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE, TRUE)

/obj/structure/alien/resin/Destroy()
	air_update_turf(TRUE, FALSE)
	. = ..()

/obj/structure/alien/resin/Move()
	var/turf/T = loc
	. = ..()
	move_update_air(T)

/obj/structure/alien/resin/wall
	name = "resin wall"
	desc = "Thick resin solidified into a wall."
	icon = 'icons/obj/smooth_structures/alien/resin_wall.dmi'
	icon_state = "resin_wall-0"
	base_icon_state = "resin_wall"
	resintype = "wall"
	smoothing_groups = SMOOTH_GROUP_ALIEN_WALLS + SMOOTH_GROUP_ALIEN_RESIN
	canSmoothWith = SMOOTH_GROUP_ALIEN_WALLS

/obj/structure/alien/resin/wall/block_superconductivity()
	return 1

/// meant for one lavaland ruin or anywhere that has simplemobs who can push aside structures
/obj/structure/alien/resin/wall/immovable
	desc = "Dense resin solidified into a wall."
	move_resist = MOVE_FORCE_VERY_STRONG

/obj/structure/alien/resin/wall/creature
	name = "gelatinous wall"
	desc = "Thick material shaped into a wall. Yuck."
	color = "#8EC127"

/obj/structure/alien/resin/membrane
	name = "resin membrane"
	desc = "Resin just thin enough to let light pass through."
	icon = 'icons/obj/smooth_structures/alien/resin_membrane.dmi'
	icon_state = "resin_membrane-0"
	base_icon_state = "resin_membrane"
	opacity = FALSE
	max_integrity = 160
	resintype = "membrane"
	smoothing_groups = SMOOTH_GROUP_ALIEN_WALLS + SMOOTH_GROUP_ALIEN_RESIN
	canSmoothWith = SMOOTH_GROUP_ALIEN_WALLS

/obj/structure/alien/resin/attack_paw(mob/user, list/modifiers)
	return attack_hand(user, modifiers)

///Used in the big derelict ruin exclusively.
/obj/structure/alien/resin/membrane/creature
	name = "gelatinous membrane"
	desc = "A strange combination of thin, gelatinous material."
	color = "#4BAE56"

/*
 * Weeds
 */

#define NODERANGE 3

/obj/structure/alien/weeds
	gender = PLURAL
	name = "resin floor"
	desc = "A thick resin surface covers the floor."
	anchored = TRUE
	density = FALSE
	layer = MID_TURF_LAYER
	plane = FLOOR_PLANE
	icon = 'icons/obj/smooth_structures/alien/weeds1.dmi'
	icon_state = "weeds1-0"
	base_icon_state = "weeds1"
	max_integrity = 15
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_ALIEN_WEEDS + SMOOTH_GROUP_ALIEN_RESIN
	canSmoothWith = SMOOTH_GROUP_ALIEN_WEEDS + SMOOTH_GROUP_WALLS
	///the range of the weeds going to be affected by the node
	var/node_range = NODERANGE
	///the parent node that will determine if we grow or die
	var/obj/structure/alien/weeds/node/parent_node
	///the list of turfs that the weeds will not be able to grow over
	var/static/list/blacklisted_turfs = list(
		/turf/open/space,
		/turf/open/chasm,
		/turf/open/lava,
		/turf/open/water,
		/turf/open/openspace,
	)

/obj/structure/alien/weeds/Initialize(mapload)
	//so the sprites line up right in the map editor
	pixel_x = -4
	pixel_y = -4

	. = ..()

	set_base_icon()

	AddElement(/datum/element/atmos_sensitive, mapload)

/obj/structure/alien/weeds/Destroy()
	if(parent_node)
		UnregisterSignal(parent_node, COMSIG_QDELETING)
		parent_node = null
	return ..()

///Randomizes the weeds' starting icon, gets redefined by children for them not to share the behavior.
/obj/structure/alien/weeds/proc/set_base_icon()
	. = base_icon_state
	switch(rand(1,3))
		if(1)
			icon = 'icons/obj/smooth_structures/alien/weeds1.dmi'
			base_icon_state = "weeds1"
		if(2)
			icon = 'icons/obj/smooth_structures/alien/weeds2.dmi'
			base_icon_state = "weeds2"
		if(3)
			icon = 'icons/obj/smooth_structures/alien/weeds3.dmi'
			base_icon_state = "weeds3"
	set_smoothed_icon_state(smoothing_junction)

/**
 * Called when the node is trying to grow/expand
 */
/obj/structure/alien/weeds/proc/try_expand()
	//we cant grow without a parent node
	if(!parent_node)
		return
	//lets make sure we are still on a valid location
	var/turf/src_turf = get_turf(src)
	if(is_type_in_list(src_turf, blacklisted_turfs))
		qdel(src)
		return
	//lets try to grow in a direction
	for(var/turf/check_turf in src_turf.get_atmos_adjacent_turfs())
		//we cannot grow on blacklisted turfs
		if(is_type_in_list(check_turf, blacklisted_turfs))
			continue
		var/obj/structure/alien/weeds/check_weed = locate() in check_turf
		//we cannot grow onto other weeds
		if(check_weed)
			continue
		//spawn a new one in the turf
		check_weed = new(check_turf)
		//set the new one's parent node to our parent node
		check_weed.parent_node = parent_node
		check_weed.RegisterSignal(parent_node, COMSIG_QDELETING, PROC_REF(after_parent_destroyed))

/**
 * Called when the parent node is destroyed
 */
/obj/structure/alien/weeds/proc/after_parent_destroyed()
	if(!find_new_parent())
		var/random_time = rand(2 SECONDS, 8 SECONDS)
		addtimer(CALLBACK(src, PROC_REF(do_qdel)), random_time)

/**
 * Called when trying to find a new parent after our previous parent died
 * Will return false if it can't find a new_parent
 * Will return the new parent if it can find one
 */
/obj/structure/alien/weeds/proc/find_new_parent()
	var/previous_node = parent_node
	parent_node = null
	for(var/obj/structure/alien/weeds/node/new_parent in range(node_range, src))
		if(new_parent == previous_node)
			continue
		parent_node = new_parent
		RegisterSignal(parent_node, COMSIG_QDELETING, PROC_REF(after_parent_destroyed))
		return parent_node
	return FALSE

/**
 * Called to delete the weed
 */
/obj/structure/alien/weeds/proc/do_qdel()
	qdel(src)

/obj/structure/alien/weeds/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature > 300

/obj/structure/alien/weeds/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	take_damage(5, BURN, 0, 0)

/obj/structure/alien/weeds/node
	name = "glowing resin"
	desc = "Blue bioluminescence shines from beneath the surface."
	icon = 'icons/obj/smooth_structures/alien/weednode.dmi'
	icon_state = "weednode-0"
	base_icon_state = "weednode"
	light_color = LIGHT_COLOR_BLUE
	light_power = 0.5
	///the range of the light for the node
	var/lon_range = 4
	///the minimum time it takes for another weed to spread from this one
	var/minimum_growtime = 5 SECONDS
	///the maximum time it takes for another weed to spread from this one
	var/maximum_growtime = 10 SECONDS
	//the cooldown between each growth
	COOLDOWN_DECLARE(growtime)

/obj/structure/alien/weeds/node/Initialize(mapload)
	. = ..()

	//give it light
	set_light(lon_range)

	//we are the parent node
	parent_node = src

	return INITIALIZE_HINT_LATELOAD

// we do this in LateInitialize() because weeds on the same loc may not be done initializing yet (as in create_and_destroy)
/obj/structure/alien/weeds/node/LateInitialize()
	//destroy any non-node weeds on turf
	var/obj/structure/alien/weeds/check_weed = locate(/obj/structure/alien/weeds) in loc
	if(check_weed && check_weed != src)
		qdel(check_weed)

	//start the cooldown
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))

	//start processing
	START_PROCESSING(SSobj, src)

/obj/structure/alien/weeds/node/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/structure/alien/weeds/node/process()
	//we need to have a cooldown, so check and then add
	if(!COOLDOWN_FINISHED(src, growtime))
		return
	COOLDOWN_START(src, growtime, rand(minimum_growtime, maximum_growtime))
	//attempt to grow all weeds in range
	for(var/obj/structure/alien/weeds/growing_weed in range(node_range, src))
		growing_weed.try_expand()

/obj/structure/alien/weeds/node/set_base_icon()
	return //No icon randomization at init. The node's icon is already well defined.

/obj/structure/alien/weeds/creature
	name = "gelatinous floor"
	desc = "A thick gelatinous surface covers the floor.  Someone get the galoshes."
	color = "#4BAE56"


#undef NODERANGE


/*
 * Egg
 */

//for the status var
#define BURSTING "bursting"
#define BURST "burst"
#define GROWING "growing"
#define GROWN "grown"
#define FAKE "fake"
#define MIN_GROWTH_TIME 900 //time it takes to grow a hugger
#define MAX_GROWTH_TIME 1500

/obj/structure/alien/egg
	name = "egg"
	desc = "A large mottled egg."
	icon_state = "egg_growing"
	base_icon_state = "egg"
	density = FALSE
	anchored = TRUE
	max_integrity = 100
	integrity_failure = 0.05
	var/status = GROWING //can be GROWING, GROWN or BURST; all mutually exclusive
	layer = MOB_LAYER
	/// Ref to the hugger within.
	var/obj/item/clothing/mask/facehugger/child
	///Proximity monitor associated with this atom, needed for proximity checks.
	var/datum/proximity_monitor/proximity_monitor

/obj/structure/alien/egg/Initialize(mapload)
	. = ..()
	update_appearance()
	if(status == GROWING || status == GROWN)
		child = new(src)
	if(status == GROWING)
		addtimer(CALLBACK(src, PROC_REF(Grow)), rand(MIN_GROWTH_TIME, MAX_GROWTH_TIME))
	proximity_monitor = new(src, status == GROWN ? 1 : 0)
	if(status == BURST)
		atom_integrity = integrity_failure * max_integrity

	AddElement(/datum/element/atmos_sensitive, mapload)

/obj/structure/alien/egg/Destroy()
	QDEL_NULL(child)
	QDEL_NULL(proximity_monitor)
	return ..()

/obj/structure/alien/egg/update_icon_state()
	switch(status)
		if(GROWING)
			icon_state = "[base_icon_state]_growing"
		if(GROWN)
			icon_state = "[base_icon_state]"
		if(BURST)
			icon_state = "[base_icon_state]_hatched"
		if(FAKE)
			icon_state = "[base_icon_state]_growing"
	return ..()

/obj/structure/alien/egg/attack_paw(mob/living/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/alien/egg/attack_alien(mob/living/carbon/alien/user, list/modifiers)
	return attack_hand(user, modifiers)

/obj/structure/alien/egg/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(user.get_organ_by_type(/obj/item/organ/internal/alien/plasmavessel))
		switch(status)
			if(BURSTING)
				to_chat(user, span_notice("The child is hatching out."))
				return
			if(BURST)
				to_chat(user, span_notice("You clear the hatched egg."))
				playsound(loc, 'sound/effects/attackblob.ogg', 100, TRUE)
				qdel(src)
				return
			if(GROWING)
				to_chat(user, span_notice("The child is not developed yet."))
				return
			if(GROWN)
				to_chat(user, span_notice("You retrieve the child."))
				Burst(kill=FALSE)
				return
	else
		to_chat(user, span_notice("It feels slimy."))
		user.changeNext_move(CLICK_CD_MELEE)


/obj/structure/alien/egg/proc/Grow()
	status = GROWN
	update_appearance()
	proximity_monitor.set_range(1)

//drops and kills the hugger if any is remaining
/obj/structure/alien/egg/proc/Burst(kill = TRUE)
	if(status == GROWN || status == GROWING)
		status = BURSTING
		proximity_monitor.set_range(0)
		flick("egg_opening", src)
		addtimer(CALLBACK(src, PROC_REF(finish_bursting), kill), 1.5 SECONDS)

/obj/structure/alien/egg/proc/finish_bursting(kill = TRUE)
	status = BURST
	update_appearance()
	if(child)
		child.forceMove(get_turf(src))
		// TECHNICALLY you could put non-facehuggers in the child var
		if(istype(child))
			if(kill)
				child.Die()
			else
				for(var/mob/M in range(1,src))
					if(CanHug(M))
						child.Leap(M)
						break

/obj/structure/alien/egg/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == child)
		child = null

/obj/structure/alien/egg/should_atmos_process(datum/gas_mixture/air, exposed_temperature)
	return exposed_temperature > 500

/obj/structure/alien/egg/atmos_expose(datum/gas_mixture/air, exposed_temperature)
	take_damage(5, BURN, 0, 0)

/obj/structure/alien/egg/atom_break(damage_flag)
	. = ..()
	if(status != BURST)
		Burst(kill=TRUE)

/obj/structure/alien/egg/HasProximity(atom/movable/AM)
	if(status == GROWN)
		if(!CanHug(AM))
			return

		var/mob/living/carbon/C = AM
		if(C.stat == CONSCIOUS && C.get_organ_by_type(/obj/item/organ/internal/body_egg/alien_embryo))
			return

		Burst(kill=FALSE)

/obj/structure/alien/egg/grown
	status = GROWN
	icon_state = "egg"

/obj/structure/alien/egg/burst
	status = BURST
	icon_state = "egg_hatched"

/obj/structure/alien/egg/fake
	status = FAKE
	icon_state = "egg_growing"
	layer = LOW_ITEM_LAYER

#undef FAKE
#undef BURSTING
#undef BURST
#undef GROWING
#undef GROWN
#undef MIN_GROWTH_TIME
#undef MAX_GROWTH_TIME
