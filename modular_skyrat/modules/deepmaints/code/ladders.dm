GLOBAL_LIST_EMPTY(deepmaints_entrances)
GLOBAL_LIST_EMPTY(deepmaints_exits)

/obj/structure/deepmaints_entrance
	name = "heavy hatch"
	desc = "An odd, unmarked hatch that leads to somewhere below it. It looks really old, \
		you get the feeling you shouldn't go through it without being prepared for \
		consequences."
	icon = 'modular_skyrat/modules/deepmaints/icons/entrances.dmi'
	icon_state = "hatch"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = TRUE

/obj/structure/deepmaints_entrance/Initialize(mapload)
	. = ..()

	log_to_global_list()

/obj/structure/deepmaints_entrance/Destroy()
	remove_from_global_list()

	return ..()

/// Adds the entrance to the global list of entrances
/obj/structure/deepmaints_entrance/proc/log_to_global_list()
	GLOB.deepmaints_entrances += src

/// Removes the entrance from the global list of entrances
/obj/structure/deepmaints_entrance/proc/remove_from_global_list()
	GLOB.deepmaints_entrances -= src

/obj/structure/deepmaints_entrance/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(.)
		return
	enter_the_fun_zone(user)

/obj/structure/deepmaints_entrance/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	enter_the_fun_zone(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/obj/structure/deepmaints_entrance/attackby(obj/item/item, mob/user, params)
	enter_the_fun_zone(user)
	return TRUE

/obj/structure/deepmaints_entrance/attackby_secondary(obj/item/item, mob/user, params)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return
	enter_the_fun_zone(user)
	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

/// Finds a random ladder inside the deepmaints area to send the entree to it
/obj/structure/deepmaints_entrance/proc/enter_the_fun_zone(mob/user)
	if(!in_range(src, user) || DOING_INTERACTION(user, DOAFTER_SOURCE_CLIMBING_LADDER))
		return
	if(!length(GLOB.deepmaints_exits))
		balloon_alert(user, "hatch seems broken...")
		return
	INVOKE_ASYNC(src, PROC_REF(send_him_to_detroit), user)

/// Actually moves the entree passed to it to a random exit
/obj/structure/deepmaints_entrance/proc/send_him_to_detroit(mob/user)
	var/obj/destination = pick(GLOB.deepmaints_exits)
	if(!destination)
		balloon_alert(user, "hatch seems broken...")
		return
	user.zMove(target = get_turf(destination), z_move_flags = ZMOVE_CHECK_PULLEDBY|ZMOVE_ALLOW_BUCKLED|ZMOVE_INCLUDE_PULLED)
	playsound(src, 'sound/machines/tramopen.ogg', 60, TRUE, frequency = 65000)
	playsound(destination, 'sound/machines/tramclose.ogg', 60, TRUE, frequency = 65000)

/// Checks every trash pile in maintenance and converts 3-5 of them into deepmaints hatches
/datum/controller/subsystem/minor_mapping/proc/spawn_deepmaint_entrances()

	log_world("started the deepmaint entrances proc")

#ifndef LOWMEMORYMODE

	log_world("deepmaint level loading wasn't stopped by lowmem mode")

	var/list/all_deepmaint_layouts = generate_map_list_from_directory("_maps/skyrat/deepmaint/map_layouts/")
	var/deepmaints_template_to_use = pick(all_deepmaint_layouts)

	log_world("deepmaints template chosen was [deepmaints_template_to_use]")

	var/loaded = load_new_z_level(deepmaints_template_to_use, "Deep maintenance", TRUE)
	if(!loaded)
		log_world("the level failed to load somehow")
		message_admins("Deep maintenance template [deepmaints_template_to_use] loading failed due to errors.")
		log_admin("Deep maintenance template [deepmaints_template_to_use] loading failed due to errors.")
		return

#endif

	// If we already have entrances then don't worry about the rest of this
	if(length(GLOB.deepmaints_entrances) > 3)
		log_world("we had too many deepmaints entrances, stopped")
		return

	var/number_of_entrances = rand(3, 5)

	log_world("number of entrances chosen was [number_of_entrances]")

	var/list/potential_entrance_spots = find_trash_piles()

	log_world("the list of potential entrance spots has [length(potential_entrance_spots)] items, [english_list(potential_entrance_spots)]")

	if(!length(potential_entrance_spots))
		var/msg = "HEY! LISTEN! There were no trash piles that the minor mapping subysystem could use to spawn entrances to deepmaints!."
		to_chat(world, span_boldannounce("[msg]"))
		warning(msg)
		return

	for(var/entrance_spawn_iteration in 1 to number_of_entrances)
		var/obj/structure/trash_pile/trash_pile_in_question = pick_n_take(potential_entrance_spots)
		new /obj/structure/deepmaints_entrance(trash_pile_in_question.drop_location())
		log_world("a deepmaints entrance was created")
		qdel(trash_pile_in_question)

/datum/controller/subsystem/minor_mapping/proc/find_trash_piles()
	var/list/trash_piles = list()

	var/list/all_turfs
	for(var/z_level in SSmapping.levels_by_trait(ZTRAIT_STATION))
		all_turfs += Z_TURFS(z_level)
	for(var/turf/open/checking_turf in all_turfs)
		if(!istype(get_area(checking_turf), /area/station/maintenance))
			continue
		var/trash_pile_to_find = locate(/obj/structure/trash_pile) in checking_turf
		trash_piles += trash_pile_to_find

	return shuffle(trash_piles)

/obj/structure/deepmaints_entrance/exit
	name = "exit ladder"
	desc = "A ladder that leads back to 'civilization' above, though its mighty dark up there... \
		Chances are you might not end up where you entered."
	icon_state = "exit_ladder"

/obj/structure/deepmaints_entrance/exit/log_to_global_list()
	GLOB.deepmaints_exits += src

/obj/structure/deepmaints_entrance/exit/remove_from_global_list()
	GLOB.deepmaints_exits -= src

/obj/structure/deepmaints_entrance/exit/enter_the_fun_zone(mob/user)
	if(!in_range(src, user) || DOING_INTERACTION(user, DOAFTER_SOURCE_CLIMBING_LADDER))
		return
	if(!length(GLOB.deepmaints_entrances))
		balloon_alert(user, "hatch above seems stuck...")
		return
	INVOKE_ASYNC(src, PROC_REF(send_him_to_detroit), user)

/obj/structure/deepmaints_entrance/exit/send_him_to_detroit(mob/user)
	var/obj/destination = pick(GLOB.deepmaints_entrances)
	if(!destination)
		balloon_alert(user, "hatch above seems stuck...")
		return
	user.zMove(target = get_turf(destination), z_move_flags = ZMOVE_CHECK_PULLEDBY|ZMOVE_ALLOW_BUCKLED|ZMOVE_INCLUDE_PULLED)
	playsound(src, 'sound/machines/tramopen.ogg', 60, TRUE, frequency = 65000)
	playsound(destination, 'sound/machines/tramclose.ogg', 60, TRUE, frequency = 65000)
