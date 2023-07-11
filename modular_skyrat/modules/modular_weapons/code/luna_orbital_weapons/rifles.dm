// Military Rifle

/obj/item/gun/ballistic/automatic/luna_rifle
	name = "\improper Luno 'Spadfiŝo' Assault Rifle"
	desc = "A full length, standard SolFed rifle caliber assault rifle. Made for and used by SolFed's various military branches."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/guns_48.dmi'
	icon_state = "spadfiso"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/worn.dmi'
	worn_icon_state = "military_rifle"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/righthand.dmi'
	inhand_icon_state = "military_rifle"

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING

	mag_type = /obj/item/ammo_box/magazine/c40sol_rifle

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/rifle_long.ogg'
	can_suppress = TRUE

	burst_size = 1
	fire_delay = 2
	actions_types = list()

	/// Variable that we set our mag_type to after init, in order to make sure the right magazine spawns but that all of them are still inter-operable
	var/obj/item/ammo_box/magazine/real_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle

/obj/item/gun/ballistic/automatic/luna_rifle/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

	mag_type = real_magazine_type

// Military short rifle

/obj/item/gun/ballistic/automatic/luna_rifle/short
	name = "\improper Luno 'Bekofiŝo' Shortened Rifle"
	desc = "A shortened version of the standard SolFed assault rifle, similar in practically every other way. Made for and used by SolFed's various military branches."

	icon_state = "bekofiso"

	spread = 5

// Police short rifle

/obj/item/gun/ballistic/automatic/luna_rifle/short/police
	name = "\improper Luno 'Bekofiŝo-P' Shortened Rifle"
	desc = "A shortened version of the standard SolFed assault rifle, similar in practically every other way. Made for and used by SolFed's various peacekeeping forces."

	icon_state = "bekofiso_police"

	worn_icon_state = "police_rifle"

	inhand_icon_state = "police_rifle"

	mag_type = /obj/item/ammo_box/magazine/c40sol_rifle/short

// Heavy weapons guy

/obj/item/gun/ballistic/automatic/luna_rifle/machinegun
	name = "\improper Luno 'Martelkapo' Machinegun"
	desc = "A machinegun conversion of SolFed's standard assault rifle. Made for and used by SolFed's various military branches."

	icon_state = "martelkapo"

	mag_type = /obj/item/ammo_box/magazine/c40sol_rifle/drum

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/machinegun.ogg'
	can_suppress = TRUE

	fire_delay = 1
	spread = 10

	projectile_damage_multiplier = 0.8

// Magazines

/obj/item/ammo_box/magazine/c40sol_rifle
	name = "\improper Luno rifle magazine"
	desc = "A standard size magazine for Luno rifles, holds thirty rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "riflestandard"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c40sol
	caliber = CALIBER_SOL40LONG
	max_ammo = 30

/obj/item/ammo_box/magazine/c40sol_rifle/short
	name = "\improper Luno rifle short magazine"
	desc = "A shortened magazine for Luno rifles, holds twenty rounds."

	icon_state = "rifleshort"

	max_ammo = 20

/obj/item/ammo_box/magazine/c40sol_rifle/drum
	name = "\improper Luno rifle drum magazine"
	desc = "A massive drum magazine for Luno rifles, holds fifty rounds."

	icon_state = "rifledrum"

	max_ammo = 50
