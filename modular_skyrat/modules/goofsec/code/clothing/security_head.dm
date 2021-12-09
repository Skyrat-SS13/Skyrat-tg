/**
 * Standard security helmet
*/
/obj/item/clothing/head/helmet/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_helmet"
	toggle_message = "You pull the visor down on"
	alt_toggle_message = "You push the visor up on"
	flags_inv = HIDEEARS|HIDEFACE|HIDESNOUT
	actions_types = list(/datum/action/item_action/toggle)
	visor_flags_inv = HIDEFACE|HIDESNOUT
	can_toggle = TRUE
	toggle_cooldown = 0
	flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF
	visor_flags_cover = HEADCOVERSEYES | HEADCOVERSMOUTH | PEPPERPROOF

/**
 * Bullet proof helmet
 */
/obj/item/clothing/head/helmet/alt
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "bulletproof_helmet"

/**
 * Security beret - now garrison
*/
/obj/item/clothing/head/beret/sec
	name = "security garrison cap"
	desc = "A robust garrison cap with the security insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "garrison_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "garrison_blue",
			RESKIN_WORN_ICON_STATE = "garrison_blue"
		),
	)

/**
 * Security cap
*/
/obj/item/clothing/head/soft/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	icon_state = "security_cap_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_cap_blue",
			RESKIN_WORN_ICON_STATE = "security_cap_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_cap_white",
			RESKIN_WORN_ICON_STATE = "security_cap_white"
		),
	)
