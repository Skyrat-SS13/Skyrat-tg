/obj/item/organ/external/pod_hair
	name = "podperson hair"
	desc = "Base for many-o-salads."

	mutantpart_key = "pod_hair"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Ivy", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_POD_HAIR

	preference = "feature_pod_hair"
	use_mob_sprite_as_obj_sprite = TRUE

	dna_block = DNA_POD_HAIR_BLOCK
	restyle_flags = EXTERNAL_RESTYLE_PLANT

	bodypart_overlay = /datum/bodypart_overlay/mutant/pod_hair

/datum/bodypart_overlay/mutant/pod_hair
	feature_key = "pod_hair"
	layers = EXTERNAL_FRONT_OVER
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/pod_hair/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/pod_hair/get_global_feature_list()
	return GLOB.sprite_accessories["pod_hair"]
