/obj/item/gun/ballistic/automatic/Wardengun
	name = "Warden's Best Friend"
	desc = "Your best friend doesn't have to be a dog."
	icon_state = "ige_shotgun"
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns.dmi'
	inhand_icon_state = "ige_shotgun"
	righthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_lefthand.dmi'
	worn_icon_state = "ige_shotgun"
	worn_icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_worn.dmi'

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/shotgun_bm.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 4
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	burst_size = 1
	fire_delay = 1.5
	pin = /obj/item/firing_pin/implant/mindshield
	company_flag = COMPANY_REMOVED

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun
	name = "\improper IGE-340 magazine"
	desc = "A seven round magazine built for 12 GA, intended for use in the IGE-340 shotgun."
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/magazines.dmi'
	icon_state = "ige_shotgun_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_AP, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_IHDF, AMMO_TYPE_INCENDIARY)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/rubbershot
	ammo_type = /obj/item/ammo_casing/shotgun/rubbershot
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/flechette
	ammo_type = /obj/item/ammo_casing/shotgun/flechette
	round_type = AMMO_TYPE_AP

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/hollowpoint
	ammo_type = /obj/item/ammo_casing/shotgun/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/beehive
	ammo_type = /obj/item/ammo_casing/shotgun/beehive
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun/dragonsbreath
	ammo_type = /obj/item/ammo_casing/shotgun/dragonsbreath
	round_type = AMMO_TYPE_INCENDIARY