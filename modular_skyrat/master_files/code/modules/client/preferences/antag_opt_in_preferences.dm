/datum/config_entry/flag/disable_antagOptIn_preferences
	default = FALSE

/datum/preference/toggle/master_antagOptIn_preferences
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "master_antagOptIn_pref"
	savefile_identifier = PREFERENCE_PLAYER
	default_value = TRUE

/datum/preference/toggle/master_antagOptIn_preferences/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return FALSE

	return TRUE

/datum/preference/toggle/master_antagOptIn_preferences/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return FALSE
	. = ..()

/datum/preference/toggle/antagOptIn
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_identifier = PREFERENCE_PLAYER
	savefile_key = "antagOptIn_pref"
	default_value = FALSE

/datum/preference/toggle/antagOptIn/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_antagOptIn_preferences)

/datum/preference/toggle/antagOptIn/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return FALSE
	if(!preferences.read_preference(/datum/preference/toggle/master_antagOptIn_preferences))
		return FALSE
	. = ..()

/datum/preference/toggle/antagOptIn/apply_to_client_updated(client/client, value)
	. = ..()
	var/mob/living/carbon/human/target = client?.mob
	if(!value && istype(target))
		target.arousal = 0
		target.pain = 0
		target.pleasure = 0
	client.mob.hud_used.hidden_inventory_update(client.mob)
	client.mob.hud_used.persistent_inventory_update(client.mob)

/datum/preference/choiced/antagOptIn_status
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "antagOptIn_status_pref"

/datum/preference/choiced/antagOptIn_status/init_possible_values()
	return list("Ask", "No", "Yes")

/datum/preference/choiced/antagOptIn_status/create_default_value()
	return "Ask"

/datum/preference/choiced/antagOptIn_status/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_antagOptIn_preferences)

/datum/preference/choiced/antagOptIn_status/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return "No"
	if(!preferences.read_preference(/datum/preference/toggle/master_antagOptIn_preferences))
		return "No"
	. = ..()

/datum/preference/choiced/antagOptIn_status/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/choiced/antagOptIn_status_mechanics
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "antagOptIn_status_pref_mechanics"

/datum/preference/choiced/antagOptIn_status_mechanics/init_possible_values()
	return list("Yes", "No", "Ask")

/datum/preference/choiced/antagOptIn_status_mechanics/create_default_value()
	return "Ask"

/datum/preference/choiced/antagOptIn_status_mechanics/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/master_antagOptIn_preferences)

/datum/preference/choiced/antagOptIn_status_mechanics/deserialize(input, datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_antagOptIn_preferences))
		return "None"
	if(!preferences.read_preference(/datum/preference/toggle/master_antagOptIn_preferences))
		return "None"
	. = ..()

/datum/preference/choiced/antagOptIn_status_mechanics/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

