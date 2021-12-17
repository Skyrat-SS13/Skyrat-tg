/**
 * SECURITY GLOVES OVERRIDES
 */

/**
 * Standard security gloves
 */
/obj/item/clothing/gloves/security
	name = "security gloves"
	desc = "A pair of security gloves."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'
	icon_state = "gloves_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "gloves_blue",
			RESKIN_WORN_ICON_STATE = "gloves_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "gloves_white",
			RESKIN_WORN_ICON_STATE = "gloves_white"
		),
	)
