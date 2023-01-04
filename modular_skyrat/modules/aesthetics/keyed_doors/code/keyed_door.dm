// Similar to puzzle doors but with a closing function and a more general appearance that fits our spriting style. Minus the INDISTRUCTIBLE flag as well

/**
 * Keycard that's meant to be able to open a /obj/machinery/door/airlock/keyed. Without it, the door will not open.
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
	/// The access ID of the airlock it can be used to unlock.
	var/access_id  = null
	/// Is this keycard a master keycard, i.e. will it open all locked airlocks
	/// no matter their access_id? (Don't give this out willy-nilly, due to the
	/// possible implications it has).
	var/master_access = FALSE


/**
 * The doors and Keys need to match when being built, demo variants are found below
 * along with the requirements for use. Make sure the access_id matches the door or it won't work.
 *
 */
/obj/machinery/door/airlock/keyed
	name = "locked airlock"
	desc = "This door only opens when a keycard with the proper access is swiped. It looks virtually indestructible."
	icon = 'modular_skyrat/modules/aesthetics/keyed_doors/icons/keyed.dmi'
	// overlays_file = 'modular_skyrat/modules/aesthetics/keyed_doors/icons/keyed_overlays.dmi' // if this route is ever taken
	icon_state = "closed"
	explosion_block = 3
	heat_proof = TRUE
	density = TRUE
	max_integrity = 600
	armor = list(MELEE = 100, BULLET = 100, LASER = 100, ENERGY = 100, BOMB = 100, BIO = 100, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF | LAVA_PROOF
	move_resist = MOVE_FORCE_OVERPOWERING
	damage_deflection = 70
	/// Given the case of this being used, let's not let door spam be a thing.
	doorDeni = null
	/// The access ID of the airlock. Needs to match the variable of the
	/// same name from a /obj/item/key_card in order to be opened, unless it's null,
	/// in which case it will open no matter what.
	var/access_id = null
	/// Can it be opened with a master keycard? Set this to false if you plan to use
	/// it for something that's meant to have only one unique key.
	var/respects_master_access = TRUE


/obj/machinery/door/airlock/keyed/check_access(obj/item/key_card/used_keycard)
	if(!used_keycard || !istype(used_keycard))
		return FALSE

	if(locked) // Sorry, can't cheese this one if it's locked. :)
		return FALSE

	if(access_id && access_id != used_keycard.access_id && !(respects_master_access && used_keycard.master_access))
		return FALSE

	return TRUE


/obj/machinery/door/airlock/keyed/allowed(mob/accessor)
	if(issilicon(accessor)) // No, cyborgs, pAIs or AIs can't open these doors, sorry.
		return FALSE

	return ..()


// Standard Expressions to make keyed airlocks basically un-cheeseable

/obj/machinery/door/airlock/keyed/emp_act(severity)
	return


/obj/machinery/door/airlock/keyed/ex_act(severity, target)
	return FALSE


/obj/machinery/door/airlock/keyed/emag_act(mob/user, obj/item/card/emag/doorjack/D)
	return


/obj/machinery/door/airlock/keyed/screwdriver_act(mob/living/user, obj/item/tool)
	return


/obj/machinery/door/airlock/keyed/canAIControl(mob/user)
	return FALSE


/obj/machinery/door/airlock/keyed/canAIHack()
	return FALSE


/obj/machinery/door/airlock/keyed/AICtrlClick()
	return FALSE


/obj/machinery/door/airlock/keyed/AIAltClick()
	return FALSE


/obj/machinery/door/airlock/keyed/AIShiftClick()
	return FALSE


/obj/machinery/door/airlock/keyed/AICtrlShiftClick()
	return FALSE


/obj/machinery/door/airlock/keyed/BorgCtrlClick(mob/living/silicon/robot/user)
	return FALSE


/obj/machinery/door/airlock/keyed/BorgAltClick(mob/living/silicon/robot/user)
	return FALSE


/obj/machinery/door/airlock/keyed/BorgShiftClick(mob/living/silicon/robot/user)
	return FALSE


/obj/machinery/door/airlock/keyed/BorgCtrlShiftClick(mob/living/silicon/robot/user)
	return FALSE


/obj/machinery/door/airlock/keyed/ui_interact(mob/user, datum/tgui/ui)
	return FALSE
