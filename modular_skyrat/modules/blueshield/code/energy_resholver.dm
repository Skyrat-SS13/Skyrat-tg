//Blueshield Energy Revolver
//Icon and such by @EspeciallyStrange 'Calvin'

/obj/item/gun/energy/e_gun/blueshield
	name = "x-02 energy revolver"
	desc = "An energy weapon fitted with self recharging-cells. Feels somewhat heavy to carry and would certainly hurt to get whacked by."
	icon = 'modular_skyrat/modules/blueshield/icons/energy.dmi'
	icon_state = "blackgrip"
	charge_delay = 6
	can_charge = FALSE //Doesn't work like that son
	selfcharge = 1
	cell_type = /obj/item/stock_parts/cell/hos_gun
	w_class = WEIGHT_CLASS_NORMAL //Fits in bag!
	force = 15 //smash sulls in
	ammo_type = list(/obj/item/ammo_casing/energy/disabler/hos, /obj/item/ammo_casing/energy/laser/hos)
	ammo_x_offset = 1

/obj/item/gun/energy/e_gun/blueshield/specop
	name = "tactical energy revolver"
	desc = "An advanced model of the energy revolver with all of it's benefit and a much more powerful phase emitter."
	icon_state = "redgrip"
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/spec, /obj/item/ammo_casing/energy/laser/hellfire, /obj/item/ammo_casing/energy/disabler,)


//Alternative for people who prefers energy carbine, remain inclusive and all.
/obj/item/gun/energy/e_gun/stun/blueshield
	name = "defender energy carbine"
	desc = "Military issue energy gun, is able to fire stun rounds. Extremely slow recharge"
	ammo_x_offset = 2
	ammo_type = list(/obj/item/ammo_casing/energy/electrode/blueshield, /obj/item/ammo_casing/energy/disabler, /obj/item/ammo_casing/energy/laser)
	charge_delay = 18
	can_charge = TRUE //In case you aren't charging fast enough, the recharge is meant to be slow on purpose
	selfcharge = 1

//Choice Beacon for blueshield

/obj/item/choice_beacon/blueshield
	name = "blueshield weapon beacon"
	desc = "A single use beacon to deliver a weapon of your choice. Please only call this in your office"
	company_source = "Sol Security Solution"
	company_message = span_bold("Supply Pod incoming please stand by")

/obj/item/choice_beacon/blueshield/open_options_menu(mob/living/user)
	var/list/selectable_gun_types = list(
		"Energy Revolver" = image(icon = 'modular_skyrat/modules/blueshield/icons/energy.dmi', icon_state = "blackgrip", desc = "self-recharging energy sidearm with lethal and disabler function, fit in your bag and would hurt a lot to get whacked by."),
		"Defender Energy Carbine" = image(icon = 'icons/obj/weapons/guns/energy.dmi', icon_state = "energytac", desc = "An energy carbine normally only given to ERT capable of firing taser electrode alongside laser and disabler shot. Extremely slow self-recharge rate."),
		".585 Submachine Gun" = image(icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/xhihao_light_arms/guns32x.dmi', icon_state = "bogseo", desc = "A weapon that could hardly be called a sub machinegun, firing the monstrous .585 cartridge."),
	)
 //This can obviously be replaced out with any gun of your choice for future code
	for(var/gun in selectable_gun_types)
	var/gun_choice = show_radial_menu(user, selectable_gun_types, require_near = TRUE)

	if(!gun_choice)
		mob.user(user, "no selection made")
		return

	switch(gun_choice)
		if("Energy Revolver")
			spawn += /obj/item/gun/energy/e_gun/blueshield
		if("Defender Energy Carbine")
			spawn += /obj/item/gun/energy/e_gun/stun/blueshield
		if(".585 Submachine Gun")
			spawn += /obj/item/storage/toolbox/guncase/skyrat/xhihao_large_case/bogseo
	if(!can_use_beacon(user))
		return

	consume_use(gun_choice, user)

//Blueshield Energy
/obj/item/ammo_casing/energy/electrode/blueshield
	e_cost = LASER_SHOTS(5, STANDARD_CELL_CHARGE)
	projectile_type = /obj/projectile/energy/electrode/blueshield

/obj/projectile/energy/electrode/blueshield
	stamina = 45 //Still a 3 shot down but much more safe to have

