/mob/living/verb/set_temporary_flavor()
	set category = "IC"
	set name = "Set Temporary Flavor Text"
	set desc = "Allows you to set a temporary flavor text."

	if(stat != CONSCIOUS)
		to_chat(usr, span_warning("You can't set your temporary flavor text now..."))
		return

	var/msg = tgui_input_text(usr, "Set the temporary flavor text in your 'examine' verb. This is for describing what people can tell by looking at your character.", "Temporary Flavor Text", temporary_flavor_text, max_length = MAX_FLAVOR_LEN, multiline = TRUE)
	if(msg == null)
		return

	// Turn empty input into no flavor text
	temporary_flavor_text = msg || null
