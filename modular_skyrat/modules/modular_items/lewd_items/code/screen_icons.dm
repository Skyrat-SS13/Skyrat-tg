//screen alert

/atom/movable/screen/alert/aroused_x
	name = "Aroused"
	desc = "It's a little hot in here"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi'
	icon_state = "arousal_small"
	var/mutable_appearance/pain_overlay
	var/mutable_appearance/pleasure_overlay
	var/pain_level = "small"
	var/pleasure_level = "small"

/atom/movable/screen/alert/aroused_x/Initialize(mapload)
	.=..()
	pain_overlay = update_pain()
	pleasure_overlay = update_pleasure()

/atom/movable/screen/alert/aroused_x/proc/update_pain()
	if(pain_level)
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pain_[pain_level]")

/atom/movable/screen/alert/aroused_x/proc/update_pleasure()
	if(pleasure_level)
		return mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_icons.dmi', "pleasure_[pleasure_level]")
