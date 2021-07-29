/obj/item/ammo_casing/b10mm/b460
	name = ".460 Rowland Magnum casing."
	desc = "A .460 Rowland Magnum casing."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ammo_cartridges.dmi'
	icon_state = "sl-casing"
	caliber = "460"
	projectile_type = /obj/projectile/bullet/advanced/b10mm/b460

/obj/projectile/bullet/advanced/b10mm/b460
	name = ".460 RM JHP bullet"
	damage = 36
	stamina = 12
	wound_bonus = 35
	weak_against_armour = TRUE
	speed = 2.25

/obj/item/gun/ballistic/automatic/pistol/blueshield
	name = "\improper M45A5 Elite"
	desc = "A hand-assembled custom sporting handgun by Alpha Centauri Armories, chambered in .460 Rowland Magnum. This model has a highly modular structure, to acommodate for ammo costs."
	icon = 'modular_skyrat/modules/blueshield/icons/obj/guns/M45A5.dmi'
	icon_state = "m45a5"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield
	can_suppress = FALSE
	fire_delay = 1.75
	fire_sound_volume = 60 //Handgun equivalent of .44 with a muzzle brake lmao
	spread = 2
	force = 8 //There's heavier guns that dealt less damage on melee than this so we're reducing it from the original 12
	recoil = 1
	realistic = TRUE
	dirt_modifier = 0.1
	can_flashlight = TRUE
	emp_damageable = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/dp_fire.ogg'

/obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield
	name = "ACA modular magazine"
	desc = "A magazine able to chamber .460 Rowland Magnum and Peacekeeper 10mm rounds as an alternative by its length switch. Made for the M45A5, as it's the only available sidearm with a smart multi-caliber mechanism."
	icon = 'modular_skyrat/modules/blueshield/icons/obj/guns/M45A5.dmi'
	icon_state = "rowlandmodular"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 10 //Increased length single stacks.
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF, ".460")

/obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/b460
	ammo_type = /obj/item/ammo_casing/b10mm/b460
	round_type = ".460"

/obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/storage/box/gunset/blueshield
	name = "ACA E-M45A5 Gunset"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/ballistic/automatic/pistol/blueshield/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/blueshield/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/pistol/blueshield/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/b460(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/b460(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/b460(src)
	new /obj/item/ammo_box/magazine/multi_sprite/ladon/blueshield/b460(src)

