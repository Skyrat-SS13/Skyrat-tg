<<<<<<< HEAD
/* SKYRAT EDIT REMOVAL
/datum/preference/color_legacy/mutant_color
=======
/datum/preference/color/mutant_color
>>>>>>> 694c2999b08 (makes it so the sanitize_hexcolors' default is 6 characters rather than 3 and gets rid of color_legacy (#61980))
	savefile_key = "feature_mcolor"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_species_trait = MUTCOLORS

/datum/preference/color/mutant_color/create_default_value()
	return sanitize_hexcolor("[pick("7F", "FF")][pick("7F", "FF")][pick("7F", "FF")]")

/datum/preference/color/mutant_color/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["mcolor"] = value

/datum/preference/color/mutant_color/is_valid(value)
	if (!..(value))
		return FALSE

	if (is_color_dark(value))
		return FALSE

	return TRUE
*/
