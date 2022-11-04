/obj/item/mod/control/seal_part(obj/item/clothing/part, seal)
	. = ..()
	wearer.update_mutant_bodyparts(TRUE)

/obj/item/mod/control/on_mod_deployed(mob/user)
	. = ..()
	wearer.update_mutant_bodyparts(TRUE)

/obj/item/mod/control/on_mod_retracted(mob/user)
	. = ..()
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

/datum/sprite_accessory/ears
	get_special_MOD_icon = TRUE

/datum/sprite_accessory/ears/get_special_MOD_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.head && istype(wearer.head, /obj/item/clothing/head/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme

		var/icon/MOD_texture = icon(MOD_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon
	return icon
