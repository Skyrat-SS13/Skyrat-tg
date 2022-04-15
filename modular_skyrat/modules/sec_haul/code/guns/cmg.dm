/**
 * The CMG-1,
 *
 * A simple three round burst security rifle that is chambered in 10mm Auto. It's a well rounded sidearm.
 */

/obj/item/gun/ballistic/automatic/cmg
	name = "\improper NT CMG-1"
	desc = "A bullpup two-round burst 10mm Auto PDW with an eerily familiar design. It has a foldable stock and a dot sight."
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
	name = "10mm Auto PDW magazine"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g11"
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	caliber = CALIBER_10MMAUTO
	max_ammo = 24
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cmg/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/cmg/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/cmg/lethal
	ammo_type = /obj/item/ammo_casing/b10mm
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
