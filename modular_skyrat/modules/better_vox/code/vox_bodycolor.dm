/datum/preference/choiced/vox_bodycolor
	savefile_key = "vox_bodycolor"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_species_trait = SPECIES_VOX

/datum/preference/choiced/vox_bodycolor/init_possible_values()
	return list("darkteal", "green", "yellow", "albino", "brown")

/datum/preference/choiced/vox_bodycolor/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["vox_bodycolor"] = value

