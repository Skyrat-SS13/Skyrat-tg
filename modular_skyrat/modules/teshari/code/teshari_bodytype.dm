#define MASK_SNOUT_EXTRA_OFFSET_X 1
#define MASK_SNOUT_EXTRA_OFFSET_Y 1

/obj/item
	var/datum/greyscale_config/greyscale_config_worn_teshari_fallback
	var/datum/greyscale_config/greyscale_config_worn_teshari_fallback_skirt

/datum/species/teshari/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_teshari

/datum/species/teshari/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_teshari = icon

/datum/species/teshari/get_custom_worn_config_fallback(item_slot, obj/item/item)
	// skirt support
	if(istype(item, /obj/item/clothing/under) && !(item.body_parts_covered & LEGS))
		return item.greyscale_config_worn_teshari_fallback_skirt

	return item.greyscale_config_worn_teshari_fallback

/datum/species/teshari/generate_custom_worn_icon(item_slot, obj/item/item)
	. = ..()
	if(.)
		return

	// Use the fancy fallback sprites.
	. = generate_custom_worn_icon_fallback(item_slot, item)
	if(.)
		return

	// If there isn't even a fallback, use snouted sprites for masks and helmets, but offsetted
	if((item_slot == LOADOUT_ITEM_MASK || item_slot == LOADOUT_ITEM_HEAD) && (item.supports_variations_flags & CLOTHING_SNOUTED_VARIATION))
		var/human_icon
		var/offset_x
		var/offset_y
		var/human_icon_state = item.worn_icon_state || item.icon_state
		if(item_slot == LOADOUT_ITEM_HEAD)
			human_icon = item.worn_icon_muzzled || SNOUTED_HEAD_FILE
			offset_x = offset_features[OFFSET_HEAD][1]
			offset_y = offset_features[OFFSET_HEAD][2]
		else
			human_icon = item.worn_icon_muzzled || SNOUTED_MASK_FILE
			offset_x = offset_features[OFFSET_FACEMASK][1] + MASK_SNOUT_EXTRA_OFFSET_X
			offset_y = offset_features[OFFSET_FACEMASK][2] + MASK_SNOUT_EXTRA_OFFSET_Y

		// Did the snout variation flag lie to us?
		if(!icon_exists(human_icon, human_icon_state))
			return

		// Use already resolved icon
		use_custom_worn_icon_cached()
		var/icon/cached_icon = get_custom_worn_icon_cached(human_icon, human_icon_state, "m")
		if(cached_icon)
			return cached_icon

		// Generate muzzled icon, but offset
		var/icon/new_icon = icon('icons/blanks/32x32.dmi', "nothing")
		new_icon.Blend( icon(human_icon, human_icon_state), ICON_OVERLAY, x = offset_x, y = offset_y)
		new_icon.Insert(new_icon, human_icon_state)
		set_custom_worn_icon_cached(human_icon, human_icon_state, "m", new_icon)
		return new_icon

#undef MASK_SNOUT_EXTRA_OFFSET_X
#undef MASK_SNOUT_EXTRA_OFFSET_Y
