/obj/item/device/traitor_announcer
	name = "odd device"
	desc = "Hmm... what is this for?"
	special_desc_requirement = EXAMINE_CHECK_SYNDICATE
	special_desc = "A remote usable to fake an announcement from the captain, of your choice."
	icon = 'icons/obj/device.dmi'
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	icon_state = "inspector"
	worn_icon_state = "salestagger"
	inhand_icon_state = "electronic"
	///How many uses does it have? -1 for infinite
	var/uses = 1

/obj/item/device/traitor_announcer/attack_self(mob/living/user, modifiers)
	. = ..()
	//can we use this?
	if(!isliving(user) || !uses)
		balloon_alert(user, "no charge!")
		return
	//build our announcement
	var/origin = sanitize_text(reject_bad_text(tgui_input_text(user, "Who is announcing, or where is the announcement coming from?", "Announcement Origin", get_area_name(user), max_length = 28)))
	var/audio_key = tgui_input_list(user, "Which announcement audio key should play? ('Intercept' is default)", "Announcement Audio", GLOB.announcer_keys, ANNOUNCER_INTERCEPT)
	var/color = tgui_input_list(user, "Which color should the announcement be?", "Announcement Hue", ANNOUNCEMENT_COLORS, "default")
	var/title = sanitize_text(reject_bad_text(tgui_input_text(user, "Choose the title of the announcement.", "Announcement Title", max_length = 42)))
	var/input = sanitize_text(reject_bad_text(tgui_input_text(user, "Choose the bodytext of the announcement.", "Announcement Text", max_length = 512, multiline = TRUE)))
	//is the input valid?
	if(!origin || !audio_key || !color || !title || !input)
		balloon_alert(user, "mis-input!")
		return
	//treat voice
	var/list/message_data = user.treat_message(input)
	//send
	priority_announce(
	text = message_data["message"],
	title = title,
	sound = audio_key,
	has_important_message = TRUE,
	sender_override = origin,
	color_override = color,
	)
	if(uses != -1 && uses)
		uses--
	deadchat_broadcast(" made a fake priority announcement from [span_name("[get_area_name(usr, TRUE)]")].", span_name("[user.real_name]"), user, message_type=DEADCHAT_ANNOUNCEMENT)
	user.log_talk(input, LOG_SAY, tag = "priority announcement")
	message_admins("[ADMIN_LOOKUPFLW(user)] has used [src] to make a fake announcement of [input].")
	if(!uses)
		qdel(src)

// Adminbus
/obj/item/device/traitor_announcer/infinite
	uses = -1
