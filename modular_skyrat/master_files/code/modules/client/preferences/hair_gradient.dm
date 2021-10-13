/datum/preference/choiced/hair_gradient
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "hair_gradient"

/datum/preference/choiced/hair_gradient/init_possible_values()
	return assoc_to_keys(GLOB.hair_gradients_list)

/datum/preference/choiced/hair_gradient/apply_to_human(mob/living/carbon/human/target, value)
	target.grad_style = value
	target.update_hair()

/datum/preference/color_legacy/hair_gradient
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "hair_gradient_color"


/datum/preference/color_legacy/hair_gradient/apply_to_human(mob/living/carbon/human/target, value)
	target.grad_color = value
	target.update_hair()

/datum/preference/color_legacy/eye_color/create_default_value()
	return random_color()
