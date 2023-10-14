/// Entries with this interface type will be made into a checkmark.
#define DC_CONFIG_INTERFACE_BOOLEAN "boolean"
/// Entries with this interface type will be made into a numeric input.
#define DC_CONFIG_INTERFACE_NUMERIC "numeric"

/datum/preference_middleware/death_consequences_config
	action_delegations = list(
		"dc_pref_changed" = PROC_REF(value_changed)
	)


/datum/preference_middleware/death_consequences_config/proc/value_changed(list/params)

	var/value = params["new_value"]
	if (isnull(value))
		return FALSE
	var/interface_type = params["interface_type"]
	if (isnull(interface_type))
		return FALSE

	var/stringified_typepath = params["typepath"]
	if (isnull(stringified_typepath))
		return FALSE
	var/datum/preference/preference_typepath = text2path(stringified_typepath)
	if (!(preference_typepath in GLOB.death_consequences_prefs))
		return FALSE

	var/datum/preference/preference_instance = GLOB.preference_entries[preference_typepath]
	if (isnull(preference_instance))
		return FALSE

	preferences.write_preference(preference_instance, value) // already sanity checked by the preferences

	return TRUE


/datum/preference_middleware/death_consequences_config/get_ui_data(mob/user)
	var/list/data = list("dc_preferences" = list())

	for (var/datum/preference/dc_pref_type as anything in GLOB.death_consequences_prefs)
		var/datum/preference/dc_pref_instance = GLOB.preference_entries[dc_pref_type]
		var/min_value
		var/max_value
		var/step
		if (istype(dc_pref_instance, /datum/preference/numeric))
			var/datum/preference/numeric/numeric_instance = dc_pref_instance
			min_value = numeric_instance.minimum
			max_value = numeric_instance.maximum
			step = numeric_instance.step
		data["dc_preferences"] += list(list(
			"name" = dc_pref_instance.config_name,
			"desc" = dc_pref_instance.config_desc,
			"value" = preferences.read_preference(dc_pref_type),
			"typepath" = dc_pref_type, // TODO: name, typepath, interface, everything except value, can all be put on static data
			// problem: how? i dont fully understand normal and static data, like, wouldnt it just form two different lists and confuse javascript?
			"interface_type" = get_interface_of_dc_preference(dc_pref_instance),
			"min_value" = min_value,
			"max_value" = max_value,
			"step" = step,
		))

	return data


/datum/preference_middleware/death_consequences_config/proc/get_interface_of_dc_preference(datum/preference/dc_pref_instance)
	if (istype(dc_pref_instance, /datum/preference/toggle))
		return DC_CONFIG_INTERFACE_BOOLEAN
	else if (istype(dc_pref_instance, /datum/preference/numeric))
		return DC_CONFIG_INTERFACE_NUMERIC

#undef DC_CONFIG_INTERFACE_BOOLEAN
#undef DC_CONFIG_INTERFACE_NUMERIC
