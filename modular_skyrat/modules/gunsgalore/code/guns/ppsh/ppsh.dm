/obj/item/gun/ballistic/automatic/ppsh
	name = "\improper PPSh-41"
	desc = "The PPSh-41 (pistolet-pulemyot Shpagina; Shpagin machine pistol) is a Soviet submachine gun designed by Georgy Shpagin as a cheap, reliable, and simplified alternative to the PPD-40."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/ppsh/ppsh.dmi'
	icon_state = "ppsh"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/ppsh/ppsh_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/ppsh/ppsh_righthand.dmi'
	inhand_icon_state = "ppsh"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/ppsh
	can_suppress = FALSE
	spread = 20
	burst_size = 6
	fire_delay = 0.5
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/ppsh/ppsh_back.dmi'
	worn_icon_state = "ppsh"
	alt_icons = TRUE
	realistic = TRUE
	reliability = 10

/obj/item/ammo_box/magazine/ppsh
	name = "ppsh-41 magazine (7.62×25mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/ppsh/ppsh.dmi'
	icon_state = "7.62mm"
	ammo_type = /obj/item/ammo_casing/a762x25
	caliber = "a762x25"
	max_ammo = 71
	multiple_sprites = AMMO_BOX_FULL_EMPTY
