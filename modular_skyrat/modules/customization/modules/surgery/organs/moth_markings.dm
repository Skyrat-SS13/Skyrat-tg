/obj/item/organ/external/moth_markings
	name = "moth markings"
	desc = "How did you even get that off...?"
	icon_state = "random_fly_2"

	mutantpart_key = "moth_markings"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_MOTH_MARKINGS
	organ_flags = ORGAN_UNREMOVABLE

	preference = "feature_moth_markings"

	bodypart_overlay = /datum/bodypart_overlay/mutant/moth_markings

/datum/bodypart_overlay/mutant/moth_markings
	feature_key = "moth_markings"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/moth_markings/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/moth_markings/get_global_feature_list()
	return GLOB.sprite_accessories["moth_markings"]
