/obj/item/organ/external/tail
	mutantpart_key = "tail"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	var/can_wag = TRUE
	var/wagging = FALSE
	color_source = ORGAN_COLOR_OVERRIDE

/obj/item/organ/external/tail/override_color(rgb_value)
	if(mutantpart_key)
		return mutantpart_info[MUTANT_INDEX_COLOR_LIST][1]

	return rgb_value

/obj/item/organ/external/tail/Insert(mob/living/carbon/reciever, special, drop_if_replaced)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_WAG_ABLE)
		wag_flags |= WAG_ABLE
	return ..()

/obj/item/organ/external/tail/cat
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("#FFAA00"))
	color_source = ORGAN_COLOR_OVERRIDE

/obj/item/organ/external/tail/monkey
	mutantpart_info = list(MUTANT_INDEX_NAME = "Monkey", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/obj/item/organ/external/tail/lizard
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#DDFFDD"))

/obj/item/organ/external/tail/fluffy
	name = "fluffy tail"

/obj/item/organ/external/tail/fluffy/no_wag
