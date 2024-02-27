//Blueshield Energy Revolver
//Icon and such by @EspeciallyStrange 'Calvin'

/obj/item/gun/energy/e_gun/blueshield
	name = "energy revolver"
	desc = "An energy weapon fitted with self recharging-cells, the cylinder of the gun rotate upon firing, allowing new cell to load into the breech while the spent one charges up." //Obligatory Ultrakill reference
	icon = 'modular_skyrat/modules/blueshield/icons/energy.dmi'
	icon_state = "specgrip"
	inhand_icon = "mini"
	charge_delay = 6
	can_charge = FALSE //Doesn't work like that son
	selfcharge = 1
	cell_type = /obj/item/stock_parts/cell/hos_gun
	w_class = WEIGHT_CLASS_NORMAL //Fits in bag!
	force = 10
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos)
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/blueshield/specop
	name = "tactical energy revolver"
	desc = "An advanced model of the energy revolver with all of it's benefit and a much more powerful phase emitter."

	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/laser/hellfire)


//Alternative for people who prefers carbine, remain inclusive and all.
/obj/item/gun/energy/e_gun/stun/blueshield
	name = "tactical energy gun"
	desc = "Military issue energy gun, is able to fire stun rounds."
	desc = "An energy weapon fitted with self recharging-cells, the cylinder of the gun rotate upon firing, allowing new cell to load into the breech while the spent one charges up." //Obligatory Ultrakill reference
	icon = 'modular_skyrat/modules/blueshield/icons/energy.dmi'
	icon_state = "br"
	inhand_icon = "bsr"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/blueshield, /obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	charge_delay = 16
	can_charge = TRUE //In case you aren't charging fast enough, the recharge is meant to be slow on purpose
	selfcharge = 1

//Choice Beacon for blueshield

/obj/item/choice_beacon/blueshield
	name = "gunset beacon"
	desc = "A single use beacon to deliver a gunset of your choice. Please only call this in your office"
	company_source = "Sol Security Solution"
	company_message = span_bold("Supply Pod incoming please stand by")

/obj/item/choice_beacon/ntc/generate_display_names()
	var/static/list/selectable_gun_types = list(
		"Energy Revolver" = /obj/item/gun/energy/e_gun/blueshield,
		"Energy Carbine" = /obj/item/gun/energy/e_gun/stun/blueshield,
		".585 SMG" = /obj/item/storage/toolbox/guncase/skyrat/xhihao_large_case/bogseo
	)

	return selectable_gun_types


//Energy Define
/obj/item/ammo_casing/energy/electrode/blueshield


/obj/projectile/energy/electrode/blueshield
	stamina = 45 //Still a 3 shot down, just a lot more rough to use

