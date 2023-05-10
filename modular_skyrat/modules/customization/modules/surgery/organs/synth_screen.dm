/obj/item/organ/external/synth_screen
	name = "synth screen"
	desc = "Surely that's just a bunch of LEDs and not a retro-projected screen, right? Right...?"
	icon_state = "tonguerobot"

	mutantpart_key = MUTANT_SYNTH_SCREEN
	mutantpart_info = list(MUTANT_INDEX_NAME = "Blank", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_SYNTH_SCREEN

	preference = "feature_ipc_screen"

	bodypart_overlay = /datum/bodypart_overlay/mutant/synth_screen
	use_mob_sprite_as_obj_sprite = TRUE

/datum/bodypart_overlay/mutant/synth_screen
	feature_key = MUTANT_SYNTH_SCREEN
	layers = EXTERNAL_FRONT_UNDER_CLOTHES
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/synth_screen/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/synth_screen/get_global_feature_list()
	return GLOB.sprite_accessories[MUTANT_SYNTH_SCREEN]
