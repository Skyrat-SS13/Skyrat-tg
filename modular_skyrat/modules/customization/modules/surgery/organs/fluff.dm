/obj/item/organ/external/fluff
	name = "fluff"
	desc = "Real fluffy."
	icon_state = "random_fly_1"

	mutantpart_key = "fluff"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Plain", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_FLUFF
	organ_flags = ORGAN_UNREMOVABLE

	preference = "feature_fluff"

	bodypart_overlay = /datum/bodypart_overlay/mutant/fluff

/datum/bodypart_overlay/mutant/fluff
	feature_key = "fluff"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/fluff/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/fluff/get_global_feature_list()
	return GLOB.sprite_accessories["fluff"]
