/obj/item/organ/internal/ears/mutant
	name = "fluffy ears"
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"

/obj/item/organ/internal/ears/cat

/obj/item/organ/internal/ears/fox
/obj/item/organ/external/ears
	name = "fluffy ears"
	desc = "Wait, there's two pairs of these?"
	icon = 'icons/obj/clothing/head/costume.dmi'
	icon_state = "kitty"
	mutantpart_key = "ears"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("#FFAA00"))

	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_EXTERNAL_EARS

	bodypart_overlay = /datum/bodypart_overlay/mutant/ears

/datum/bodypart_overlay/mutant/ears
	feature_key = "ears"
	layers = EXTERNAL_FRONT | EXTERNAL_ADJACENT | EXTERNAL_BEHIND
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/ears/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/ears/get_global_feature_list()
	return GLOB.sprite_accessories["ears"]
