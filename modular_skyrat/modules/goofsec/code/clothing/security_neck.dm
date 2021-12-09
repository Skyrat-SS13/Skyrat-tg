/**
 * Security cape
 *
 * A fashionable cape that you can swap from shoulder to shoulder!
 */

/obj/item/clothing/neck/security_cape
	name = "security cape"
	desc = "A fashionable cape worn by security officers."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/neck.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/neck.dmi'
	icon_state = "cape_black"
	inhand_icon_state = "" //no inhands
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Blue Variant" = list(
			RESKIN_ICON_STATE = "cape_blue",
			RESKIN_WORN_ICON_STATE = "cape_blue"
		),
		"White Variant" = list(
			RESKIN_ICON_STATE = "cape_white",
			RESKIN_WORN_ICON_STATE = "cape_white"
		),
	)
	/// Our position, false = RIGHT, TRUE = LEFT, for swapping sides.
	var/position = FALSE

/obj/item/clothing/neck/security_cape/AltClick(mob/user)
	. = ..()
	position = !position
	to_chat(user, span_notice("You swap the cape's position."))
	update_appearance()

/obj/item/clothing/neck/security_cape/update_appearance(updates)
	. = ..()
	if(position)
		worn_icon_state = icon_state
	else
		worn_icon_state = "[icon_state]_left"

