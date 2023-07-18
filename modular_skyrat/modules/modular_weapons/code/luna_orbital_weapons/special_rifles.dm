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

	special_mags = TRUE

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

	recoil = 0.25

	actions_types = list()

/obj/item/gun/ballistic/automatic/luna_sport_shooter/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 2.5)

/obj/item/gun/ballistic/automatic/luna_sport_shooter/give_manufacturer_examine()
	AddElement(/datum/element/manufacturer_examine, COMPANY_LUNA)

/obj/item/gun/ballistic/automatic/luna_sport_shooter/examine_more(mob/user)
	. = ..()

	. += "The 'Lunfiŝo' is a civilian market conversion of the standard Luno \
		military rifle. Much of the military furniture has been exchanged for \
		less expensive, off the shelf parts. Despite the drastic differences \
		between the civilian and military market versions of the weapons, \
		this weapon remains popular due to its stopping power, interoperatbility \
		with SolFed military magazines and ammunition, and consistent precision."

	return .

/obj/item/gun/ballistic/automatic/luna_sport_shooter/no_mag
	spawnwithmagazine = FALSE
