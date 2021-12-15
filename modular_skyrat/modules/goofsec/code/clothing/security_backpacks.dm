/**
 * SECURITY BACKPACK OVERRIDES
 */

/**
 * Standard security backpack!
 */
/obj/item/storage/backpack/security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "backpack_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"White Variant" = list(
			RESKIN_ICON_STATE = "backpack_white",
			RESKIN_WORN_ICON_STATE = "backpack_white"
		),
	)

/**
 * Standard security satchel!
 */
/obj/item/storage/backpack/satchel/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_satchel"

/**
 * Standard security dufflies!
 */
/obj/item/storage/backpack/duffelbag/sec
	icon = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi'
	icon_state = "security_duffle_blue"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"White Variant" = list(
			RESKIN_ICON_STATE = "security_duffle_white",
			RESKIN_WORN_ICON_STATE = "security_duffle_white"
		),
	)
