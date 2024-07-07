//9mm Magazines
/obj/item/ammo_box/magazine/m9mm
	custom_premium_price = 50

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
	item_flags = NO_MAT_REDEMPTION
	icon_state = "38"
	multiple_sprites = AMMO_BOX_PER_BULLET
	ammo_band_icon = "+38_ammo_band"

	custom_premium_price = 50

/obj/item/ammo_box/c10mm/speedloader/rubber

	name = "speed loader (10mm Auto Rubber)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	ammo_band_color = "#792a59"

