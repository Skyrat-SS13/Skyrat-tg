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

/obj/item/ammo_box/magazine/m9mm/stendo/ap
	name = "pistol magazine (9x25mm Armour Piercing)"
	ammo_type = /obj/item/ammo_casing/c9mm/ap
	icon_state = "g18_ihdf"

/obj/item/ammo_box/magazine/m9mm/stendo/ihdf
	name = "pistol magazine (9x25mm Intelligent Dispersal Foam)"
	ammo_type = /obj/item/ammo_casing/c9mm/ihdf
	icon_state = "g18_ihdf"

//Shotgun Internal Tube

/obj/item/ammo_box/magazine/internal/shot/extended
	ammo_type = /obj/item/ammo_casing/shotgun/buckshot
	max_ammo = 10

/obj/item/ammo_box/magazine/internal/shot/somewhatextended
	name = "combat shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/shotgun/beanbag
	max_ammo = 8

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
	ammo_band_color = "#dd6057"
	max_ammo = 6
	item_flags = NO_MAT_REDEMPTION
	icon_state = "38"
	multiple_sprites = AMMO_BOX_PER_BULLET
	ammo_band_icon = "+38_ammo_band"
	multitype = FALSE
	custom_premium_price = 50

	w_class = WEIGHT_CLASS_SMALL

/obj/item/ammo_box/c10mm/speedloader/rubber

	name = "speed loader (10mm Auto Rubber)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm/rubber
	ammo_band_color = "#1824c5"

/obj/item/ammo_box/c10mm/speedloader/fire

	name = "speed loader (10mm Auto Fire)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm/fire
	ammo_band_color = "#c41d1a"

/obj/item/ammo_box/c10mm/speedloader/ap

	name = "speed loader (10mm Auto Armor Penetrating)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm/ap
	ammo_band_color = "#1ac43f"

/obj/item/ammo_box/c10mm/speedloader/hp

	name = "speed loader (10mm Auto Hollow Point)"
	desc = "Designed to quickly reload revolvers."
	ammo_type = /obj/item/ammo_casing/c10mm/hp
	ammo_band_color = "#df00ae"

/obj/item/ammo_box/magazine/firefly
	name = "pistol magazine (.117 Incapacitator)"
	icon = 'modular_skyrat/modules/modular_weapons/icons/obj/company_and_or_faction_based/nanotrasen_system_inc/ammo.dmi'
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	icon_state = "firefly"
	multitype = FALSE
	ammo_type = /obj/item/ammo_casing/shotgun/antitide
	max_ammo = 10
	caliber = CALIBER_SHOTGUN
