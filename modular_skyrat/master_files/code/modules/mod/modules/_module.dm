/obj/item/mod/module
	/// The suit's supports_variations_flags, currently only for the chestplate and the helmet parts of the MODsuit.
	var/suit_supports_variations_flags = NONE
	/// Does this module have a separate head sprite? Useful for muzzled sprites
	var/has_head_sprite = FALSE
	/// Is the module's visuals head-only when active? Useful for visors and such, to avoid multiplying the amount of overlay with empty images
	var/head_only_when_active = FALSE
	/// Is the module's visuals head-only when inactive? Useful for visors and such, to avoid multiplying the amount of overlay with empty images
	var/head_only_when_inactive = FALSE
	/// Which part of the modsuit this module is 'attached' to, for purposes of hiding them when retracting the part. Null means it won't get hidden.
	var/datum/weakref/retracts_into

// we need to update mob overlays on deploy/retract in order for the hiding to work because this doesn't happen otherwise
/obj/item/mod/control/deploy(mob/user, obj/item/part)
	. = ..()
	if(wearer)
		wearer.update_clothing(slot_flags)

/obj/item/mod/control/retract(mob/user, obj/item/part)
	. = ..()
	if(wearer)
		wearer.update_clothing(slot_flags)

/obj/item/mod/module/on_uninstall(deleting = FALSE)
	. = ..()
	retracts_into = null

// SEE HERE: This is how you make any given module retract alongside a suit part.
// Set the retracts_into WEAKREF to mod.helmet, mod.chestplate, mod.boots, or mod.gauntlets as desired in the on_install proc just like shown below
/obj/item/mod/module/visor/on_install()
	. = ..()
	retracts_into = WEAKREF(mod.helmet) // hide visor module when the helmet is retracted


/**
 * Proc that handles the mutable_appearances of the module on the MODsuits
 *
 * Arguments:
 * * standing - The mutable_appearance we're taking as a reference for this one, mainly to use its layer.
 * * module_icon_state - The name of the icon_state we'll be using for the module on the MODsuit.
 */
/obj/item/mod/module/proc/handle_module_icon(mutable_appearance/standing, module_icon_state)
	. = list()
	var/is_new_vox = FALSE
	var/is_old_vox = FALSE
	if(mod.wearer)
		if(is_module_hidden()) // retracted modules can hide parts that aren't usable when inactive
			return

		if(mod.chestplate && (mod.chestplate.supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION) && (mod.wearer.bodytype & BODYTYPE_DIGITIGRADE))
			suit_supports_variations_flags |= CLOTHING_DIGITIGRADE_VARIATION

		if(mod.helmet && (mod.helmet.supports_variations_flags & CLOTHING_SNOUTED_VARIATION) && mod.wearer.bodytype & BODYTYPE_SNOUTED)
			suit_supports_variations_flags |= CLOTHING_SNOUTED_VARIATION
		is_new_vox = isvoxprimalis(mod.wearer)
		is_old_vox = isvox(mod.wearer)

	var/icon_to_use = 'icons/mob/clothing/modsuit/mod_modules.dmi'
	var/icon_state_to_use = module_icon_state
	if(is_new_vox || is_old_vox)
		if(is_new_vox)
			icon_to_use = worn_icon_better_vox
		if(is_old_vox)
			icon_to_use = worn_icon_vox

	if(suit_supports_variations_flags && (supports_variations_flags & CLOTHING_DIGITIGRADE_VARIATION))
		icon_to_use = 'modular_skyrat/master_files/icons/mob/mod.dmi'
		icon_state_to_use = "[module_icon_state]_digi"

	var/add_overlay = TRUE
	if(has_head_sprite && ((active && head_only_when_active) || (!active && head_only_when_inactive)))
		add_overlay = FALSE

	if(add_overlay)
		icon_to_use = overlay_icon_file
		var/mutable_appearance/module_icon = mutable_appearance(icon_to_use, icon_state_to_use, layer = standing.layer + 0.1) // Just changed the raw icon path to icon_to_use and the used_overlay to icon_state_to_use
		module_icon.appearance_flags |= RESET_COLOR
		. += module_icon

	if(has_head_sprite)
		icon_to_use = 'modular_skyrat/master_files/icons/mob/mod.dmi'
		icon_state_to_use = "[module_icon_state]_head"

		if(suit_supports_variations_flags && (supports_variations_flags & CLOTHING_SNOUTED_VARIATION))
			icon_state_to_use = "[icon_state_to_use]_muzzled"

		if(is_new_vox)
			icon_to_use = 'modular_skyrat/modules/better_vox/icons/clothing/mod_modules.dmi'
			icon_state_to_use = module_icon_state

		var/mutable_appearance/additional_module_icon = mutable_appearance(icon_to_use, icon_state_to_use, layer = standing.layer + 0.1)
		additional_module_icon.appearance_flags |= RESET_COLOR
		. += additional_module_icon

/**
 * Check whether or not the mod's overlay is hidden.
 *
 * Returns TRUE or FALSE based on whether the module is able to be hidden when the part it is attached to is retracted.
 * By default, will return FALSE for every mod unless 'retracts_into' is set for that mod.
 *
 */
/obj/item/mod/module/proc/is_module_hidden()
	if(isnull(retracts_into))
		return FALSE
	if(allow_flags & MODULE_ALLOW_INACTIVE)
		return FALSE

	var/obj/item/clothing/attached_suit_part = retracts_into.resolve()
	if(attached_suit_part && attached_suit_part.loc == mod)
		return TRUE


