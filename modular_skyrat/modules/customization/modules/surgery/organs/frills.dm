/obj/item/organ/external/frills
	preference = "feature_frills"
	mutantpart_key = "frills"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Divinity", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/datum/bodypart_overlay/mutant/frills
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/frills/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/frills/can_draw_on_bodypart(mob/living/carbon/human/human)
	return !sprite_datum.is_hidden(human)

/datum/bodypart_overlay/mutant/frills/get_global_feature_list()
	return GLOB.sprite_accessories["frills"]
