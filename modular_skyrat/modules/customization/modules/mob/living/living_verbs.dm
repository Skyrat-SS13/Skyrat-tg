GLOBAL_VAR_INIT(temporary_flavor_text_indicator, generate_temporary_flavor_text_indicator())

/proc/generate_temporary_flavor_text_indicator()
	var/mutable_appearance/temporary_flavor_text_indicator = mutable_appearance('modular_skyrat/modules/indicators/icons/temporary_flavor_text_indicator.dmi', "flavor", FLY_LAYER)
	temporary_flavor_text_indicator.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	return temporary_flavor_text_indicator

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
	var/result = msg || null
	temporary_flavor_text = result
	update_appearance(UPDATE_ICON|UPDATE_OVERLAYS)

/mob/living/update_overlays()
	. = ..()
	if (temporary_flavor_text)
		. += GLOB.temporary_flavor_text_indicator

