/**
 * The CMG-1,
 *
 * A simple two round burst security rifle that is chambered in .45. It's a well rounded sidearm.
 */

/obj/item/gun/ballistic/automatic/cmg
	name = "\improper NT CMG-1-A1"
	desc = "A bullpup, two round burst submachinegun chambered in 9mm peacekeeper that (after lawsuits from unnamed companies) now uses a fully unique design."
	icon_state = "cmg1"
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/guns.dmi'
	inhand_icon_state = "c20r"
	selector_switch_icon = TRUE
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/cmg
	fire_delay = 2 //Slightly buffed firespeed over the last cmg because the bullets are a bit weaker
	burst_size = 2
	can_bayonet = TRUE
	knife_x_offset = 26
	knife_y_offset = 10
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE

/obj/item/gun/ballistic/automatic/cmg/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, \
		light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', \
		light_overlay = "flight", \
		overlay_x = 24, \
		overlay_y = 10)

/obj/item/ammo_box/magazine/multi_sprite/cmg
	name = "9mm Peacekeeper PDW magazine"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g11"
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	caliber = CALIBER_9MMPEACE
	max_ammo = 24
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/cmg/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/cmg/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/cmg/lethal
	ammo_type = /obj/item/ammo_casing/b9mm
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
