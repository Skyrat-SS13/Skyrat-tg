//9mm Magazines
/obj/item/ammo_box/magazine/m9mm/rubber
	name = "pistol magazine (9x25mm Rubber)"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber

/obj/item/ammo_box/magazine/m9mm/ihdf
	name = "pistol magazine (9x25mm Intelligent Dispersal Foam)"
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf

//10mm Cylinder
/obj/item/ammo_box/magazine/internal/cylinder/nt_sec
	name = "\improper 10mm revolver cylinder"
	desc = "how did you get this"
	max_ammo = 6
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	caliber = CALIBER_10MM

//10mm Stuff
/obj/item/ammo_box/c10mm/speedloader
	name = "speed loader (10mm Auto)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm
	ammo_band_color = "#795a58"
	max_ammo = 6
	multiple_sprites = AMMO_BOX_PER_BULLET
	item_flags = NO_MAT_REDEMPTION
	ammo_band_icon = "+357_ammo_band"
	ammo_band_color = null
