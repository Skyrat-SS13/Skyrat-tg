/// Legs
/datum/preference/choiced/digitigrade_legs
	savefile_key = "digitigrade_legs"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"


/datum/preference/choiced/digitigrade_legs/create_default_value()
	return "Normal Legs"


/datum/preference/choiced/digitigrade_legs/init_possible_values()
	return assoc_to_keys(GLOB.sprite_accessories["legs"])

/datum/preference/choiced/digitigrade_legs/is_accessible(datum/preferences/preferences)
	return ..() && is_usable(preferences)

/**
 * Actually rendered. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns if feature value is usable.
 *
 * Arguments:
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/digitigrade_legs/proc/is_usable(datum/preferences/preferences)
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type

	return (savefile_key in species.get_features()) \
		&& species.digitigrade_customization == DIGITIGRADE_OPTIONAL

/datum/preference/choiced/digitigrade_legs/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences || !is_usable(preferences))
		return FALSE

	target.dna.features["legs"] = value
	return TRUE
