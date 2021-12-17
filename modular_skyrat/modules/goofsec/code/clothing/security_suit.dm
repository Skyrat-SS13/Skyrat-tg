/**
 * SECURITY SUIT OVERRIDES
 */

/**
 * Standard security vest
 * Needs to be a new type so we don't give random people a security themed vest.
 */
/obj/item/clothing/suit/armor/vest/security
	name = "armored security vest"
	desc = "An armored vest designed for use in combat, used by security personnel."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "vest_blue",
			RESKIN_WORN_ICON_STATE = "vest_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "vest_white",
			RESKIN_WORN_ICON_STATE = "vest_white"
		),
	)


/**
 * Standard bulleproof vest
 */
/obj/item/clothing/suit/armor/bulletproof
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_bulletproof"
	body_parts_covered = CHEST|GROIN|ARMS // Our sprite has groin and arm protections, so we get it too.

/**
 * Wardens vest
 */
/obj/item/clothing/suit/armor/vest/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "vest_warden"

/**
 * Security winter coat
 */

/obj/item/clothing/head/hooded/winterhood/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_wintercoat_hood"

/obj/item/clothing/suit/hooded/wintercoat/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "security_wintercoat"
