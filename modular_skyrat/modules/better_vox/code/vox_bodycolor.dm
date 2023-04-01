/datum/preference/choiced/vox_bodycolor
	savefile_key = "vox_bodycolor"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES

/datum/preference/choiced/vox_bodycolor/init_possible_values()
	return list("default", "darkteal", "yellow", "albino", "brown")

/datum/preference/choiced/vox_bodycolor/create_default_value()
	return "default"

/datum/preference/choiced/vox_bodycolor/is_accessible(datum/preferences/preferences)
	. = ..()
	if(!.)
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)

	return species_type == /datum/species/vox_primalis

/datum/preference/choiced/vox_bodycolor/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_bodycolor"] = value

