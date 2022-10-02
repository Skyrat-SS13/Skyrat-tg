

/*
/mob/living/carbon/update_worn_head()
	remove_overlay(HEAD_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_HEAD) + 1]
		inv.update_icon()

	if(head)
		var/desired_icon = head.worn_icon
		var/used_style = NONE
		if(dna?.species.id == SPECIES_VOX)
			used_style = STYLE_VOX
		else if(dna?.species.mutant_bodyparts["snout"])
			var/datum/sprite_accessory/snouts/S = GLOB.sprite_accessories["snout"][dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME]]
			if(S.use_muzzled_sprites && head.supports_variations_flags & CLOTHING_SNOUTED_VARIATION)
				used_style = CLOTHING_SNOUTED_VARIATION
		else if(isteshari(src))
			used_style = STYLE_TESHARI
		switch(used_style)
			if(CLOTHING_SNOUTED_VARIATION)
				desired_icon = head.worn_icon_muzzled || 'modular_skyrat/master_files/icons/mob/clothing/head_muzzled.dmi'
			if(STYLE_VOX)
				desired_icon = head.worn_icon_vox || 'modular_skyrat/master_files/icons/mob/clothing/head_vox.dmi'
			if(STYLE_TESHARI)
				if(head.worn_icon_teshari)
					desired_icon = head.worn_icon_teshari
				else
					var/static/list/tesh_icon_states = icon_states(TESHARI_HEAD_ICON)
					if((head.worn_icon_state || head.icon_state) in tesh_icon_states)
						desired_icon = TESHARI_HEAD_ICON

		overlays_standing[HEAD_LAYER] = head.build_worn_icon(default_layer = HEAD_LAYER, default_icon_file = 'icons/mob/clothing/head.dmi', override_file = desired_icon, mutant_styles = used_style)
		update_hud_head(head)

	apply_overlay(HEAD_LAYER)

/mob/living/carbon/update_worn_mask()
	remove_overlay(FACEMASK_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //Decapitated
		return

	if(client && hud_used && hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_MASK) + 1]
		inv.update_icon()

	if(wear_mask)
		var/desired_icon = wear_mask.worn_icon
		var/used_style = NONE
		if(dna?.species.id == SPECIES_VOX)
			used_style = STYLE_VOX
		else if(dna?.species.mutant_bodyparts["snout"])
			var/datum/sprite_accessory/snouts/S = GLOB.sprite_accessories["snout"][dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME]]
			if(S.use_muzzled_sprites && wear_mask.supports_variations_flags & CLOTHING_SNOUTED_VARIATION)
				used_style = CLOTHING_SNOUTED_VARIATION
		else if(isteshari(src))
			used_style = STYLE_TESHARI

		switch(used_style)
			if(CLOTHING_SNOUTED_VARIATION)
				desired_icon = wear_mask.worn_icon_muzzled || 'modular_skyrat/master_files/icons/mob/clothing/mask_muzzled.dmi'
			if(STYLE_VOX)
				desired_icon = wear_mask.worn_icon_vox || 'modular_skyrat/master_files/icons/mob/clothing/mask_vox.dmi'
			if(STYLE_TESHARI)
				if(wear_mask.worn_icon_teshari)
					desired_icon = wear_mask.worn_icon_teshari
				else
					var/static/list/tesh_icon_states = icon_states(TESHARI_MASK_ICON)
					if((wear_mask.worn_icon_state || wear_mask.icon_state) in tesh_icon_states)
						desired_icon = TESHARI_MASK_ICON

		if(!(check_obscured_slots() & ITEM_SLOT_MASK))
			overlays_standing[FACEMASK_LAYER] = wear_mask.build_worn_icon(default_layer = FACEMASK_LAYER, default_icon_file = 'icons/mob/clothing/mask.dmi', override_file = desired_icon, mutant_styles = used_style)
		update_hud_wear_mask(wear_mask)

	apply_overlay(FACEMASK_LAYER)

/mob/living/carbon/update_inv_neck()
	remove_overlay(NECK_LAYER)

	if(client && hud_used?.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_NECK) + 1]
		inv.update_appearance()

	if(wear_neck)
		var/icon_file = wear_neck.worn_icon
		var/applied_styles = NONE
		if(isteshari(src))
			applied_styles = STYLE_TESHARI
			icon_file = TESHARI_NECK_ICON

		if(!(check_obscured_slots() & ITEM_SLOT_NECK))
			overlays_standing[NECK_LAYER] = wear_neck.build_worn_icon(default_layer = NECK_LAYER, default_icon_file = 'icons/mob/clothing/neck.dmi', override_file = icon_file, mutant_styles = applied_styles, species = dna.species.species_clothing_path)
		update_hud_neck(wear_neck)

	apply_overlay(NECK_LAYER)

/mob/living/carbon/update_worn_back()
	remove_overlay(BACK_LAYER)

	if(client && hud_used?.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_BACK) + 1]
		inv.update_appearance()

	if(back)
		var/icon_file = back.worn_icon
		var/applied_styles = NONE
		if(isteshari(src))
			var/static/list/tesh_icon_states = icon_states(TESHARI_BACK_ICON)
			if((back.worn_icon_state || back.icon_state) in tesh_icon_states)
				icon_file = TESHARI_BACK_ICON
				applied_styles = STYLE_TESHARI

		overlays_standing[BACK_LAYER] = back.build_worn_icon(default_layer = BACK_LAYER, default_icon_file = 'icons/mob/clothing/back.dmi', override_file = icon_file, mutant_styles = applied_styles)
		update_hud_back(back)

	apply_overlay(BACK_LAYER)
*/
