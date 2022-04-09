////////////////////////
//ID: MODULAR_WEAPONS //
////////////////////////

////////////////////////
//       PISTOLS      //
////////////////////////

/obj/item/gun/ballistic/automatic/pistol/cfa_snub
	name = "CFA Snub"
	desc = "A small easily-concealable modern pistol chambered in the more rarely seen 4.2x30mm. It's specifically designed to be compact."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa-snub"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_snub
	can_suppress = TRUE
	fire_sound_volume = 30
	w_class = WEIGHT_CLASS_SMALL
	has_gun_safety = FALSE
	company_flag = COMPANY_CANTALAN
	dirt_modifier = 0.2

/obj/item/gun/ballistic/automatic/pistol/cfa_snub/empty
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby
	name = "CFA Ruby"
	desc = "A large and loud modern handgun that fires a unique cartridge. It's chambered in 12x27mm."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa_ruby"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/cfa_ruby
	can_suppress = FALSE
	fire_sound_volume = 120
	w_class = WEIGHT_CLASS_NORMAL
	has_gun_safety = FALSE
	company_flag = COMPANY_CANTALAN
	dirt_modifier = 0.2

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/empty
	spawnwithmagazine = FALSE

////////////////////////
//        AMMO        //
////////////////////////
/obj/item/ammo_box/magazine/multi_sprite/cfa_snub
	name = "CFA Snub magazine (4.2x30mm)"
	desc = "An advanced magazine with smart type displays. Alt+click to reskin it."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "m42x30"
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_AP, AMMO_TYPE_RUBBER, AMMO_TYPE_INCENDIARY)
	ammo_type = /obj/item/ammo_casing/c42x30mm
	caliber = CALIBER_42X30MM
	max_ammo = 16
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/ap
	ammo_type = /obj/item/ammo_casing/c42x30mm/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/rubber
	ammo_type = /obj/item/ammo_casing/c42x30mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/incendiary
	ammo_type = /obj/item/ammo_casing/c42x30mm/inc
	round_type = AMMO_TYPE_INCENDIARY

/obj/item/ammo_box/magazine/multi_sprite/cfa_snub/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby
	name = "CFA Ruby magazine (12mm Magnum)"
	desc = "An advanced magazine with smart type displays. Alt+click to reskin it."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "m12mm"
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_AP, AMMO_TYPE_RUBBER, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_INCENDIARY)
	ammo_type = /obj/item/ammo_casing/c10mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/ap
	ammo_type = /obj/item/ammo_casing/c10mm/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/hp
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/incendiary
	ammo_type = /obj/item/ammo_casing/c10mm/fire
	round_type = AMMO_TYPE_INCENDIARY
