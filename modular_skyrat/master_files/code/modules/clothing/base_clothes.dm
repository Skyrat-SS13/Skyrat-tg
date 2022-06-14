// Mutant variants needs to be a property of all items, because all items can be equipped, despite the mob code only expecting clothing items (ugh)
/obj/item
	/// Icon file for mob worn overlays, if the user is digi.
	var/icon/worn_icon_digi
	/// The config type to use for greyscaled worn sprites for digitigrade characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_digi
	/// Icon file for mob worn overlays, if the user is a vox.
	var/icon/worn_icon_vox
	/// Icon file for mob worn overlays, if the user is a teshari.
	var/icon/worn_icon_teshari
	/// The config type to use for greyscaled worn sprites for Teshari characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_teshari
	/// The config type to use for greyscaled worn sprites for vox characters. Both this and greyscale_colors must be assigned to work.
	var/greyscale_config_worn_vox

	var/worn_icon_taur_snake
	var/worn_icon_taur_paw
	var/worn_icon_taur_hoof
	var/worn_icon_muzzled

	var/greyscale_config_worn_taur_snake
	var/greyscale_config_worn_taur_paw
	var/greyscale_config_worn_taur_hoof

	/// Used for BODYTYPE_CUSTOM: Needs to follow this syntax: a list() with the x and y coordinates of the pixel you want to get the color from. Colors are filled in as GAGs values for fallback.
	var/list/species_clothing_color_coords[3]

/obj/item/clothing/head
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION

/obj/item/clothing/mask
	supports_variations_flags = CLOTHING_SNOUTED_VARIATION | CLOTHING_SNOUTED_VOX_VARIATION

/obj/item/clothing/glasses
	supports_variations_flags = CLOTHING_SNOUTED_VOX_VARIATION

/obj/item/clothing/under
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/suit
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/shoes
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/changeling
	supports_variations_flags = NONE


