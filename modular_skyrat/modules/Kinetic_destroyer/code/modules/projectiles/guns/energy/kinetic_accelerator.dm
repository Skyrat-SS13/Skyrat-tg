//premium accel
/obj/item/gun/energy/kinetic_accelerator/premiumka
	icon = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/obj/guns/energy.dmi'
	name = "Premium accelerator"
	desc = "A premium kinetic accelerator fitted with an extended barrel and increased pressure tank."
	icon_state = "kineticgun"
	inhand_icon_state = "kineticgun"
	lefthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premiumka)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 9
	automatic_charge_overlays = FALSE
	can_bayonet = TRUE
	knife_x_offset = 20
	knife_y_offset = 12
	overheat_time = 16
	holds_charge = FALSE
	unique_frequency = FALSE // modified by KA modkits
	overheat = FALSE
	max_mod_capacity = 100
	recharge_timerid

/obj/item/ammo_casing/energy/kinetic/premiumka
	projectile_type = /obj/projectile/kinetic/premiumka
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg'
/obj/projectile/kinetic/premiumka
	name = "kinetic force"
	icon_state = null
	damage = 50
	damage_type = BRUTE
	flag = BOMB
	range = 4
	log_override = TRUE

//heavy accel
/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy
	icon = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/obj/guns/energy_extras.dmi'
	name = "Heavy accelerator"
	desc = "A rather bulky Kinetic Accelerator capable of splitting large groups of rocks and hurting those near its impact."
	icon_state = "heavyka"
	inhand_icon_state = "kineticgun"
	lefthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premiumka/heavy)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = TRUE
	flight_x_offset = 12
	flight_y_offset = 11
	automatic_charge_overlays = FALSE
	can_bayonet = TRUE
	knife_x_offset = 15
	knife_y_offset = 8
	overheat_time = 22
	holds_charge = FALSE
	unique_frequency = FALSE // modified by KA modkits
	overheat = FALSE
	max_mod_capacity = 80
	recharge_timerid

/obj/item/gun/energy/kinetic_accelerator/premiumka/heavy/Initialize()
	. = ..()
	var/obj/item/borg/upgrade/modkit/aoe/heavy/initial_kit = new /obj/item/borg/upgrade/modkit/aoe/heavy(src)
	initial_kit.install(src)
/obj/item/ammo_casing/energy/kinetic/premiumka/heavy
	projectile_type = /obj/projectile/kinetic/premiumka/heavy
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg'

/obj/projectile/kinetic/premiumka/heavy
	name = "heavy kinetic force"
	icon_state = null
	damage = 65
	damage_type = BRUTE
	flag = BOMB
	range = 3
	log_override = TRUE

//rapid accel

/obj/item/gun/energy/kinetic_accelerator/premiumka/rapid
	icon = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/obj/guns/energy_extras.dmi'
	name = "Rapid accelerator"
	desc = "A Kinetic Accelerator featuring an overclocked charger and a smaller pressure tank."
	icon_state = "rapidka"
	inhand_icon_state = "kineticgun"
	lefthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premiumka/rapid)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = FALSE
	flight_x_offset = 15
	flight_y_offset = 9
	automatic_charge_overlays = FALSE
	can_bayonet = FALSE
	knife_x_offset = 20
	knife_y_offset = 12
	overheat_time = 12
	holds_charge = FALSE
	unique_frequency = FALSE // modified by KA modkits
	overheat = FALSE
	max_mod_capacity = 80
	recharge_timerid

/obj/item/ammo_casing/energy/kinetic/premiumka/rapid
	projectile_type = /obj/projectile/kinetic/premiumka/rapid
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg'
/obj/projectile/kinetic/premiumka/rapid
	name = "rapid kinetic force"
	icon_state = null
	damage = 25
	damage_type = BRUTE
	flag = BOMB
	range = 4
	log_override = TRUE

//precise accel

/obj/item/gun/energy/kinetic_accelerator/premiumka/precise
	icon = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/obj/guns/energy_extras.dmi'
	name = "Precise accelerator"
	desc = "A modified Accelerator. This one has been zeroed in with a choked down barrel to give a longer range"
	icon_state = "preciseka"
	inhand_icon_state = "kineticgun"
	lefthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premiumka/precise)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = TRUE
	flight_x_offset = 16
	flight_y_offset = 13
	automatic_charge_overlays = FALSE
	can_bayonet = TRUE
	knife_x_offset = 21
	knife_y_offset = 13
	overheat_time = 18
	holds_charge = FALSE
	unique_frequency = FALSE // modified by KA modkits
	overheat = FALSE
	max_mod_capacity = 80
	recharge_timerid

/obj/item/ammo_casing/energy/kinetic/premiumka/precise
	projectile_type = /obj/projectile/kinetic/premiumka/precise
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg'
/obj/projectile/kinetic/premiumka/precise
	name = "rapid kinetic force"
	icon_state = null
	damage = 45
	damage_type = BRUTE
	flag = BOMB
	range = 6
	log_override = TRUE

//modular KA

/obj/item/gun/energy/kinetic_accelerator/premiumka/modular
	icon = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/obj/guns/energy_extras.dmi'
	name = "Modular accelerator"
	desc = "A rather bare-bones kinetic accelerator capable of forming to one's preferences."
	icon_state = "modularka"
	inhand_icon_state = "kineticgun"
	lefthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premiumka/modular)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 21
	automatic_charge_overlays = FALSE
	can_bayonet = TRUE
	knife_x_offset = 14
	knife_y_offset = 14
	overheat_time = 30
	holds_charge = FALSE
	unique_frequency = FALSE // modified by KA modkits
	overheat = FALSE
	max_mod_capacity = 180
	recharge_timerid

/obj/item/ammo_casing/energy/kinetic/premiumka/modular
	projectile_type = /obj/projectile/kinetic/premiumka/modular
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg'
/obj/projectile/kinetic/premiumka/modular
	name = "modular kinetic force"
	icon_state = null
	damage = 25
	damage_type = BRUTE
	flag = BOMB
	range = 4
	log_override = TRUE

//BYOKA

/obj/item/gun/energy/kinetic_accelerator/premiumka/byoka
	icon = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/obj/guns/energy_extras.dmi'
	name = "Custom accelerator"
	desc = "You're not sure how it's made, but it is truly a kinetic accelerator fit for a clown. Its handle smells faintly of bananas."
	icon_state = "byoka"
	inhand_icon_state = "kineticgun"
	lefthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/Kinetic_destroyer/code/modules/mining/icons/mobs/inhands/weapons/guns_righthand.dmi'
	ammo_type = list(/obj/item/ammo_casing/energy/kinetic/premiumka/byoka)
	cell_type = /obj/item/stock_parts/cell/emproof
	item_flags = NONE
	obj_flags = UNIQUE_RENAME
	weapon_weight = WEAPON_LIGHT
	can_flashlight = TRUE
	flight_x_offset = 15
	flight_y_offset = 21
	automatic_charge_overlays = FALSE
	can_bayonet = TRUE
	knife_x_offset = 20
	knife_y_offset = 12
	overheat_time = 27
	holds_charge = FALSE
	unique_frequency = FALSE // modified by KA modkits
	overheat = FALSE
	max_mod_capacity = 300
	recharge_timerid

/obj/item/ammo_casing/energy/kinetic/premiumka/byoka
	projectile_type = /obj/projectile/kinetic/premiumka/byoka
	select_name = "kinetic"
	e_cost = 500
	fire_sound = 'sound/weapons/kenetic_accel.ogg'
/obj/projectile/kinetic/premiumka/byoka
	name = "odd kinetic force"
	icon_state = null
	damage = 0
	damage_type = BRUTE
	flag = BOMB
	range = 1
	log_override = TRUE

//Heavy KA perma AOE perk

/obj/item/borg/upgrade/modkit/aoe/heavy
	name = "mining explosion"
	desc = "Causes the Heavy KA to work properly. You should not have this."
	denied_type = /obj/item/borg/upgrade/modkit/aoe
	turf_aoe = TRUE
	modifier = 0.33
	cost = 0

/obj/item/borg/upgrade/modkit/aoe/heavy/install(obj/item/gun/energy/kinetic_accelerator/KA)
	KA.modkits += src
	return TRUE

/obj/item/borg/upgrade/modkit/aoe/heavy/uninstall(obj/item/gun/energy/kinetic_accelerator/KA)
	return FALSE


