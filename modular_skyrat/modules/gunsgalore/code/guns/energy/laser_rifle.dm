// I'm conflicted on what to think about this.

/obj/item/gun/ballistic/automatic/laser
	name = "laser rifle"
	desc = "Though sometimes mocked for the relatively weak firepower of their energy weapons, the logistic miracle of rechargeable ammunition has given Nanotrasen a decisive edge over many a foe."
	icon_state = "oldrifle"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/recharge
	mag_display_ammo = TRUE
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 0
	// actions_types = list() SKYRAT EDIT REMOVAL
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	fire_sound = 'sound/weapons/laser.ogg'
	casing_ejector = FALSE
	company_flag = COMPANY_NANOTRASEN
