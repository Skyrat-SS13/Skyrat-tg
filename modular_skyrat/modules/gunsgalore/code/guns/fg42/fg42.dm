/obj/item/gun/ballistic/automatic/fg42
	name = "\improper Fallschirmjägergewehr 42"
	desc = "The FG 42 (German: Fallschirmjägergewehr 42, paratrooper rifle 42) is a selective-fire 7.92×57mm Mauser automatic rifle produced in Nazi Germany during World War II. The weapon was developed specifically for the use of the Fallschirmjäger airborne infantry in 1942 and was used in very limited numbers until the end of the war."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/fg42/fg42.dmi'
	icon_state = "fg42"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/fg42/fg42_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/fg42/fg42_righthand.dmi'
	inhand_icon_state = "fg42"
	slot_flags = ITEM_SLOT_BELT
	mag_type = /obj/item/ammo_box/magazine/fg42
	can_suppress = FALSE
	burst_size = 2
	spread = 0
	fire_delay = 1
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/fg42/fg42_back.dmi'
	worn_icon_state = "fg42"
	alt_icons = TRUE
	realistic = TRUE
	reliability = 1
	dirt_modifier = 0.5

/obj/item/ammo_box/magazine/fg42
	name = "fg42 magazine (7.92×33mm)"
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/fg42/fg42.dmi'
	icon_state = "7.92mm"
	ammo_type = /obj/item/ammo_casing/a792
	caliber = "a792"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY
