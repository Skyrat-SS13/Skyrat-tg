// This DMI holds all of the overlayable textures for MODs
#define HARDLIGHT_DMI 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi'

/obj/item/mod/control/seal_part(obj/item/clothing/part, seal)
	. = ..()
	if(activating)
		return

	update_external_organs_modsuit_status(seal && active)
	wearer.update_body_parts(TRUE)

/obj/item/mod/control/finish_activation(on)
	. = ..()
	update_external_organs_modsuit_status(on)
	wearer.update_body_parts(TRUE)

/obj/item/mod/control/on_mod_deployed(mob/user)
	. = ..()
	update_external_organs_modsuit_status(active)
	wearer.update_body_parts(TRUE)

/obj/item/mod/control/on_mod_retracted(mob/user)
	. = ..()
	update_external_organs_modsuit_status(FALSE)
	wearer.update_body_parts(TRUE)

/// Simple helper proc to force an update of the external organs appearance
/// if necessary.
/obj/item/mod/control/proc/update_external_organs_modsuit_status(status)
	if(!wearer?.organs)
		return

	for(var/obj/item/organ/external/to_update in wearer.organs)
		to_update.bodypart_overlay.set_modsuit_status(status)


// Tail hardlight
/datum/sprite_accessory/tails
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/tails/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)

		return special_icon

// Ears hardlight
/datum/sprite_accessory/ears
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/ears/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.head && istype(wearer.head, /obj/item/clothing/head/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)

		return special_icon

// Wings hardlight
/datum/sprite_accessory/wings
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/wings/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)

		return special_icon

// Antennae hardlight
/datum/sprite_accessory/moth_antennae
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/moth_antennae/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.head && istype(wearer.head, /obj/item/clothing/head/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)

		return special_icon

// IPC Antennae hardlight
/datum/sprite_accessory/antenna
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/antenna/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.head && istype(wearer.head, /obj/item/clothing/head/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)

		return special_icon

// Horns hardlight
/datum/sprite_accessory/horns
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/horns/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.head && istype(wearer.head, /obj/item/clothing/head/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Taur hardlight
/datum/sprite_accessory/taur
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/taur/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Lizard spines hardlight
/datum/sprite_accessory/spines
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/spines/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Xenodorsal hardlight
/datum/sprite_accessory/xenodorsal
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/xenodorsal/get_custom_mod_icon(mob/living/carbon/human/wearer, mutable_appearance/appearance_to_use = null)
	if(wearer?.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		if(!modsuit_control.active || !mod_theme.hardlight)
			return

		var/icon/special_icon = appearance_to_use ? icon(appearance_to_use.icon, appearance_to_use.icon_state) : icon(icon, icon_state)
		var/icon/MOD_texture = icon(HARDLIGHT_DMI, "[mod_theme.hardlight_theme]")
		special_icon.Blend("#fff", ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

#undef HARDLIGHT_DMI
