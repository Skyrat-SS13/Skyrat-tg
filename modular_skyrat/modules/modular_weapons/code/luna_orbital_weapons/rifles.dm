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

	special_mags = TRUE

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING

	mag_type = /obj/item/ammo_box/magazine/c40sol_rifle/thirty

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/rifle_long.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 12

	burst_size = 1
	fire_delay = 2
	actions_types = list()

	/// Variable that we set our mag_type to after init, in order to make sure the right magazine spawns but that all of them are still inter-operable
	var/obj/item/ammo_box/magazine/real_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle

/obj/item/gun/ballistic/automatic/luna_rifle/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

	mag_type = real_magazine_type

/obj/item/gun/ballistic/automatic/luna_rifle/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_LUNA)

/obj/item/gun/ballistic/automatic/luna_rifle/examine_more(mob/user)
	. = ..()

	. += "The Luna Orbital infanteria fusilo line, a line of rifles built to meet the \
		requirements of the SolFed department of defense for a modern military rifle platform. \
		Though the list of requirements was extensive, two stand out as the most important. \
		The new weapon was to use the newly developed .40 Sol Long caseless rifle ammunition, \
		and had to be reliable enough to operate in any of the environments that SolFed's military \
		forces may find themselves in. The result of this is the weapon you are looking at now, in \
		consistent use by SolFed militaries and police forces since 2554."

	return .

/obj/item/gun/ballistic/automatic/luna_rifle/no_mag
	spawnwithmagazine = FALSE

// Military short rifle

/obj/item/gun/ballistic/automatic/luna_rifle/short
	name = "\improper Luno 'Bekofiŝo' Shortened Rifle"
	desc = "A shortened version of the standard SolFed assault rifle, similar in practically every other way. Made for and used by SolFed's various military branches."

	icon_state = "bekofiso"

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/luna_weapons_factory/rifle_short.ogg'

	spread = 5

	recoil = 0.25

	suppressor_x_offset = 8

/obj/item/gun/ballistic/automatic/luna_rifle/short/examine_more(mob/user)
	. = ..()

	. += "This particular variant is a shortened version of the original rifle, \
		reduced in size for soldiers that are typically required to carry large amounts \
		of kit. Commanders, combat engineers, even medics can be seen using this variant \
		for the savings in weight and size. Police forces needing a rifle almost \
		exclusively use this short variant."

	return .

/obj/item/gun/ballistic/automatic/luna_rifle/short/no_mag
	spawnwithmagazine = FALSE

// Police short rifle

/obj/item/gun/ballistic/automatic/luna_rifle/short/police
	name = "\improper Luno 'Bekofiŝo-P' Shortened Rifle"
	desc = "A shortened version of the standard SolFed assault rifle, similar in practically every other way. Made for and used by SolFed's various peacekeeping forces."

	icon_state = "bekofiso_police"

	worn_icon_state = "police_rifle"

	inhand_icon_state = "police_rifle"

	mag_type = /obj/item/ammo_box/magazine/c40sol_rifle

/obj/item/gun/ballistic/automatic/luna_rifle/short/police/no_mag
	spawnwithmagazine = FALSE

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

	recoil = 1

	suppressor_x_offset = 9

	projectile_damage_multiplier = 0.8

/obj/item/gun/ballistic/automatic/luna_rifle/machinegun/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.2)

/obj/item/gun/ballistic/automatic/luna_rifle/machinegun/examine_more(mob/user)
	. = ..()

	. += "This particular variant is a heavier version of the original rifle. \
		Converted into a squad machinegun, the heavier barrel and electronically \
		operated firing system allow for significantly higher firerates over the \
		standard rifle. As a tradeoff, a heavy battery pack is mounted above the \
		barrel for powering the new electronic systems. This weapon is not for \
		the weak armed."

	return .

/obj/item/gun/ballistic/automatic/luna_rifle/machinegun/no_mag
	spawnwithmagazine = FALSE

// Magazines

/obj/item/ammo_box/magazine/c40sol_rifle
	name = "\improper Luno rifle short magazine"
	desc = "A shortened magazine for Luno rifles, holds fifteen rounds."

	icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/magazines.dmi'
	icon_state = "rifleshort"

	multiple_sprites = AMMO_BOX_FULL_EMPTY

	ammo_type = /obj/item/ammo_casing/c40sol
	caliber = CALIBER_SOL40LONG
	max_ammo = 15

/obj/item/ammo_box/magazine/c40sol_rifle/thirty
	name = "\improper Luno rifle magazine"
	desc = "A standard size magazine for Luno rifles, holds thirty rounds."

	icon_state = "riflestandard"

	max_ammo = 30

/obj/item/ammo_box/magazine/c40sol_rifle/drum
	name = "\improper Luno rifle drum magazine"
	desc = "A massive drum magazine for Luno rifles, holds fourty-five rounds."

	icon_state = "rifledrum"

	w_class = WEIGHT_CLASS_NORMAL

	max_ammo = 45
