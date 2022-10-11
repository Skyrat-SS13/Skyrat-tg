/obj/item/device/traitor_announcer
	name = "odd device"
	desc = "Hmm... what is this for?"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "A remote usable to fake an announcement from the captain, of your choice."
	icon = 'icons/obj/device.dmi'
	icon_state = "inspector"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	///How many uses does it have? -1 for infinite
	var/uses = 1

/obj/item/device/traitor_announcer/attack_self(mob/living/user, modifiers)
	. = ..()
	var/input = tgui_input_text(user, "Choose Announcement Message", "")
	if(!input || !isliving(user) || !uses)
		return
	if(uses != -1 && uses)
		uses--
	priority_announce(html_decode(user.treat_message(input)), null, ANNOUNCER_CAPTAIN, JOB_CAPTAIN, has_important_message = TRUE)
	deadchat_broadcast(" made a fake priority announcement from [span_name("[get_area_name(usr, TRUE)]")].", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)
	user.log_talk(input, LOG_SAY, tag = "priority announcement")
	message_admins("[ADMIN_LOOKUPFLW(user)] has used [src] to make a fake announcement of [input].")
	if(!uses)
		qdel(src)

// Adminbus
/obj/item/device/traitor_announcer/infinite
	uses = -1
