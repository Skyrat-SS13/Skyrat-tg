//9mm Magazines
/obj/item/ammo_box/magazine/m9mm
	name = "pistol magazine (9x25mm)"
	multiple_sprites = AMMO_BOX_PER_BULLET
	icon = 'modular_skyrat/modules/aesthetics/guns/icons/magazine.dmi'

/obj/item/ammo_box/magazine/m9mm
	custom_premium_price = 50

/obj/item/ammo_box/magazine/m9mm/rubber
	name = "pistol magazine (9x25mm Rubber)"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	icon_state = "9x19pB"

/obj/item/ammo_box/magazine/m9mm/ihdf
	name = "pistol magazine (9x25mm Intelligent Dispersal Foam)"
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	icon_state = "9x19pp"

//Extended 9mm
/obj/item/ammo_box/magazine/m9mm/stendo
	name = "pistol magazine (9x25mm)"
	ammo_type = /obj/item/ammo_casing/c9mm
	icon_state = "g18"
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	max_ammo = 33

/obj/item/ammo_box/magazine/m9mm/stendo/fire
	name = "pistol magazine (9x25mm Incendiary)"
	ammo_type = /obj/item/ammo_casing/c9mm/fire
	icon_state = "g18_r"

/obj/item/ammo_box/magazine/m9mm/stendo/rubber
	name = "pistol magazine (9x25mm Incendiary)"
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	icon_state = "g18_b"

/obj/item/ammo_box/magazine/m9mm/stendo/hp
	name = "pistol magazine (9x25mm Hollow Point)"
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	icon_state = "g18_hp"

/obj/item/ammo_box/magazine/m9mm/stendo/ihdf
	name = "pistol magazine (9x25mm Intelligent Dispersal Foam)"
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	icon_state = "g18_ihdf"


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

