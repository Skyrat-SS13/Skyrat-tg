/obj/item/organ/external/head_accessory
	name = "head accessory"
	desc = "It goes on the head."
	icon_state = "random_fly_1"

	mutantpart_key = "head_accessory"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Sylveon Head Bow", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF")) // Change the default here whenever we get something else than this donator-only one.

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_HEAD_ACCESSORY
	organ_flags = ORGAN_UNREMOVABLE

	preference = "feature_head_accessory"

	bodypart_overlay = /datum/bodypart_overlay/mutant/head_accessory

/datum/bodypart_overlay/mutant/head_accessory
	feature_key = "head_accessory"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/head_accessory/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/head_accessory/get_global_feature_list()
	return GLOB.sprite_accessories["head_accessory"]
