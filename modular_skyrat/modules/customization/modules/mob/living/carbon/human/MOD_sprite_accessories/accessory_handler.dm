/obj/item/mod/control/seal_part(obj/item/clothing/part, seal)
	. = ..()
	wearer.update_mutant_bodyparts(TRUE)

/obj/item/mod/control/finish_activation(on)
	. = ..()
	wearer.update_mutant_bodyparts(TRUE)

/obj/item/mod/control/on_mod_deployed(mob/user)
	. = ..()
	wearer.update_mutant_bodyparts(TRUE)

/obj/item/mod/control/on_mod_retracted(mob/user)
	. = ..()
	wearer.update_mutant_bodyparts(TRUE)

#define HARDLIGHT_TEXTURES 'modular_skyrat/modules/customization/modules/mob/living/carbon/human/MOD_sprite_accessories/icons/MOD_mask.dmi'

// Tail hardlight
/datum/sprite_accessory/tails
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/tails/get_custom_mod_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		if(!modsuit_control.active)
			return
		var/icon/MOD_texture = icon(HARDLIGHT_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Ears hardlight
/datum/sprite_accessory/ears
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/ears/get_custom_mod_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.head && istype(wearer.head, /obj/item/clothing/head/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		if(!modsuit_control.active)
			return
		var/icon/MOD_texture = icon(HARDLIGHT_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Wings hardlight
/datum/sprite_accessory/wings
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/wings/get_custom_mod_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		if(!modsuit_control.active)
			return
		var/icon/MOD_texture = icon(HARDLIGHT_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Horns hardlight
/datum/sprite_accessory/horns
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/horns/get_custom_mod_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.head && istype(wearer.head, /obj/item/clothing/head/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		if(!modsuit_control.active)
			return
		var/icon/MOD_texture = icon(HARDLIGHT_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Taur hardlight
/datum/sprite_accessory/taur
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/taur/get_custom_mod_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		if(!modsuit_control.active)
			return
		var/icon/MOD_texture = icon(HARDLIGHT_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Lizard spines hardlight
/datum/sprite_accessory/spines
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/spines/get_custom_mod_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		if(!modsuit_control.active)
			return
		var/icon/MOD_texture = icon(HARDLIGHT_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon

// Xenodorsal hardlight
/datum/sprite_accessory/xenodorsal
	use_custom_mod_icon = TRUE

/datum/sprite_accessory/xenodorsal/get_custom_mod_icon(mob/living/carbon/human/wearer)
	var/icon/special_icon = icon(icon, icon_state)
	if(wearer.wear_suit && istype(wearer.wear_suit, /obj/item/clothing/suit/mod))
		var/obj/item/mod/control/modsuit_control = wearer.back
		var/datum/mod_theme/mod_theme = modsuit_control.theme
		if(!modsuit_control.active)
			return
		var/icon/MOD_texture = icon(HARDLIGHT_TEXTURES, "[mod_theme.name]")
		special_icon.Blend(MOD_texture, ICON_ADD)
		special_icon.Blend(MOD_texture, ICON_MULTIPLY)
		return special_icon
