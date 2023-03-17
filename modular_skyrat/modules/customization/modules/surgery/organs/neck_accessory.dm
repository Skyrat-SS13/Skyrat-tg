/obj/item/organ/external/neck_accessory
	name = "neck accessory"
	desc = "It goes on the neck."
	icon_state = "random_fly_1"

	mutantpart_key = "neck_accessory"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Sylveon Neck Bow", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF")) // Change the default here whenever we get something else than this donator-only one.

	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_EXTERNAL_NECK_ACCESSORY
	organ_flags = ORGAN_UNREMOVABLE

	preference = "feature_neck_accessory"

	bodypart_overlay = /datum/bodypart_overlay/mutant/neck_accessory

/datum/bodypart_overlay/mutant/neck_accessory
	feature_key = "neck_accessory"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/neck_accessory/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/neck_accessory/get_global_feature_list()
	return GLOB.sprite_accessories["neck_accessory"]
