/**
 * The CMG-1,
 *
 * A simple two round burst security rifle that is chambered in .45. It's a well rounded sidearm.
 */

/obj/item/gun/ballistic/automatic/cmg
	name = "\improper NT CMG-1"
	desc = "A bullpup two-round burst .45 PDW with an eerily familiar design. It has a foldable stock and a dot sight."
	icon_state = "cmg1"
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	inhand_icon_state = "c20r"
	selector_switch_icon = TRUE
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/cmg
	fire_delay = 2.5
	burst_size = 2
	can_bayonet = TRUE
	can_flashlight = TRUE
	knife_x_offset = 26
	knife_y_offset = 10
	flight_x_offset = 24
	flight_y_offset = 10
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE

/obj/item/ammo_box/magazine/multi_sprite/cmg
	name = ".45 PDW magazine"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g11"
	ammo_type = /obj/item/ammo_casing/c45/rubber
	caliber = CALIBER_45
	max_ammo = 24
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cmg/inc
	ammo_type = /obj/item/ammo_casing/c45/inc
	round_type = AMMO_TYPE_INCENDIARY

/obj/item/ammo_box/magazine/multi_sprite/cmg/ap
	ammo_type = /obj/item/ammo_casing/c45/ap
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/cmg/lethal
	ammo_type = /obj/item/ammo_casing/c45
	round_type = AMMO_TYPE_LETHAL

/obj/item/storage/box/gunset/cmg
	name = "cmg supply box"

/obj/item/gun/ballistic/automatic/cmg/nomag
	spawnwithmagazine = FALSE

/obj/item/storage/box/gunset/cmg/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/cmg/nomag(src)
	new /obj/item/ammo_box/magazine/multi_sprite/cmg(src)
	new /obj/item/ammo_box/magazine/multi_sprite/cmg(src)
	new /obj/item/ammo_box/magazine/multi_sprite/cmg(src)

//.45 Rubber

/obj/item/ammo_casing/c45/rubber
	name = ".45 rubber bullet casing"
	desc = "A .45 rubber bullet casing."
	projectile_type = /obj/projectile/bullet/c45/rubber
	harmful = FALSE

/obj/projectile/bullet/c45/rubber
	name = ".45 rubber bullet"
	damage = 5
	stamina = 27
	ricochets_max = 6
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.8
	wound_bonus = 0
	shrapnel_type = null
	sharpness = NONE
	embedding = null
