/datum/preference/toggle/enable_runechat
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "chat_on_map"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/enable_runechat_non_mobs
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "see_chat_non_mob"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/see_rc_emotes
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "see_rc_emotes"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/numeric/max_chat_length
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "max_chat_length"
	savefile_identifier = PREFERENCE_PLAYER

	minimum = 1
	maximum = CHAT_MESSAGE_MAX_LENGTH

/datum/preference/numeric/max_chat_length/create_default_value()
	return CHAT_MESSAGE_MAX_LENGTH

// Skyrat Addition - Character preference for chatmessages
/datum/preference/color/chat_color_player
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "chat_color_player"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/color/chat_color_player/is_valid(value)
	if(value < "#222222")	// These colors are too bright or too dark
		if(value == "#000000")	// Allow it to be disabled, returning name generated colors
			return TRUE
		return FALSE
	return TRUE

/datum/preference/color/chat_color_player/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/color/chat_color_player/create_default_value()
	return "#000000"
//
