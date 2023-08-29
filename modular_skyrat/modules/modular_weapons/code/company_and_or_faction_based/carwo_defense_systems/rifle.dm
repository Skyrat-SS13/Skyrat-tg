// Base Sol rifle

/obj/item/gun/ballistic/automatic/sol_rifle
	name = "\improper Carwo 'd'Infanteria' Rifle"
	desc = "A heavy battle rifle commonly seen in the hands of SolFed military types. Accepts any standard SolFed rifle magazine."

	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/carwo_defense_systems/guns48x.dmi'
	icon_state = "infanterie"

	worn_icon = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/worn.dmi'
	worn_icon_state = "infanterie"

	lefthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/modular_weapons/icons/luna_orbital_weapons/righthand.dmi'
	inhand_icon_state = "infanterie"

	special_mags = TRUE

	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING

	accepted_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle
	spawn_magazine_type = /obj/item/ammo_box/magazine/c40sol_rifle/standard

	fire_sound = 'modular_skyrat/modules/modular_weapons/sounds/rifle_heavy.ogg'
	can_suppress = TRUE

	suppressor_x_offset = 12

	burst_size = 1
	fire_delay = 2
	actions_types = list()

/obj/item/gun/ballistic/automatic/sol_rifle/Initialize(mapload)
	. = ..()

	SET_BASE_PIXEL(-8, 0)

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/sol_rifle/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_CARWO)

/obj/item/gun/ballistic/automatic/sol_rifle/examine_more(mob/user)
	. = ..()

	. += "The Luna Orbital infanteria fusilo line, a line of rifles built to meet the \
		requirements of the SolFed department of defense for a modern military rifle platform. \
		Though the list of requirements was extensive, two stand out as the most important. \
		The new weapon was to use the newly developed .40 Sol Long caseless rifle ammunition, \
		and had to be reliable enough to operate in any of the environments that SolFed's military \
		forces may find themselves in. The result of this is the weapon you are looking at now, in \
		consistent use by SolFed militaries and police forces since 2554."

	return .

/obj/item/gun/ballistic/automatic/sol_rifle/no_mag
	spawnwithmagazine = FALSE
