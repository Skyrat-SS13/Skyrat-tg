/obj/item/organ/external/synth_antenna
	name = "synth antenna"
	desc = "Wonder if we'll catch Syndicate frequencies with these..."
	icon_state = "random_fly_1"

	mutantpart_key = MUTANT_SYNTH_ANTENNA
	mutantpart_info = list(MUTANT_INDEX_NAME = "Plain", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_SYNTH_ANTENNA

	preference = "feature_ipc_antenna"

	bodypart_overlay = /datum/bodypart_overlay/mutant/synth_antenna
	use_mob_sprite_as_obj_sprite = TRUE

/datum/bodypart_overlay/mutant/synth_antenna
	feature_key = MUTANT_SYNTH_ANTENNA
	layers = EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/synth_antenna/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/synth_antenna/get_global_feature_list()
	return GLOB.sprite_accessories[MUTANT_SYNTH_ANTENNA]
