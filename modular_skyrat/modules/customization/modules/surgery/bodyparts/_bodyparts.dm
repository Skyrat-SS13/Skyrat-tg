/obj/item/bodypart/proc/get_limb_icon(dropped, draw_external_organs)
	icon_state = "" //to erase the default sprite, we're building the visual aspects of the bodypart through overlays alone.

	. = list()

	var/image_dir = 0
	if(dropped)
		image_dir = SOUTH
		if(dmg_overlay_type)
			if(brutestate)
				. += image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_[brutestate]0", -DAMAGE_LAYER, image_dir)
			if(burnstate)
				. += image('icons/mob/dam_mob.dmi', "[dmg_overlay_type]_[body_zone]_0[burnstate]", -DAMAGE_LAYER, image_dir)

	var/image/limb = image(layer = -BODYPARTS_LAYER, dir = image_dir)
	var/image/aux
	. += limb

	if(animal_origin)
		if(is_organic_limb())
			limb.icon = 'icons/mob/animal_parts.dmi'
			if(species_id == "husk")
				limb.icon_state = "[animal_origin]_husk_[body_zone]"
			else
				limb.icon_state = "[animal_origin]_[body_zone]"
		else
			limb.icon = 'icons/mob/augmentation/augments.dmi'
			limb.icon_state = "[animal_origin]_[body_zone]"

		if(blocks_emissive)
			var/mutable_appearance/limb_em_block = mutable_appearance(limb.icon, limb.icon_state, plane = EMISSIVE_PLANE, appearance_flags = KEEP_APART)
			limb_em_block.dir = image_dir
			limb_em_block.color = GLOB.em_block_color
			limb.overlays += limb_em_block
		return

	var/icon_gender = (body_gender == FEMALE) ? "f" : "m" //gender of the icon, if applicable

	if((body_zone != BODY_ZONE_HEAD && body_zone != BODY_ZONE_CHEST))
		should_draw_gender = FALSE

	if(organic_render)
		if(should_draw_greyscale)
			limb.icon = rendered_bp_icon || 'icons/mob/human_parts_greyscale.dmi' //Skyrat change - customization
			if(should_draw_gender)
				limb.icon_state = "[species_id]_[body_zone]_[icon_gender]"
			else if(use_digitigrade)
				limb.icon_state = "digitigrade_[use_digitigrade]_[body_zone]"
			else
				limb.icon_state = "[species_id]_[body_zone]"
		else
			limb.icon = rendered_bp_icon || 'icons/mob/human_parts.dmi' //Skyrat change - customization
			if(should_draw_gender)
				limb.icon_state = "[species_id]_[body_zone]_[icon_gender]"
			else
				limb.icon_state = "[species_id]_[body_zone]"
		if(aux_zone)
			aux = image(limb.icon, "[species_id]_[aux_zone]", -aux_layer, image_dir)
			. += aux
	else
		limb.icon = icon
		if(should_draw_gender)
			limb.icon_state = "[body_zone]_[icon_gender]"
		else
			limb.icon_state = "[body_zone]"
		if(aux_zone)
			aux = image(limb.icon, "[aux_zone]", -aux_layer, image_dir)
			. += aux
		if(blocks_emissive)
			var/mutable_appearance/limb_em_block = mutable_appearance(limb.icon, limb.icon_state, -BODYPARTS_LAYER, plane = EMISSIVE_PLANE, appearance_flags = KEEP_APART)
			limb_em_block.dir = image_dir
			limb_em_block.color = GLOB.em_block_color
			. += limb_em_block
		return

	var/draw_color
	if(should_draw_greyscale)
		draw_color = mutation_color || species_color || (skin_tone && skintone2hex(skin_tone))
		if(draw_color)
			limb.color = draw_color
			if(aux_zone)
				aux.color = draw_color

	if (!owner || is_pseudopart || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner

	if(blocks_emissive)
		var/mutable_appearance/limb_em_block = mutable_appearance(limb.icon, limb.icon_state, -BODYPARTS_LAYER,  plane = EMISSIVE_PLANE, appearance_flags = KEEP_APART)
		limb_em_block.dir = image_dir
		limb_em_block.color = GLOB.em_block_color
		. += limb_em_block

		if(aux_zone)
			var/mutable_appearance/aux_em_block = mutable_appearance(aux.icon, aux.icon_state, -BODYPARTS_LAYER, plane = EMISSIVE_PLANE, appearance_flags = KEEP_APART)
			aux_em_block.dir = image_dir
			aux_em_block.color = GLOB.em_block_color
			. += aux_em_block

	//set specific alpha before setting the markings alpha
	if (alpha != 255)
		for (var/ov in .)
			var/image/overlay = ov
			overlay.alpha = alpha
	//Markings!
	var/override_color
	if(HAS_TRAIT(H, TRAIT_HUSK))
		override_color = "#888888"

	for(var/key in H.dna.species.body_markings[body_zone])
		var/datum/body_marking/BM = GLOB.body_markings[key]
		if (!BM)
			continue
		var/render_limb_string = body_zone
		switch(body_zone)
			if(BODY_ZONE_R_LEG, BODY_ZONE_L_LEG)
				if(use_digitigrade)
					render_limb_string = "digitigrade_[use_digitigrade]_[render_limb_string]"
			if(BODY_ZONE_CHEST)
				if(BM.gendered)
					var/gendaar = (H.body_type == FEMALE) ? "f" : "m"
					render_limb_string = "[render_limb_string]_[gendaar]"

		var/mutable_appearance/accessory_overlay
		var/mutable_appearance/emissive
		accessory_overlay = mutable_appearance(BM.icon, "[BM.icon_state]_[render_limb_string]", -BODYPARTS_LAYER)
		accessory_overlay.alpha = H.dna.species.markings_alpha
		if (H.dna.species.body_markings[body_zone][key][2])
			emissive = emissive_appearance_copy(accessory_overlay)
		if(override_color)
			accessory_overlay.color = override_color
		else
			accessory_overlay.color = H.dna.species.body_markings[body_zone][key][1]
		. += accessory_overlay
		if (emissive)
			. += emissive

	if(aux_zone)
		for(var/key in H.dna.species.body_markings[aux_zone])
			var/datum/body_marking/BM = GLOB.body_markings[key]

			var/render_limb_string = aux_zone

			var/mutable_appearance/emissive
			var/mutable_appearance/accessory_overlay
			accessory_overlay = mutable_appearance(BM.icon, "[BM.icon_state]_[render_limb_string]", -aux_layer)
			accessory_overlay.alpha = H.dna.species.markings_alpha
			if (H.dna.species.body_markings[aux_zone][key][2])
				emissive = emissive_appearance_copy(accessory_overlay)
			if(override_color)
				accessory_overlay.color = override_color
			else
				accessory_overlay.color = H.dna.species.body_markings[aux_zone][key][1]
			. += accessory_overlay
			if (emissive)
				. += emissive

	if(!draw_external_organs)
		return
	//Draw external organs like horns and frills
	for(var/obj/item/organ/external/external_organ in external_organs)
		if(!dropped && !external_organ.can_draw_on_bodypart(owner))
			continue
		//Some externals have multiple layers for background, foreground and between
		for(var/external_layer in external_organ.all_layers)
			if(external_organ.layers & external_layer)
				external_organ.get_overlays(., image_dir, external_organ.bitflag_to_layer(external_layer), icon_gender, draw_color)
