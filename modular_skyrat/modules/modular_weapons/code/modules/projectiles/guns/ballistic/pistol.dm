////////////////////////
//ID: MODULAR_WEAPONS //
////////////////////////

////////////////////////
//       PISTOLS      //
////////////////////////

/obj/item/gun/ballistic/automatic/pistol/cfa_snub
	name = "CFA Snub"
	desc = "A compact pistol chambered in 4.6x30mm, Mechanically etched into the slide is 'Cantalan Federal Arms Mk.II', this is a modern civilian recreation of what used to be a military service sidearm on an alien planet."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa-snub"
	mag_type = /obj/item/ammo_box/magazine/m46x30
	can_suppress = TRUE
	fire_sound_volume = 50

/obj/item/gun/ballistic/automatic/pistol/cfa_snub/empty
	spawnwithmagazine = FALSE

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby
	name = "CFA Ruby"
	desc = "An old standard issue military sidearm on an alien world. It fires .45 rounds. It looks old, etched into the slide is 'Cantalan Federal Arms."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/guns/projectile.dmi'
	icon_state = "cfa_ruby"
	mag_type = /obj/item/ammo_box/magazine/m45
	can_suppress = FALSE

/obj/item/gun/ballistic/automatic/pistol/cfa_ruby/empty
	spawnwithmagazine = FALSE

////////////////////////
//        AMMO        //
////////////////////////

/obj/item/ammo_box/magazine/m46x30
	name = "pistol magazine (4.6x30mm)"
	desc = "A 4.6x30mm magazine with a 12-rnd capacity."
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/ammo.dmi'
	icon_state = "m46x30"
	ammo_type = /obj/item/ammo_casing/c46x30mm
	caliber = "4.6x30mm"
	max_ammo = 12
	multiple_sprites = 2

/obj/item/ammo_box/magazine/m46x30/empty
	start_empty = 1

/obj/item/ammo_casing/c46x30mm/rubber
	name = "4.6x30mm rubber bullet casing"
	desc = "A 4.6x30mm rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c46x30mm_rubber

/obj/item/ammo_casing/c45/rubber
	name = ".45 rubber bullet casing"
	desc = "A .45 rubber bullet casing."
	caliber = ".45"
	projectile_type = /obj/projectile/bullet/c45_rubber
