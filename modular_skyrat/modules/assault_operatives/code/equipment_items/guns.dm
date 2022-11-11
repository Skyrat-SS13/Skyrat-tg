/obj/item/gun/ballistic/automatic/assault_ops_rifle
	name = "\improper IGE-110 rifle"
	desc = "A bullpup rifle chambered in 5.6x30mm and painted in an ominous matte black. Strangely, the gun also seems to lack any form of manufacturer markings."\
	icon_state = "ige_assault"
	icon = 'modular_skyrat\modules\assault_operatives\icons\guns\guns.dmi'
	righthand_file = 'modular_skyrat\modules\assault_operatives\icons\guns\guns_righthand.dmi'
	lefthand_file = 'modular_skyrat\modules\assault_operatives\icons\guns\guns_lefthand.dmi'
	worn_icon = 'modular_skyrat\modules\assault_operatives\icons\guns\guns_worn.dmi'
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 12
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	actions_types = null
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	burst_size = 1
	fire_delay = 10
	company_flag = COMPANY_REMOVED

/obj/item/ammo_box/magazine/multi_sprite/norwind
	name = "\improper Norwind magazine"
	desc = "An eight-round magazine for the Norwind DMR, chambered for 12mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER)

/obj/item/ammo_box/magazine/multi_sprite/norwind/hp
	ammo_type = /obj/item/ammo_casing/b12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/norwind/rubber
	ammo_type = /obj/item/ammo_casing/b12mm/rubber
	round_type = AMMO_TYPE_RUBBER
