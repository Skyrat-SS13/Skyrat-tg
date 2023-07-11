// Military Rifle

/obj/item/gun/ballistic/automatic/luna_sport_shooter
	name = "\improper Luno 'Lunfiŝo' Precision Rifle"
	desc = "A civilian converted SolFed military rifle. Lacks automatic fire, but at least it still takes the same magazines and ammo."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/guns_48.dmi'
	icon_state = "lunfiso"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/worn.dmi'
	worn_icon_state = "civilian_rifle"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/righthand.dmi'
	inhand_icon_state = "civilian_rifle"

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING

	mag_type = /obj/item/ammo_box/magazine/c40sol_rifle

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/rifle_civilian.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 12

	burst_size = 1
	fire_delay = 3
	actions_types = list()

/obj/item/gun/ballistic/automatic/luna_sport_shooter/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 2.5)
