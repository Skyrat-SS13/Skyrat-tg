// La Pistola

/obj/item/gun/ballistic/automatic/pistol/clandestine/assault_ops
	name = "\improper IGE-040 pistol"
	desc = "A pistol chambered in 10mm magnum and painted in an ominous matte black. Strangely, the gun also seems to lack any form of manufacturer markings."

/obj/item/gun/ballistic/automatic/pistol/clandestine/assault_ops/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_REMOVED)

/obj/item/gun/energy/e_gun/advtaser/assault_ops
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/gun/energy/e_gun/advtaser/assault_ops/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_REMOVED)

// Rifle

/obj/item/gun/ballistic/automatic/assault_ops_rifle
	name = "\improper IGE-110 rifle"
	desc = "A bullpup rifle chambered in 5.6x40mm and painted in an ominous matte black. Strangely, the gun also seems to lack any form of manufacturer markings."

	icon_state = "ige_assault"
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns.dmi'
	inhand_icon_state = "ige_assault"
	righthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_lefthand.dmi'
	worn_icon_state = "ige_assault"
	worn_icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_worn.dmi'

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sfrifle_fire.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 4
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	burst_size = 2
	fire_delay = 3
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/assault_ops_rifle/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/gun/ballistic/automatic/assault_ops_rifle/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_REMOVED)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle
	name = "\improper IGE-110 magazine"
	desc = "A twenty round magazine built for 5.6x40mm, intended for use in the IGE-110 rifle."
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/magazines.dmi'
	icon_state = "ige_assault_mag"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39
	caliber = "a762x39"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_AP)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle/rubber
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/civilian/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_rifle/ap
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/ap
	round_type = AMMO_TYPE_AP

// SMG

/obj/item/gun/ballistic/automatic/assault_ops_smg
	name = "\improper IGE-260 submachine gun"
	desc = "A toploader submachine gun chambered in 9x25mm and painted in an ominous matte black. Strangely, the gun also seems to lack any form of manufacturer markings."

	icon_state = "ige_smg"
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns.dmi'
	inhand_icon_state = "ige_smg"
	righthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_lefthand.dmi'
	worn_icon_state = "ige_smg"
	worn_icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_worn.dmi'

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/smg_fire.ogg'
	can_suppress = TRUE
	burst_size = 1
	fire_delay = 0.8
	projectile_damage_multiplier = 0.6
	actions_types = list()
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/assault_ops_smg/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/assault_ops_smg/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_REMOVED)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg
	name = "\improper IGE-260 magazine"
	desc = "A forty round magazine built for 9x25mm, intended for use in the IGE-260 submachine gun."
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/magazines.dmi'
	icon_state = "ige_smg_mag"
	ammo_type = /obj/item/ammo_casing/c9mm
	caliber = CALIBER_9MM
	max_ammo = 40
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_HOLLOWPOINT)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg/rubber
	ammo_type = /obj/item/ammo_casing/c9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_smg/hp
	ammo_type = /obj/item/ammo_casing/c9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

// Shotgun

/obj/item/gun/ballistic/automatic/assault_ops_shotgun
	name = "\improper IGE-340 semi-automatic shotgun"
	desc = "A magazine fed semi-automatic shotgun chambered in 12 GA and painted in an ominous matte black. Strangely, the gun also seems to lack any form of manufacturer markings."

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
	burst_size = 1
	fire_delay = 1.5
	actions_types = list()
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/automatic/assault_ops_shotgun/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_REMOVED)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_shotgun
	name = "\improper IGE-340 magazine"
	desc = "A seven round magazine built for 12 GA, intended for use in the IGE-340 shotgun."
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/magazines.dmi'
	icon_state = "ige_shotgun_mag"
	ammo_type = /obj/item/ammo_casing/shotgun
	caliber = CALIBER_SHOTGUN
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY
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

// Sniper

/obj/item/gun/ballistic/rifle/boltaction/assault_ops_sniper
	name = "\improper IGE-410-S marksman rifle"
	desc = "A magazine fed bolt-action rifle with a short enough barrel that your shoulder hurts just looking at it. Chambered in .416 Stabilis, it is painted in an ominous matte black and seems to lack any form of manufacturer markings."

	icon_state = "ige_sniper"
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns.dmi'
	inhand_icon_state = "ige_sniper"
	righthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_lefthand.dmi'
	worn_icon_state = "ige_sniper"
	worn_icon = 'modular_skyrat/modules/assault_operatives/icons/guns/guns_worn.dmi'

	base_pixel_x = -8
	pixel_x = -8

	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	internal_magazine = FALSE
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sniper_fire.ogg'
	can_suppress = TRUE
	suppressor_x_offset = 6
	suppressed_sound = 'sound/weapons/gun/general/heavy_shot_suppressed.ogg'
	burst_size = 1
	fire_delay = 10
	recoil = 3
	can_be_sawn_off = FALSE
	can_jam = FALSE
	pin = /obj/item/firing_pin/implant/pindicate

/obj/item/gun/ballistic/rifle/boltaction/assault_ops_sniper/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/scope, range_modifier = 2.5)

/obj/item/gun/ballistic/rifle/boltaction/assault_ops_sniper/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_REMOVED)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper
	name = "\improper IGE-410 magazine"
	desc = "A five round magazine built for .416 Stabilis, intended for use in the IGE-410 sniper."
	icon = 'modular_skyrat/modules/assault_operatives/icons/guns/magazines.dmi'
	icon_state = "ige_sniper_mag"
	ammo_type = /obj/item/ammo_casing/p50
	caliber = CALIBER_50BMG
	max_ammo = 5
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_AP)

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper/sleepytime
	ammo_type = /obj/item/ammo_casing/p50/soporific
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/assault_ops_sniper/penetrator
	ammo_type = /obj/item/ammo_casing/p50/penetrator
	round_type = AMMO_TYPE_AP
