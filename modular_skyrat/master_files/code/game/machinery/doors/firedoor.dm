/obj/machinery/door/firedoor/AltClick(mob/user)
	. = ..()
	if(!user.canUseTopic(src, BE_CLOSE))
		return
	try_manual_override(user)

/obj/machinery/door/firedoor/examine(mob/user)
	. = ..()
	. += span_notice("Alt-click the door to use the manual override.")

/obj/machinery/door/proc/try_manual_override(mob/user)
	if(density && !welded && !operating)
		balloon_alert(user, "opening...")
		if(do_after(user, 10 SECONDS, target = src))
			try_to_crowbar(null, user)
			return TRUE
	return FALSE

/obj/machinery/door/firedoor/try_to_crowbar(obj/item/used_object, mob/user)
	if(welded || operating)
		balloon_alert(user, "opening failed!")
		return

	if(density)
		open()
	else
		close()
