/datum/preference/toggle/enable_chat_color_player
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "enable_chat_color_player"
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE

/datum/preference/toggle/enable_chat_color_player/apply_to_human()
	return

/datum/preference/color/chat_color_player
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "chat_color_player"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/chat_color_player/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/allowed = preferences.read_preference(/datum/preference/toggle/enable_chat_color_player)
	return allowed

/datum/preference/color/chat_color_player/is_valid(value)
	var/hex_value = sanitize_hexcolor(value)
	if((hex_value < "#252525") || (hex_value > "#e0e0e0")) // These colors are too dark or too bright
		return FALSE
	return TRUE

/datum/preference/color/chat_color_player/apply_to_human()
	return
