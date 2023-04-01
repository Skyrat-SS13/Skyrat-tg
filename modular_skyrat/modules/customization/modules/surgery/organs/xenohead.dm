/obj/item/organ/external/xenohead
	name = "xeno head"
	desc = "How did you take that off?"
	icon_state = "random_fly_2"

	mutantpart_key = "xenohead"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_XENOHEAD

	preference = "feature_xenohead"
	organ_flags = ORGAN_UNREMOVABLE

	bodypart_overlay = /datum/bodypart_overlay/mutant/xenohead

/datum/bodypart_overlay/mutant/xenohead
	feature_key = "xenohead"
	layers = EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/xenohead/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/xenohead/get_global_feature_list()
	return GLOB.sprite_accessories["xenohead"]
