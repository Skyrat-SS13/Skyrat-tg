/obj/item/organ/external/tail
	mutantpart_key = "tail"
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))
	var/can_wag = TRUE
	var/wagging = FALSE

/datum/bodypart_overlay/mutant/tail
	color_source = ORGAN_COLOR_OVERRIDE

/datum/bodypart_overlay/mutant/tail/override_color(rgb_value)
	return draw_color

/datum/bodypart_overlay/mutant/tail/get_feature_key_for_overlay()
	return (wagging ? "wagging" : "") + feature_key

/datum/bodypart_overlay/mutant/tail/get_base_icon_state()
	return sprite_datum.icon_state

/datum/bodypart_overlay/mutant/tail/can_draw_on_bodypart(mob/living/carbon/human/wearer)
	var/list/used_in_turf = list("tail")
	// Emote exception
	if(wearer.owned_turf?.name in used_in_turf)
		return FALSE

	if(!wearer.w_uniform && !wearer.wear_suit)
		return ..()

	// Can hide if wearing uniform
	if(feature_key in wearer.try_hide_mutant_parts)
		return FALSE

	if(wearer.wear_suit)
		// Exception for MODs
		if(istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
			return TRUE

		// Hide accessory if flagged to do so
		else if(wearer.wear_suit.flags_inv & HIDETAIL)
			return FALSE

	return TRUE


/obj/item/organ/external/tail/Insert(mob/living/carbon/receiver, special, movement_flags)
	if(sprite_accessory_flags & SPRITE_ACCESSORY_WAG_ABLE)
		wag_flags |= WAG_ABLE
	return ..()

/obj/item/organ/external/tail/cat
	mutantpart_info = list(MUTANT_INDEX_NAME = "Cat", MUTANT_INDEX_COLOR_LIST = list("#FFAA00"))

/obj/item/organ/external/tail/monkey
	wag_flags = WAG_ABLE // waggable monkey tails
	mutantpart_info = list(MUTANT_INDEX_NAME = "Monkey", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF"))

/obj/item/organ/external/tail/lizard
	mutantpart_info = list(MUTANT_INDEX_NAME = "Smooth", MUTANT_INDEX_COLOR_LIST = list("#DDFFDD"))

/obj/item/organ/external/tail/fluffy
	name = "fluffy tail"

/obj/item/organ/external/tail/fluffy/no_wag
