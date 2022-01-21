/obj/item/mod/module
	/// The suit's mutant_variants, currently only for the chestplate and the helmet parts of the MODsuit.
	var/suit_mutant_variants = NONE
	/// Does this module have a separate head sprite? Useful for muzzled sprites
	var/has_head_sprite = FALSE
	/// Is the module's visuals head-only when active? Useful for visors and such, to avoid multiplying the amount of overlay with empty images
	var/head_only_when_active = FALSE
	/// Is the module's visuals head-only when inactive? Useful for visors and such, to avoid multiplying the amount of overlay with empty images
	var/head_only_when_inactive = FALSE


/**
 * Proc that handles the mutable_appearances of the module on the MODsuits
 *
 * Arguments:
 * * standing - The mutable_appearance we're taking as a reference for this one, mainly to use its layer.
 * * module_icon_state - The name of the icon_state we'll be using for the module on the MODsuit.
 */
/obj/item/mod/module/proc/handle_module_icon(mutable_appearance/standing, module_icon_state)
	. = list()
	if(mod.wearer)
		if(mod.chestplate && (mod.chestplate.mutant_variants & STYLE_DIGITIGRADE) && (DIGITIGRADE in mod.wearer.dna.species.species_traits))
			suit_mutant_variants |= STYLE_DIGITIGRADE

		if(mod.helmet && (mod.helmet.mutant_variants & STYLE_MUZZLE) && mod.wearer.dna.species.mutant_bodyparts["snout"])
			var/datum/sprite_accessory/snouts/snout = GLOB.sprite_accessories["snout"][mod.wearer.dna.species.mutant_bodyparts["snout"][MUTANT_INDEX_NAME]]
			if(snout.use_muzzled_sprites)
				suit_mutant_variants |= STYLE_MUZZLE

	var/icon_to_use = 'icons/mob/clothing/mod.dmi'
	var/icon_state_to_use = module_icon_state
	var/add_overlay = TRUE
	if(suit_mutant_variants && (mutant_variants & STYLE_DIGITIGRADE))
		icon_to_use = 'modular_skyrat/master_files/icons/mob/mod.dmi'
		icon_state_to_use = "[module_icon_state]_digi"

		if((active && head_only_when_active) | (!active && head_only_when_inactive))
			add_overlay = FALSE

	if(add_overlay)
		var/mutable_appearance/module_icon = mutable_appearance(icon_to_use, icon_state_to_use, layer = standing.layer + 0.1) // Just changed the raw icon path to icon_to_use and the used_overlay to icon_state_to_use
		. += module_icon

	if(has_head_sprite)
		icon_to_use = 'modular_skyrat/master_files/icons/mob/mod.dmi'
		icon_state_to_use = "[module_icon_state]_head"

		if(suit_mutant_variants && (mutant_variants & STYLE_MUZZLE))
			icon_state_to_use = "[icon_state_to_use]_muzzled"

		var/mutable_appearance/additional_module_icon = mutable_appearance(icon_to_use, icon_state_to_use, layer = standing.layer + 0.1)
		. += additional_module_icon
