/obj/item/organ/external/tail
	mutantpart_key = "tail"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	var/can_wag = TRUE
	var/wagging = FALSE

/datum/bodypart_overlay/mutant/tail
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/tail/override_color(rgb_value)
	return draw_color

/obj/item/organ/external/tail/Insert(mob/living/carbon/reciever, special, drop_if_replaced)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_WAG_ABLE)
		wag_flags |= WAG_ABLE
	return ..()

/obj/item/organ/external/tail/cat
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("#FFAA00"))

/obj/item/organ/external/tail/monkey
	mutantpart_info = list(MUTANT_INDEX_NAME = "Monkey", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/obj/item/organ/external/tail/lizard
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#DDFFDD"))

/obj/item/organ/external/tail/fluffy
	name = "fluffy tail"

/obj/item/organ/external/tail/fluffy/no_wag
