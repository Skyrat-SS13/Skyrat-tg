/* SKYRAT EDIT REMOVAL
/proc/generate_lizard_side_shot(datum/sprite_accessory/sprite_accessory, key, include_snout = TRUE)
	var/static/icon/lizard
	var/static/icon/lizard_with_snout

	if (isnull(lizard))
		lizard = icon('icons/mob/human/species/lizard/bodyparts.dmi', "lizard_head", EAST)
		var/icon/eyes = icon('icons/mob/human/human_face.dmi', "eyes", EAST)
		eyes.Blend(COLOR_GRAY, ICON_MULTIPLY)
		lizard.Blend(eyes, ICON_OVERLAY)

		lizard_with_snout = icon(lizard)
		lizard_with_snout.Blend(icon('icons/mob/human/species/lizard/lizard_misc.dmi', "m_snout_round_ADJ", EAST), ICON_OVERLAY)

	var/icon/final_icon = include_snout ? icon(lizard_with_snout) : icon(lizard)

	if (!isnull(sprite_accessory))
		var/icon/accessory_icon = icon(sprite_accessory.icon, "m_[key]_[sprite_accessory.icon_state]_ADJ", EAST)
		final_icon.Blend(accessory_icon, ICON_OVERLAY)

	final_icon.Crop(11, 20, 23, 32)
	final_icon.Scale(32, 32)
	final_icon.Blend(COLOR_VIBRANT_LIME, ICON_MULTIPLY)

	return final_icon

/datum/preference/choiced/lizard_body_markings
	savefile_key = "feature_lizard_body_markings"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Body markings"
	should_generate_icons = TRUE
	relevant_body_markings = /datum/bodypart_overlay/simple/body_marking/lizard

/datum/preference/choiced/lizard_body_markings/init_possible_values()
	return assoc_to_keys_features(SSaccessories.lizard_markings_list)

/datum/preference/choiced/lizard_body_markings/icon_for(value)
	var/datum/sprite_accessory/sprite_accessory = SSaccessories.lizard_markings_list[value]

	var/icon/final_icon = icon('icons/mob/human/species/lizard/bodyparts.dmi', "lizard_chest_m")

	if (sprite_accessory.icon_state != "none")
		var/icon/body_markings_icon = icon(
			'icons/mob/human/species/lizard/lizard_misc.dmi',
			"male_[sprite_accessory.icon_state]_chest",
		)

		final_icon.Blend(body_markings_icon, ICON_OVERLAY)

	final_icon.Blend(COLOR_VIBRANT_LIME, ICON_MULTIPLY)
	final_icon.Crop(10, 8, 22, 23)
	final_icon.Scale(26, 32)
	final_icon.Crop(-2, 1, 29, 32)

	return final_icon

/datum/preference/choiced/lizard_body_markings/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["lizard_markings"] = value

/datum/preference/choiced/lizard_frills
	savefile_key = "feature_lizard_frills"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Frills"
	should_generate_icons = TRUE

/datum/preference/choiced/lizard_frills/init_possible_values()
	return assoc_to_keys_features(SSaccessories.frills_list)

/datum/preference/choiced/lizard_frills/icon_for(value)
	return generate_lizard_side_shot(SSaccessories.frills_list[value], "frills")

/datum/preference/choiced/lizard_frills/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["frills"] = value

/datum/preference/choiced/lizard_horns
	savefile_key = "feature_lizard_horns"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Horns"
	should_generate_icons = TRUE

/datum/preference/choiced/lizard_horns/init_possible_values()
	return assoc_to_keys_features(SSaccessories.horns_list)

/datum/preference/choiced/lizard_horns/icon_for(value)
	return generate_lizard_side_shot(SSaccessories.horns_list[value], "horns")

/datum/preference/choiced/lizard_horns/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["horns"] = value

/datum/preference/choiced/lizard_legs
	savefile_key = "feature_lizard_legs"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "legs"

/datum/preference/choiced/lizard_legs/init_possible_values()
	return assoc_to_keys_features(SSaccessories.legs_list)

/datum/preference/choiced/lizard_legs/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["legs"] = value

/datum/preference/choiced/lizard_snout
	savefile_key = "feature_lizard_snout"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_FEATURES
	main_feature_name = "Snout"
	should_generate_icons = TRUE

/datum/preference/choiced/lizard_snout/init_possible_values()
	return assoc_to_keys_features(SSaccessories.snouts_list)

/datum/preference/choiced/lizard_snout/icon_for(value)
	return generate_lizard_side_shot(SSaccessories.snouts_list[value], "snout", include_snout = FALSE)

/datum/preference/choiced/lizard_snout/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["snout"] = value

/datum/preference/choiced/lizard_spines
	savefile_key = "feature_lizard_spines"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = "spines"

/datum/preference/choiced/lizard_spines/init_possible_values()
	return assoc_to_keys_features(SSaccessories.spines_list)

/datum/preference/choiced/lizard_spines/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["spines"] = value

/datum/preference/choiced/lizard_tail
	savefile_key = "feature_lizard_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_external_organ = /obj/item/organ/external/tail/lizard

/datum/preference/choiced/lizard_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_lizard)

/datum/preference/choiced/lizard_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_lizard"] = value

/datum/preference/choiced/lizard_tail/create_default_value()
	var/datum/sprite_accessory/tails/lizard/smooth/tail = /datum/sprite_accessory/tails/lizard/smooth
	return initial(tail.name)
*/
