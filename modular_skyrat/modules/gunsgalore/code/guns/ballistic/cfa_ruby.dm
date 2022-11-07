/obj/item/gun/ballistic/automatic/pistol/cfa_ruby
	name = "CFA Ruby"
	desc = "A heavy-duty sidearm chambered in 12x27mm."
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

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby
	name = "CFA Ruby magazine (12mm Magnum)"
	desc = "An advanced magazine with smart type displays. Alt+click to reskin it."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "m12mm"
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_AP, AMMO_TYPE_RUBBER, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_INCENDIARY)
	ammo_type = /obj/item/ammo_casing/c12mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/empty
	start_empty = TRUE

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/ap
	ammo_type = /obj/item/ammo_casing/c12mm/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/rubber
	ammo_type = /obj/item/ammo_casing/c12mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/hp
	ammo_type = /obj/item/ammo_casing/c12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/cfa_ruby/incendiary
	ammo_type = /obj/item/ammo_casing/c12mm/fire
	round_type = AMMO_TYPE_INCENDIARY
