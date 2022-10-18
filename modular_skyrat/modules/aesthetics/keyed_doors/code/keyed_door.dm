// Similar to puzzle doors but with a closing function and a more general appearance that fits our spriting style. Minus the INDISTRUCTIBLE flag as well

/*
//Keycard that controls the door itself, without it - the door will not open
*/

/obj/item/key_card
	name = "door keycard"
	desc = "This feels like it belongs to a door."
	icon = 'icons/obj/puzzle_small.dmi'
	icon_state = "keycard"
	force = 0
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_speed = 1
	throw_range = 7
	resistance_flags = INDESTRUCTIBLE | FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	var/keycard_id = null

/*
//The doors and Keys need to match when being built, demo variants are found below along with the requirements for use
//Make sure the keycard_id matches the door or it wont work
*/

/obj/machinery/door/keyed
	name = "A locked door"
	desc = "This door requires a specific key to open. It looks virtually indestructible."
	icon = 'modular_skyrat/modules/aesthetics/keyed_doors/icons/keyed.dmi'
	//overlays_file = 'modular_skyrat/modules/aesthetics/keyed_doors/icons/keyed_overlays.dmi'
	icon_state = "closed"
	explosion_block = 3
	heat_proof = TRUE
	density = TRUE
	max_integrity = 600
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 100, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	move_resist = MOVE_FORCE_OVERPOWERING
	damage_deflection = 70
	var/keycard_id = null
	var/open_message = "The door beeps, and slides opens."

//Standard Expressions to make keyed doors basically un-cheeseable
/obj/machinery/door/keyed/Bumped(atom/movable/AM)
	return !density && ..()

/obj/machinery/door/keyed/emp_act(severity)
	return

/obj/machinery/door/keyed/ex_act(severity, target)
	return FALSE

/obj/machinery/door/keyed/try_to_activate_door(mob/user, access_bypass = FALSE)
	add_fingerprint(user)
	if(operating)
		return

/obj/machinery/door/keyed/proc/try_keycard_open(try_id)
	if(keycard_id && keycard_id != try_id)
		return FALSE
	if(!density)
		visible_message(span_warning("The door can't seem to be closed."))
		return TRUE
	if(open_message)
		visible_message(span_notice(open_message))
	open()
	return TRUE

/obj/machinery/door/update_icon_state()
	icon_state = "[base_icon_state][density]"
	return ..()
/obj/machinery/door/keyed/keycard
	desc = "This door only opens when a keycard is swiped. It looks virtually indestructible."

/obj/machinery/door/keyed/keycard/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(!istype(attacking_item, /obj/item/key_card))
		return
	var/obj/item/key_card/key = attacking_item
	if(!try_keycard_open(key.keycard_id))
		to_chat(user, span_notice("[src] buzzes. You require the correct key."))

/obj/machinery/door/keyed/light
	desc = "This door only opens when a linked mechanism is powered. It looks virtually indestructible."

/obj/machinery/door/keyed/light/Initialize(mapload)
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_LIGHT_MECHANISM_COMPLETED, .proc/check_mechanism)

/obj/machinery/door/keyed/light/proc/check_mechanism(datum/source, try_id)
	SIGNAL_HANDLER

	INVOKE_ASYNC(src, .proc/try_keycard_open, try_id)
