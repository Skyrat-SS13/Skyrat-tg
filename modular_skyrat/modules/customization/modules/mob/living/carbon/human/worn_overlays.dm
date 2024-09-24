/**
 * Setup the final version of accessory_overlay given custom species options.
 */
/obj/item/clothing/under/proc/modify_accessory_overlay()
	if(!ishuman(loc))
		return accessory_overlay

	var/mob/living/carbon/human/human_wearer = loc

	// Handle custom_worn_icons[OFFSET_ACCESSORY]
	if(OFFSET_ACCESSORY in human_wearer.dna.species.custom_worn_icons)
		var/icon/custom_accessory_icon = human_wearer.dna.species.custom_worn_icons[OFFSET_ACCESSORY]

		var/list/custom_accessory_states = icon_states(custom_accessory_icon)
		if(accessory_overlay.icon_state in custom_accessory_states)
			// Make new appearance so we don't break the real accessory overlay for other species, and treat it as final.
			return mutable_appearance(custom_accessory_icon, accessory_overlay.icon_state)

	var/obj/item/bodypart/chest/my_chest = human_wearer.get_bodypart(BODY_ZONE_CHEST)
	my_chest?.worn_accessory_offset?.apply_offset(accessory_overlay)

	return accessory_overlay
