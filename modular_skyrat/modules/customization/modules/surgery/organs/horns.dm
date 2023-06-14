/obj/item/organ/external/horns
	desc = "Why do some people even have horns? Well, this one obviously doesn't."
	preference = "feature_horns"
	mutantpart_key = "horns"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Simple", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/datum/bodypart_overlay/mutant/horns
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	feature_key = "horns"
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/horns/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/horns/can_draw_on_bodypart(mob/living/carbon/human/human)
	return !sprite_datum.is_hidden(human)
