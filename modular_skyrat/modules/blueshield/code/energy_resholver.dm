//Blueshield Energy Revolver
//Icon and such by @EspeciallyStrange 'Calvin'

/obj/item/gun/energy/e_gun/blueshield
	name = "energy revolver"
	desc = "An energy weapon fitted with self recharging-cells. Feels somewhat heavy to carry and would certainly hurt to get whacked by."
	icon = 'modular_skyrat/modules/blueshield/icons/energy.dmi'
	icon_state = "blackgrip"
	lefthand_file = 'modular_skyrat/modules/blueshield/icons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/blueshield/icons/guns_righthand.dmi'
	charge_delay = 9
	can_charge = FALSE //Doesn't work like that son
	selfcharge = 1
	cell_type = /obj/item/stock_parts/cell/hos_gun
	w_class = WEIGHT_CLASS_NORMAL //Fits in bag!
	force = 15 //smash sulls in
	throwforce = 15
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hellfire)
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/blueshield/specop
	name = "tactical energy revolver"
	desc = "An advanced model of the energy revolver with all of it's benefit and a much more powerful phase emitter."
	icon_state = "redgrip"
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/laser/hellfire)
//Alternative for people who prefers energy carbine, remain inclusive and all.
/obj/item/gun/energy/e_gun/stun/blueshield
	name = "defender energy carbine"
	desc = "Military issue energy gun, is able to fire stun rounds. Extremely slow recharge"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/blueshield, /obj/item/ammo_casing/energy/laser/scatter/disabler, /obj/item/ammo_casing/energy/lasergun/blueshield)
	charge_delay = 14
	can_charge = TRUE //In case you aren't charging fast enough, the recharge is meant to be slow on purpose
	selfcharge = 1

//Choice Beacon for blueshield

/obj/item/choice_beacon/blueshield
	name = "blueshield weapon beacon"
	desc = "A single use beacon to deliver a weapon of your choice. Please only call this in your office"
	company_source = "Sol Security Solution"
	company_message = span_bold("Supply Pod incoming please stand by")

/obj/item/choice_beacon/blueshield/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Energy Revolver" = /obj/item/gun/energy/e_gun/blueshield,
		"Energy Carbine" = /obj/item/gun/energy/e_gun/stun/blueshield,
		".585 SMG" = /obj/item/storage/toolbox/guncase/skyrat/xhihao_large_case/bogseo //This can obviously be replaced out with any gun of your choice for future coder
	)

	return selectable_gun_types

//Blueshield Energy
/obj/item/ammo_casing/energy/electrode/blueshield
	e_cost = LASER_SHOTS(6, STANDARD_CELL_CHARGE)
	projectile_type = /obj/projectile/energy/electrode/blueshield

/obj/item/ammo_casing/energy/lasergun/blueshield
	e_cost = LASER_SHOTS(30, STANDARD_CELL_CHARGE)

/obj/projectile/energy/electrode/blueshield
	stamina = 55 //Still a 3 shot down but much more safe to have

