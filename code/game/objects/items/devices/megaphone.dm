/obj/item/megaphone
	name = "megaphone"
	desc = "A device used to project your voice. Loudly."
	icon = 'icons/obj/devices/voice.dmi'
	icon_state = "megaphone"
	inhand_icon_state = "megaphone"
	lefthand_file = 'icons/mob/inhands/items/megaphone_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/megaphone_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	siemens_coefficient = 1
	var/spamcheck = 0
	var/list/voicespan = list(SPAN_COMMAND)

/obj/item/megaphone/suicide_act(mob/living/carbon/user)
	user.visible_message(span_suicide("[user] is uttering [user.p_their()] last words into \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	spamcheck = 0//so they dont have to worry about recharging
	user.say("AAAAAAAAAAAARGHHHHH", forced="megaphone suicide")//he must have died while coding this
	return OXYLOSS

/obj/item/megaphone/equipped(mob/M, slot)
	. = ..()
	if ((slot & ITEM_SLOT_HANDS) && !HAS_TRAIT(M, TRAIT_SIGN_LANG))
		RegisterSignal(M, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	else
		UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/megaphone/dropped(mob/M)
	. = ..()
	UnregisterSignal(M, COMSIG_MOB_SAY)

/obj/item/megaphone/proc/handle_speech(mob/living/carbon/user, list/speech_args)
	SIGNAL_HANDLER
	if (user.get_active_held_item() == src)
		if(spamcheck > world.time)
			to_chat(user, span_warning("\The [src] needs to recharge!"))
		else
			playsound(loc, 'sound/items/megaphone.ogg', 100, FALSE, TRUE)
			spamcheck = world.time + 50
			speech_args[SPEECH_SPANS] |= voicespan

/obj/item/megaphone/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		return FALSE
	balloon_alert(user, "voice synthesizer overloaded")
	obj_flags |= EMAGGED
	voicespan = list(SPAN_REALLYBIG, "userdanger")
	return TRUE

/obj/item/megaphone/sec
	name = "security megaphone"
	icon_state = "megaphone-sec"
	inhand_icon_state = "megaphone-sec"

/obj/item/megaphone/command
	name = "command megaphone"
	icon_state = "megaphone-command"
	inhand_icon_state = "megaphone-command"

/obj/item/megaphone/cargo
	name = "supply megaphone"
	icon_state = "megaphone-cargo"
	inhand_icon_state = "megaphone-cargo"

/obj/item/megaphone/clown
	name = "clown's megaphone"
	desc = "Something that should not exist."
	icon_state = "megaphone-clown"
	inhand_icon_state = "megaphone-clown"
	voicespan = list(SPAN_CLOWN)
