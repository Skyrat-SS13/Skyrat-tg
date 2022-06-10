/obj/item/gun/ballistic/automatic/m16/oldarms
	name = "\improper Mk-11.4 Rifle"
	desc = "An old-fashioned rifle from Sol-3's bygone era, rumor has it, it can shoot apart an entire jungle given the time, has \"Keep out of water\" laser-engraved on the side."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "m16"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "m16"
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "m16"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/m16/vintage/oldarms
  fire_delay = 1.9
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/m16_fire.ogg'
	fire_sound_volume = 50
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magout.ogg'
	alt_icons = TRUE
	realistic = TRUE
  fire_select_modes = list(SELECT_SEMI_AUTOMATIC, SELECT_FULLY_AUTOMATIC)
  
  
  /obj/item/ammo_box/magazine/m16/vintage/oldarms
	name = "old-fashioned mk-11.4 rifle magazine"
	desc = "A double-stack solid magazine that looks rather dated. Holds 20 rounds of .277 Aestus."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16"
	ammo_type = /obj/item/ammo_casing/oldarms/a223
	caliber = "223"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY
  
  /obj/item/ammo_casing/oldarms/a223
	name = "5.56x45mm bullet casing"
	desc = "A cheaply made 5.56x45mm bullet casing."
	caliber = CALIBER_223
	projectile_type = /obj/projectile/bullet/oldarms/a223

/obj/projectile/bullet/oldarms/a223
  name = "5.56mm bullet"
	damage = 26
	armour_penetration = 5
	wound_bonus = -20
