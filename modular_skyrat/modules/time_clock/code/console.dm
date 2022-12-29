/obj/machinery/time_clock
	name = "PTO console"
	desc = "Used to clock in and clock out."
	icon = 'modular_skyrat/modules/time_clock/icons/machinery/console.dmi'
	icon_state = "timeclock"

	///Is the console locked?
	var/locked = FALSE
	///What ID card is currently inside?
	var/obj/item/card/id/inserted_id


/obj/machinery/time_clock/attackby(obj/item/used_item, mob/user)
	if(!istype(used_item, /obj/item/card/id))
		. = ..()

	if(inserted_id)
		to_chat(user, span_warning("There is already an ID card present!"))
		return FALSE

	if(!user.transferItemToLoc(used_item))
		to_chat(user, span_warning("You are unable to put [used_item] inside of the [src]!"))
		return FALSE

	inserted_id = used_item
	icon_state = "timeclock_card"

/obj/machinery/time_clock/AltClick(mob/user)
	. = ..()
	if(!Adjacent(user))
		to_chat(user, span_warning("You are out of range of the [src]!"))
		return FALSE

	if(!inserted_id)
		to_chat(user, span_warning("The [src] lacks an ID."))
		return FALSE

	if(!eject_inserted_id(user))
		return FALSE

///Ejects the ID stored inside of the parent machine, if there is one.
/obj/machinery/time_clock/proc/eject_inserted_id(mob/recepient)
	if(!inserted_id || !recepient)
		return FALSE

	inserted_id.forceMove(drop_location())
	recepient.put_in_hands(inserted_id)

	inserted_id = FALSE
	icon_state = "timeclock"



