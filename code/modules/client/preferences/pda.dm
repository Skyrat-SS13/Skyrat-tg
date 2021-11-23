/// The color of a PDA
/datum/preference/color/pda_color
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL // SKYRAT EDIT - Per-character PDA settings - ORIGINAL: category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "pda_color"
	savefile_identifier = PREFERENCE_CHARACTER // SKYRAT EDIT - Per-character PDA settings - ORIGINAL: savefile_identifier = PREFERENCE_PLAYER

/datum/preference/color/pda_color/create_default_value()
	return COLOR_OLIVE

// SKYRAT EDIT ADDITION BEGIN -- CUSTOMIZATION
/datum/preference/color/pda_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
// SKYRAT EDIT END

/// The visual style of a PDA
/datum/preference/choiced/pda_style
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL // SKYRAT EDIT - Per-character PDA settings - ORIGINAL: category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "pda_style"
	savefile_identifier = PREFERENCE_CHARACTER // SKYRAT EDIT - Per-character PDA settings - ORIGINAL: savefile_identifier = PREFERENCE_PLAYER

/datum/preference/choiced/pda_style/init_possible_values()
	return GLOB.pda_styles

// SKYRAT EDIT ADDITION BEGIN -- Per-character PDA settings
/datum/preference/choiced/pda_style/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
// SKYRAT EDIT END

// SKYRAT EDIT ADDITION BEGIN -- Per-character PDA settings
/// The thing your PDA says
/datum/preference/text/pda_ringer
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "pda_ringer"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/text/pda_ringer/create_default_value()
	return "beep"

/datum/preference/text/pda_ringer/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE
// SKYRAT EDIT END
