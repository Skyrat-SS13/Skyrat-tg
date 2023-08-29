// Base Sol rifle

/obj/item/gun/ballistic/automatic/sol_rifle
	name = "\improper Carwo 'd'Infanteria' Rifle"
	desc = "A full length, standard SolFed rifle caliber assault rifle. Made for and used by SolFed's various military branches."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
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
