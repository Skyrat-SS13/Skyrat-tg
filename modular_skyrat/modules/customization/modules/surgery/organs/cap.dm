/obj/item/organ/external/cap
	name = "fungal cap"
	desc = "Real. No cap."
	icon_state = "random_fly_1"

	mutantpart_key = "caps"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Round", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_CAP

	preference = "feature_caps"

	bodypart_overlay = /datum/bodypart_overlay/mutant/cap
	use_mob_sprite_as_obj_sprite = TRUE

/datum/bodypart_overlay/mutant/cap
	feature_key = "caps"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/cap/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/cap/get_global_feature_list()
	return GLOB.sprite_accessories["caps"]
