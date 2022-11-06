/obj/item/gun/ballistic/automatic/surplus
	name = "surplus rifle"
	desc = "One of countless obsolete ballistic rifles that still sees use as a cheap deterrent. Uses 10mm Magnum ammo and its bulky frame prevents one-hand firing."
	icon_state = "surplus"
	inhand_icon_state = "moistnugget"
	worn_icon_state = null
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/m10mm/rifle
	fire_delay = 30
	burst_size = 1
	can_unsuppress = TRUE
	can_suppress = TRUE
	w_class = WEIGHT_CLASS_HUGE
	slot_flags = ITEM_SLOT_BACK
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	mag_display = TRUE
	company_flag = COMPANY_IZHEVSK
	dirt_modifier = 0.75
