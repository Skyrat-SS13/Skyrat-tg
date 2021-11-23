/obj/machinery/door/firedoor/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(operating || !density)
		return
	if(!user.combat_mode && try_manual_override(user))
		return
	user.changeNext_move(CLICK_CD_MELEE)

	user.visible_message(span_notice("[user] bangs on \the [src]."), \
		span_notice("You bang on \the [src]."))
	playsound(loc, 'sound/effects/glassknock.ogg', 10, FALSE, frequency = 32000)

/obj/machinery/door/proc/try_manual_override(mob/user)
	if(density)
		to_chat(user, span_notice("You begin working the manual override mechanism..."))
		if(do_after(user, 10 SECONDS, target = src))
			try_to_crowbar(null, user)
			return TRUE
	return FALSE

/obj/machinery/door/firedoor/try_to_crowbar(obj/item/I, mob/user)
	if(welded || operating)
		to_chat(user, span_warning("[src] refuses to budge!"))
		return

	if(density)
		open()
	else
		close()
