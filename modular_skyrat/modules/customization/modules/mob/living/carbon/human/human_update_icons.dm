//used when putting/removing clothes that hide certain mutant body parts to just update those and not update the whole body.
/mob/living/carbon/human/proc/update_mutant_bodyparts(force_update=FALSE)
	dna.species.handle_mutant_bodyparts(src, force_update = force_update)
	update_body_parts() // basically a better and cooler handle_mutant_bodyparts (at least until handle_mutant_bodyparts is annihilated)
/mob/living/carbon/human/update_inv_w_uniform()
	remove_overlay(UNIFORM_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_ICLOTHING) + 1]
		inv.update_icon()

	if(istype(w_uniform, /obj/item/clothing/under))
		var/obj/item/clothing/under/U = w_uniform
		U.screen_loc = ui_iclothing
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += w_uniform
		update_observer_view(w_uniform,1)

		if(wear_suit && (wear_suit.flags_inv & HIDEJUMPSUIT))
			return

		var/applied_style = NONE
		var/icon_file = w_uniform.worn_icon
		if(dna.species.mutant_bodyparts["taur"])
			var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
			if(w_uniform.mutant_variants & S.taur_mode)
				applied_style = S.taur_mode
			else if(w_uniform.mutant_variants & S.alt_taur_mode)
				applied_style = S.alt_taur_mode
		if(!applied_style)
			if((w_uniform.mutant_variants & STYLE_VOX) && dna.species.id == "vox")
				applied_style = STYLE_VOX
			else if((DIGITIGRADE in dna.species.species_traits) && (w_uniform.mutant_variants & STYLE_DIGITIGRADE))
				applied_style = STYLE_DIGITIGRADE
			else if(isteshari(src))
				applied_style = STYLE_TESHARI

		var/x_override
		switch(applied_style)
			if(STYLE_DIGITIGRADE)
				icon_file = w_uniform.worn_icon_digi || 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
			if(STYLE_TAUR_SNAKE)
				icon_file = w_uniform.worn_icon_taur_snake || 'modular_skyrat/master_files/icons/mob/clothing/uniform_taur_snake.dmi'
			if(STYLE_TAUR_HOOF)
				icon_file = w_uniform.worn_icon_taur_hoof || 'modular_skyrat/master_files/icons/mob/clothing/uniform_taur_hoof.dmi'
			if(STYLE_TAUR_PAW)
				icon_file = w_uniform.worn_icon_taur_paw || 'modular_skyrat/master_files/icons/mob/clothing/uniform_taur_paw.dmi'
			if(STYLE_VOX)
				icon_file = w_uniform.worn_icon_vox || 'modular_skyrat/master_files/icons/mob/clothing/species/vox/uniform.dmi'
			if(STYLE_TESHARI)
				icon_file = TESHARI_UNIFORM_ICON

		if(applied_style & STYLE_TAUR_ALL)
			x_override = 64

		var/target_overlay = U.icon_state
		if(U.adjusted == ALT_STYLE)
			target_overlay = "[target_overlay]_d"


		var/mutable_appearance/uniform_overlay

		if(dna && dna.species.sexes && !applied_style)
			if(body_type == FEMALE && U.fitted != NO_FEMALE_UNIFORM)
				uniform_overlay = U.build_worn_icon(default_layer = UNIFORM_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, femaleuniform = U.fitted, override_state = target_overlay, override_icon = icon_file, override_x_center = x_override, mutant_styles = applied_style, species = dna.species.species_clothing_path)

		if(!uniform_overlay)
			uniform_overlay = U.build_worn_icon(default_layer = UNIFORM_LAYER, default_icon_file = 'icons/mob/clothing/under/default.dmi', isinhands = FALSE, override_state = target_overlay, override_icon = icon_file, override_x_center = x_override, mutant_styles = applied_style, species = dna.species.species_clothing_path)

		if(U.accessory_overlay)
			var/special_accessory_style = FALSE
			if(applied_style == STYLE_TESHARI)
				var/static/list/teshari_accessory_states = icon_states(TESHARI_ACCESSORIES_ICON)
				if(U.accessory_overlay.icon_state in teshari_accessory_states)
					U.accessory_overlay.icon = TESHARI_ACCESSORIES_ICON
					special_accessory_style = TRUE
			// Apply an offset only if we didn't apply a special accessory style.
			if(!special_accessory_style && (OFFSET_ACCESSORY in dna.species.offset_features))
				U.accessory_overlay.pixel_x = dna.species.offset_features[OFFSET_ACCESSORY][1]
				U.accessory_overlay.pixel_y = dna.species.offset_features[OFFSET_ACCESSORY][2]

		if(OFFSET_UNIFORM in dna.species.offset_features)
			uniform_overlay.pixel_x += dna.species.offset_features[OFFSET_UNIFORM][1]
			uniform_overlay.pixel_y += dna.species.offset_features[OFFSET_UNIFORM][2]

		overlays_standing[UNIFORM_LAYER] = uniform_overlay

	apply_overlay(UNIFORM_LAYER)
	update_mutant_bodyparts()

/mob/living/carbon/human/update_inv_wear_suit()
	remove_overlay(SUIT_LAYER)

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_OCLOTHING) + 1]
		inv.update_icon()

	if(istype(wear_suit, /obj/item/clothing/suit))
		wear_suit.screen_loc = ui_oclothing
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += wear_suit
		update_observer_view(wear_suit,1)
		var/icon_file = wear_suit.worn_icon
		var/applied_style = NONE
		if(dna.species.mutant_bodyparts["taur"])
			var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
			if(wear_suit.mutant_variants & S.taur_mode)
				applied_style = S.taur_mode
			else if(wear_suit.mutant_variants & S.alt_taur_mode)
				applied_style = S.alt_taur_mode
		if(!applied_style)
			if((wear_suit.mutant_variants & STYLE_VOX) && dna.species.id == "vox")
				applied_style = STYLE_VOX
			else if((DIGITIGRADE in dna.species.species_traits) && (wear_suit.mutant_variants & STYLE_DIGITIGRADE))
				applied_style = STYLE_DIGITIGRADE
			else if(isteshari(src))
				applied_style = STYLE_TESHARI

		var/x_override
		switch(applied_style)
			if(STYLE_DIGITIGRADE)
				icon_file = wear_suit.worn_icon_digi || 'modular_skyrat/master_files/icons/mob/clothing/suit_digi.dmi'
			if(STYLE_TAUR_SNAKE)
				icon_file = wear_suit.worn_icon_taur_snake || 'modular_skyrat/master_files/icons/mob/clothing/suit_taur_snake.dmi'
			if(STYLE_TAUR_HOOF)
				icon_file = wear_suit.worn_icon_taur_hoof || 'modular_skyrat/master_files/icons/mob/clothing/suit_taur_hoof.dmi'
			if(STYLE_TAUR_PAW)
				icon_file = wear_suit.worn_icon_taur_paw || 'modular_skyrat/master_files/icons/mob/clothing/suit_taur_paw.dmi'
			if(STYLE_VOX)
				icon_file = wear_suit.worn_icon_vox || 'modular_skyrat/master_files/icons/mob/clothing/species/vox/suit.dmi'
			if(STYLE_TESHARI)
				icon_file = TESHARI_SUIT_ICON

		if(applied_style & STYLE_TAUR_ALL)
			x_override = 64

		overlays_standing[SUIT_LAYER] = wear_suit.build_worn_icon(default_layer = SUIT_LAYER, default_icon_file = 'icons/mob/clothing/suit.dmi', override_icon = icon_file, override_x_center = x_override, mutant_styles = applied_style, species = dna.species.species_clothing_path)
		var/mutable_appearance/suit_overlay = overlays_standing[SUIT_LAYER]
		if(OFFSET_SUIT in dna.species.offset_features)
			suit_overlay.pixel_x += dna.species.offset_features[OFFSET_SUIT][1]
			suit_overlay.pixel_y += dna.species.offset_features[OFFSET_SUIT][2]
		overlays_standing[SUIT_LAYER] = suit_overlay
	update_hair()
	update_mutant_bodyparts()

	apply_overlay(SUIT_LAYER)

/mob/living/carbon/human/update_inv_shoes()
	remove_overlay(SHOES_LAYER)

	if(dna.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(S.hide_legs)
			return

	if(num_legs<2)
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_FEET) + 1]
		inv.update_icon()

	if(shoes)
		shoes.screen_loc = ui_shoes					//move the item to the appropriate screen loc
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open
				client.screen += shoes					//add it to client's screen
		update_observer_view(shoes,1)
		var/icon_file = shoes.worn_icon
		var/applied_styles = NONE
		if((shoes.mutant_variants & STYLE_VOX) && dna.species.id == "vox")
			applied_styles = STYLE_VOX
			icon_file = shoes.worn_icon_vox || 'modular_skyrat/master_files/icons/mob/clothing/species/vox/feet.dmi'
		else if((DIGITIGRADE in dna.species.species_traits) && (shoes.mutant_variants & STYLE_DIGITIGRADE))
			applied_styles = STYLE_DIGITIGRADE
			icon_file = shoes.worn_icon_digi || 'modular_skyrat/master_files/icons/mob/clothing/feet_digi.dmi'
		else if(isteshari(src))
			applied_styles = STYLE_TESHARI
			icon_file = TESHARI_FEET_ICON

		overlays_standing[SHOES_LAYER] = shoes.build_worn_icon(default_layer = SHOES_LAYER, default_icon_file = 'icons/mob/clothing/feet.dmi', override_icon = icon_file, mutant_styles = applied_styles, species = dna.species.species_clothing_path)
		var/mutable_appearance/shoes_overlay = overlays_standing[SHOES_LAYER]
		if(OFFSET_SHOES in dna.species.offset_features)
			shoes_overlay.pixel_x += dna.species.offset_features[OFFSET_SHOES][1]
			shoes_overlay.pixel_y += dna.species.offset_features[OFFSET_SHOES][2]
		overlays_standing[SHOES_LAYER] = shoes_overlay

	apply_overlay(SHOES_LAYER)

/mob/living/carbon/human/update_inv_gloves()
	remove_overlay(GLOVES_LAYER)

	if(client && hud_used?.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1])
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_GLOVES) + 1]
		inv.update_appearance()

	if(!gloves && blood_in_hands && (num_hands > 0) && !(NOBLOODOVERLAY in dna.species.species_traits))
		var/mutable_appearance/bloody_overlay = mutable_appearance('icons/effects/blood.dmi', "bloodyhands", -GLOVES_LAYER)
		if(num_hands < 2)
			if(has_left_hand(FALSE))
				bloody_overlay.icon_state = "bloodyhands_left"
			else if(has_right_hand(FALSE))
				bloody_overlay.icon_state = "bloodyhands_right"

		overlays_standing[GLOVES_LAYER] = bloody_overlay

	var/mutable_appearance/gloves_overlay = overlays_standing[GLOVES_LAYER]
	if(gloves)
		gloves.screen_loc = ui_gloves
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown)
				client.screen += gloves
		update_observer_view(gloves,1)

		var/icon_file = gloves.worn_icon
		var/applied_styles = NONE
		if((gloves.mutant_variants & STYLE_VOX) && dna.species.id == "vox")
			applied_styles = STYLE_VOX
			icon_file = gloves.worn_icon_vox || 'modular_skyrat/master_files/icons/mob/clothing/species/vox/hands.dmi'
		else if(isteshari(src))
			applied_styles = STYLE_TESHARI
			icon_file = TESHARI_HANDS_ICON

		overlays_standing[GLOVES_LAYER] = gloves.build_worn_icon(default_layer = GLOVES_LAYER, default_icon_file = 'icons/mob/clothing/hands.dmi', override_icon = icon_file, mutant_styles = applied_styles, species = dna.species.species_clothing_path)
		gloves_overlay = overlays_standing[GLOVES_LAYER]
		if(OFFSET_GLOVES in dna.species.offset_features)
			gloves_overlay.pixel_x += dna.species.offset_features[OFFSET_GLOVES][1]
			gloves_overlay.pixel_y += dna.species.offset_features[OFFSET_GLOVES][2]
	overlays_standing[GLOVES_LAYER] = gloves_overlay
	apply_overlay(GLOVES_LAYER)

/mob/living/carbon/human/update_inv_glasses()
	remove_overlay(GLASSES_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EYES) + 1]
		inv.update_icon()

	if(glasses)
		glasses.screen_loc = ui_glasses		//...draw the item in the inventory screen
		if(client && hud_used && hud_used.hud_shown)
			if(hud_used.inventory_shown)			//if the inventory is open ...
				client.screen += glasses				//Either way, add the item to the HUD
		update_observer_view(glasses,1)
		if(!(head && (head.flags_inv & HIDEEYES)) && !(wear_mask && (wear_mask.flags_inv & HIDEEYES)))
			var/icon_file = glasses.worn_icon
			var/applied_style = NONE
			if(dna.species.id == SPECIES_VOX)
				applied_style |= STYLE_VOX
				icon_file = glasses.worn_icon_vox || 'modular_skyrat/master_files/icons/mob/clothing/species/vox/eyes.dmi'
			else if(isteshari(src))
				applied_style |= STYLE_TESHARI
				icon_file = TESHARI_EYES_ICON
			overlays_standing[GLASSES_LAYER] = glasses.build_worn_icon(default_layer = GLASSES_LAYER, default_icon_file = 'icons/mob/clothing/eyes.dmi', override_icon = icon_file, mutant_styles = applied_style, species = dna.species.species_clothing_path)

		var/mutable_appearance/glasses_overlay = overlays_standing[GLASSES_LAYER]
		if(glasses_overlay)
			if(OFFSET_GLASSES in dna.species.offset_features)
				glasses_overlay.pixel_x += dna.species.offset_features[OFFSET_GLASSES][1]
				glasses_overlay.pixel_y += dna.species.offset_features[OFFSET_GLASSES][2]
			overlays_standing[GLASSES_LAYER] = glasses_overlay
	apply_overlay(GLASSES_LAYER)

/mob/living/carbon/human/update_inv_ears()
	remove_overlay(EARS_LAYER)

	if(!get_bodypart(BODY_ZONE_HEAD)) //decapitated
		return

	if(client && hud_used)
		var/atom/movable/screen/inventory/inv = hud_used.inv_slots[TOBITSHIFT(ITEM_SLOT_EARS) + 1]
		inv.update_appearance()

	if(ears)
		ears.screen_loc = ui_ears //move the item to the appropriate screen loc
		if(client && hud_used?.hud_shown)
			if(hud_used.inventory_shown) //if the inventory is open
				client.screen += ears //add it to the client's screen
		update_observer_view(ears,1)
		overlays_standing[EARS_LAYER] = ears.build_worn_icon(default_layer = EARS_LAYER, default_icon_file = 'icons/mob/clothing/ears.dmi', species = dna.species.species_clothing_path)
		var/mutable_appearance/ears_overlay = overlays_standing[EARS_LAYER]
		if(OFFSET_EARS in dna.species.offset_features)
			ears_overlay.pixel_x += dna.species.offset_features[OFFSET_EARS][1]
			ears_overlay.pixel_y += dna.species.offset_features[OFFSET_EARS][2]
		overlays_standing[EARS_LAYER] = ears_overlay
	apply_overlay(EARS_LAYER)

/obj/item/proc/build_worn_icon(default_layer = 0, default_icon_file = null, isinhands = FALSE, femaleuniform = NO_FEMALE_UNIFORM, override_state = null, override_icon = null, override_x_center = null, override_y_center = null, mutant_styles = NONE, species = null)

	//Find a valid icon_state from variables+arguments
	var/t_state
	if(override_state)
		t_state = override_state
	else
		t_state = !isinhands ? (worn_icon_state ? worn_icon_state : icon_state) : (inhand_icon_state ? inhand_icon_state : icon_state)

	//Find a valid icon file from variables+arguments
	var/file_to_use
	if(override_icon)
		file_to_use = override_icon
	else
		file_to_use = !isinhands ? (worn_icon ? worn_icon : default_icon_file) : default_icon_file

	//Find a valid layer from variables+arguments
	var/layer2use = alternate_worn_layer ? alternate_worn_layer : default_layer

	var/mutable_appearance/standing
	if(species)
		var/default_file = !isinhands ? (worn_icon ? worn_icon : default_icon_file) : default_icon_file
		standing = wear_species_version(file_to_use, t_state, layer2use, species, default_file)
	else if(femaleuniform)
		standing = wear_female_version(t_state,file_to_use,layer2use,femaleuniform) //should layer2use be in sync with the adjusted value below? needs testing - shiz
	if(!standing)
		standing = mutable_appearance(file_to_use, t_state, -layer2use)

	//Get the overlays for this item when it's being worn
	//eg: ammo counters, primed grenade flashes, etc.
	var/list/worn_overlays = worn_overlays(standing, isinhands, file_to_use, mutant_styles)
	if(worn_overlays && worn_overlays.len)
		standing.overlays.Add(worn_overlays)

	var/x_center
	var/y_center
	if(override_x_center)
		x_center = override_x_center
	else
		x_center = isinhands ? inhand_x_dimension : worn_x_dimension
	if(override_y_center)
		y_center = override_y_center
	else
		y_center = isinhands ? inhand_y_dimension : worn_y_dimension
	standing = center_image(standing, x_center, y_center)

	//Worn offsets
	var/list/offsets = get_worn_offsets(isinhands)
	standing.pixel_x += offsets[1]
	standing.pixel_y += offsets[2]

	standing.alpha = alpha
	standing.color = color

	return standing

//Removed the icon cache from this, as its not feasible to make a cache for the plathora of customizable species and markings
/mob/living/carbon/human/update_body_parts()
	//CHECK FOR UPDATE
	var/oldkey = icon_render_key
	icon_render_key = generate_icon_render_key()
	if(oldkey == icon_render_key)
		return

	remove_overlay(BODYPARTS_LAYER)

	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		BP.update_limb()

	var/is_taur = FALSE
	if(dna?.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(S.hide_legs)
			is_taur = TRUE

	//GENERATE NEW LIMBS
	var/list/new_limbs = list()
	var/draw_features = !HAS_TRAIT(src, TRAIT_INVISIBLE_MAN)
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(is_taur && (BP.body_part == LEG_LEFT || BP.body_part == LEG_RIGHT))
			continue

		new_limbs += BP.get_limb_icon(draw_external_organs = draw_features)
	if(new_limbs.len)
		overlays_standing[BODYPARTS_LAYER] = new_limbs

	apply_overlay(BODYPARTS_LAYER)
	update_damage_overlays()

/obj/item/proc/wear_species_version(file_to_use, state_to_use, layer, species, default_file_to_use)
	return

/**
 * Generates a species-specific clothing icon.
 *
 * Arguments:
 * * file_to_use - Icon file to use for clothing sprite
 * * state_to_use - Icon state to use within file_to_use
 * * layer - specifies the sprite layer the sprite will be on
 * * species - the specific species the icon will be generated for
 * * default_file_to_use - default fallback icon to use
 */
/obj/item/clothing/wear_species_version(file_to_use, state_to_use, layer, species, default_file_to_use)
	LAZYINITLIST(GLOB.species_clothing_icons[species])
	var/icon/species_clothing_icon = GLOB.species_clothing_icons[species][get_species_clothing_key(file_to_use, state_to_use)] // Check if the icon we want already exists
	if(!species_clothing_icon) 	// Create standing/laying icons if they don't exist
		generate_species_clothing(file_to_use, state_to_use, species, default_file_to_use)
	return mutable_appearance(GLOB.species_clothing_icons[species][get_species_clothing_key(file_to_use, state_to_use)], layer = -layer)
