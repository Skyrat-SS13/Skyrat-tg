/obj/item/debug_item_overlays
	name = "debug item"
	icon = 'modular_skyrat/master_files/icons/mob/sprite_accessory/tails.dmi'
	icon_state = "m_waggingtail_catbig_BEHIND"

/obj/item/debug_item_overlays/attack_self(mob/user, modifiers)
	var/icon/MOD_texture = icon('modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi', "fill")
	var/icon/accessory_icon = icon(icon, icon_state)

	accessory_icon.Blend(MOD_texture, ICON_ADD)
	accessory_icon.Blend(MOD_texture, ICON_MULTIPLY)

	overlays |= mutable_appearance(accessory_icon, layer = MOB_SHIELD_LAYER)

// if(mob_mask.Height() > world.icon_size || mob_mask.Width() > world.icon_size)

/obj/item/mod/control/on_mod_deployed(mob/user)
	. = ..()
	var/mob/living/carbon/human/wearer = user
	wearer.update_mutant_bodyparts(TRUE)

/obj/item/mod/control/on_mod_retracted(mob/user)
	. = ..()
	var/mob/living/carbon/human/wearer = user
	wearer.update_mutant_bodyparts(TRUE)

#define MOD_TEXTURES 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi'

/datum/sprite_accessory/tails
	get_special_MOD_icon = TRUE

/datum/sprite_accessory/tails/get_special_MOD_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)

	if(wearer.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		var/icon/MOD_texture = icon(MOD_TEXTURES, "[mod_theme.name]")

		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)

		return special_icon
	return icon


