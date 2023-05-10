/obj/item/organ/external/skrell_hair
	name = "skrell_hair"
	desc = "Hair isn't really the best way to describe it, but you really can't think of any other word that makes sense."
	icon_state = "random_fly_1"

	mutantpart_key = "skrell_hair"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Female", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_SKRELL_HAIR

	preference = "feature_skrell_hair"

	bodypart_overlay = /datum/bodypart_overlay/mutant/skrell_hair
	use_mob_sprite_as_obj_sprite = TRUE

/datum/bodypart_overlay/mutant/skrell_hair
	feature_key = "skrell_hair"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/skrell_hair/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/skrell_hair/get_global_feature_list()
	return GLOB.sprite_accessories["skrell_hair"]
