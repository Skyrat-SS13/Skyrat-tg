/obj/item/crowbar/power/electric
	name = "jaws of life"
	icon = 'modular_skyrat/modules/extra_tools/icons/obj/tools.dmi'
	icon_state = "jaws_pry"
	inhand_icon_state = "jawsoflife"
	worn_icon_state = "jawsoflife"
	lefthand_file = 'modular_skyrat/modules/extra_tools/icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/extra_tools/icons/mob/inhands/equipment/tools_righthand.dmi'
	force_opens = FALSE

/obj/item/crowbar/power/electric/get_belt_overlay()
	return mutable_appearance('modular_skyrat/modules/extra_tools/icons/obj/clothing/belt_overlays.dmi', "jaws_pry")
