/**
 * SECURITY UNDER OVERRIDES
 */


/**
 * Standard security jumpsuit
 */
/obj/item/clothing/under/rank/security/officer
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "security_black"
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "security_blue",
			RESKIN_WORN_ICON_STATE = "security_blue"
		),
	)

/**
 * Wardens jumpsuit
 */
/obj/item/clothing/under/rank/security/warden
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "warden_black"

/**
 * Head of Securities jumpsuit
 */
/obj/item/clothing/under/rank/security/head_of_security
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	icon_state = "hos_black"
