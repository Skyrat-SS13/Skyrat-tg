/datum/preference/color/chat_color_player
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "chat_color_player"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/chat_color_player/is_valid(value)
	var/hex_value = sanitize_hexcolor(value)
	if((hex_value < "#252525") || (hex_value > "#e0e0e0")) // These colors are too bright or too dark
		if(hex_value == COLOR_BLACK) // Allow it to be disabled, returning name generated colors
			return TRUE
		return FALSE
	return TRUE

/datum/preference/color/chat_color_player/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/color/chat_color_player/create_default_value()
	return COLOR_BLACK
