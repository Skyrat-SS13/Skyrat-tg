/obj/item/organ/external/pod_hair
	name = "podperson hair"
	desc = "Base for many-o-salads."

	mutantpart_key = "pod_hair"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Ivy", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_POD_HAIR

	bodypart_overlay = /datum/bodypart_overlay/mutant/pod_hair

/datum/bodypart_overlay/mutant/pod_hair
	feature_key = "pod_hair"
	layers = EXTERNAL_FRONT_OVER
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/pod_hair/override_color(rgb_value)
	return draw_color
