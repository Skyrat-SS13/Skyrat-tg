// Military shotgun

/obj/item/gun/ballistic/shotgun/luna
	name = "\improper Luno 'Sledmartelo' Tactical Shotgun"
	desc = "A twleve guage shotgun with an eight round shell capacity. Made for and used by SolFed's various military branches."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/guns_48.dmi'
	icon_state = "sledmartelo"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/worn.dmi'
	worn_icon_state = "military_shotgun"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/righthand.dmi'
	inhand_icon_state = "military_shotgun"

	base_pixel_x = -8
	pixel_x = -8

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/shotgun.ogg'
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'

	can_suppress = TRUE

	suppressor_x_offset = 10

	mag_type = /obj/item/ammo_box/magazine/internal/shot/luna

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING

/obj/item/ammo_box/magazine/internal/shot/luna
	name = "\improper 'Sledmartelo' Shotgun Internal Tube"
	caliber = CALIBER_SHOTGUN
	max_ammo = 8

// Police shotgun

/obj/item/gun/ballistic/shotgun/luna/police
	name = "\improper Luno 'Sledmartelo-T' Peacekeeper Shotgun"
	desc = "A twleve guage shotgun with a six round shell capacity. Converted from military weapons for use by SolFed's various police and peacekeeping forces."

	icon_state = "sledmartelo_police"

	worn_icon_state = "police_shotgun"

	inhand_icon_state = "police_shotgun"

	mag_type = /obj/item/ammo_box/magazine/internal/shot/luna/police

/obj/item/ammo_box/magazine/internal/shot/luna/police
	name = "\improper 'Sledmartelo' Shotgun Short Internal Tube"
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	max_ammo = 6
