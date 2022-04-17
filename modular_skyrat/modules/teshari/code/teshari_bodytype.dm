/obj/item/clothing
	var/datum/greyscale_config/greyscale_config_worn_teshari_fallback
	var/datum/greyscale_config/greyscale_config_worn_teshari_fallback_skirt

/datum/species/teshari/get_custom_worn_icon(item_slot, obj/item/item)
	return item.worn_icon_teshari

/datum/species/teshari/set_custom_worn_icon(item_slot, obj/item/item, icon/icon)
	item.worn_icon_teshari = icon

/datum/species/teshari/get_custom_worn_config_fallback(item_slot, obj/item/item)
	var/obj/item/clothing/clothing = item
	if(!istype(clothing))
		return null

	// skirt support
	if(istype(clothing, /obj/item/clothing/under) && !(clothing.body_parts_covered & LEGS))
		return clothing.greyscale_config_worn_teshari_fallback_skirt

	return clothing.greyscale_config_worn_teshari_fallback

/datum/species/teshari/generate_custom_worn_icon(item_slot, obj/item/item)
	. = ..()
	if(.)
		return

	// Use the fancy fallback sprites.
	if(istype(item, /obj/item/clothing))
		return generate_custom_worn_icon_fallback(item_slot, item)
