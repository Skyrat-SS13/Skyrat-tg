// A toggle per character to spawn with a pin indicating you are new to the server
/datum/preference/toggle/green_pin
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "green_pin"

// If is_green is TRUE, you may access the toggle
/datum/preference/toggle/green_pin/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return preferences?.parent?.is_green()

// If is_green is TRUE, the toggle is set to TRUE
// This is just to make sure non-noobs don't get their toggle to TRUE without having access to it
/datum/preference/toggle/green_pin/create_default_value(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	return preferences?.parent?.is_green()

/datum/preference/toggle/green_pin/apply_to_human(mob/living/carbon/human/wearer, value)
	if(value && wearer.client && !wearer.client?.is_green())
		// This way, it doesn't stick for those that had it set to TRUE before they got their 100 hours in.
		wearer.client?.prefs?.write_preference(GLOB.preference_entries[/datum/preference/toggle/green_pin], FALSE)

	return

/client/proc/is_green()
	return get_exp_living(pure_numeric = TRUE) <= PLAYTIME_GREEN
