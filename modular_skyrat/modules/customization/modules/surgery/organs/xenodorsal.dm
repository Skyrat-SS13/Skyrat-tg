/obj/item/organ/external/xenodorsal
	name = "dorsal spines"
	desc = "How did that even fit on them...?"
	icon_state = "random_fly_2"

	mutantpart_key = "xenodorsal"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Standard", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_XENODORSAL

	preference = "feature_xenodorsal"

	bodypart_overlay = /datum/bodypart_overlay/mutant/xenodorsal

/datum/bodypart_overlay/mutant/xenodorsal
	feature_key = "xenodorsal"
	layers = EXTERNAL_FRONT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/xenodorsal/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/xenodorsal/get_global_feature_list()
	return GLOB.sprite_accessories["xenodorsal"]
