/mob/living/carbon/proc/update_body_parts()
	//CHECK FOR UPDATE
	var/oldkey = icon_render_key
	icon_render_key = generate_icon_render_key()
	if(oldkey == icon_render_key)
		return

	remove_overlay(BODYPARTS_LAYER)

	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		BP.update_limb()

	//LOAD ICONS
	if(limb_icon_cache[icon_render_key])
		load_limb_from_cache()
		return

	var/is_taur = FALSE
	if(dna?.species.mutant_bodyparts["taur"])
		var/datum/sprite_accessory/taur/S = GLOB.sprite_accessories["taur"][dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
		if(S.hide_legs)
			is_taur = TRUE

	//GENERATE NEW LIMBS
	var/list/new_limbs = list()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		if(is_taur && (BP.body_part == LEG_LEFT || BP.body_part == LEG_RIGHT))
			continue

		new_limbs += BP.get_limb_icon()
	if(new_limbs.len)
		overlays_standing[BODYPARTS_LAYER] = new_limbs
		limb_icon_cache[icon_render_key] = new_limbs

	apply_overlay(BODYPARTS_LAYER)
	update_damage_overlays()

/mob/living/carbon/proc/generate_icon_render_key()
	for(var/X in bodyparts)
		var/obj/item/bodypart/BP = X
		. += "-[BP.body_zone]"
		if(BP.use_digitigrade)
			. += "-digitigrade[BP.use_digitigrade]"
		if(BP.animal_origin)
			. += "-[BP.animal_origin]"
		if(BP.status == BODYPART_ORGANIC)
			. += "-organic"
		else
			. += "-robotic"

	if(HAS_TRAIT(src, TRAIT_HUSK))
		. += "-husk"

	if(dna?.species.mutant_bodyparts["taur"])
		. += "-taur"
