<<<<<<< HEAD
/* SKYRAT EDIT REMOVAL
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
/datum/preference/choiced/mushroom_cap
	savefile_key = "feature_mushperson_cap"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
<<<<<<< HEAD
	relevant_mutant_bodypart = "cap"

/datum/preference/choiced/mushroom_cap/init_possible_values()
	return assoc_to_keys_features(GLOB.caps_list)

/datum/preference/choiced/mushroom_cap/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["caps"] = value
*/
=======
	relevant_external_organ = /obj/item/organ/external/mushroom_cap

/datum/preference/choiced/mushroom_cap/init_possible_values()
	return assoc_to_keys_features(SSaccessories.caps_list)

/datum/preference/choiced/mushroom_cap/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["caps"] = value
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
