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
