/**
 * Setup the final version of accessory_overlay given custom species options.
 */
/obj/item/clothing/under/proc/modify_accessory_overlay()
	if(!ishuman(loc))
		return accessory_overlay

	var/mob/living/carbon/human/human_wearer = loc

	// Handle custom_worn_icons[LOADOUT_ITEM_ACCESSORY]
	if(LOADOUT_ITEM_ACCESSORY in human_wearer.dna.species.custom_worn_icons)
		var/icon/custom_accessory_icon = human_wearer.dna.species.custom_worn_icons[LOADOUT_ITEM_ACCESSORY]

		var/list/custom_accessory_states = icon_states(custom_accessory_icon)
		if(accessory_overlay.icon_state in custom_accessory_states)
			// Make new appearance so we don't break the real accessory overlay for other species, and treat it as final.
			return mutable_appearance(custom_accessory_icon, accessory_overlay.icon_state)

	// Apply an offset only if we didn't apply a different appearance.
	if(OFFSET_ACCESSORY in human_wearer.dna.species.offset_features)
		accessory_overlay.pixel_x = human_wearer.dna.species.offset_features[OFFSET_ACCESSORY][1]
		accessory_overlay.pixel_y = human_wearer.dna.species.offset_features[OFFSET_ACCESSORY][2]
	else
		accessory_overlay.pixel_x = 0
		accessory_overlay.pixel_y = 0

	return accessory_overlay
