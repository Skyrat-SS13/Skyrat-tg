/obj/item/gun/ballistic/automatic/m16/oldarms
	name = "\improper Mk-11.4 Rifle"
	desc = "An old-fashioned rifle from Sol-3's bygone era. Rumor has it that it can shoot apart an entire jungle (or desert, given the time). It has \"Keep out of water\" laser-engraved on the side. Now including a free reflex sight!"
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
	fire_delay = 3.5
	burst_size = 1
	actions_types = list()
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/m16_fire.ogg'
	fire_sound_volume = 50
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magout.ogg'
	alt_icons = TRUE

/obj/item/gun/ballistic/automatic/m16/oldarms/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/ammo_box/magazine/m16/vintage/oldarms
	name = "old-fashioned mk-11.4 rifle magazine"
	desc = "A double-stack solid magazine that looks rather dated. Holds 20 rounds of .223 Stinger."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "m16"
	ammo_type = /obj/item/ammo_casing/oldarms/a223
	caliber = CALIBER_223
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_casing/oldarms/a223
	name = ".223 Stinger bullet casing"
	desc = "A cheaply made .233 Stinger bullet casing."
	caliber = CALIBER_223
	projectile_type = /obj/projectile/bullet/oldarms/a223

/obj/projectile/bullet/oldarms/a223
	name = ".223 bullet"
	damage = 26
	armour_penetration = 5
	wound_bonus = -20

/obj/item/ammo_casing/oldarms/a223/rubber
	name = ".223 Stinger rubber bullet casing"
	desc = "A cheaply made .233 Stinger bullet casing, now in rubber."
	caliber = CALIBER_223
	projectile_type = /obj/projectile/bullet/oldarms/a223/rubber

/obj/projectile/bullet/oldarms/a223/rubber
	name = ".223 Rubber"
	damage = 5
	stamina = 25
	ricochets_max = 3
	ricochet_incidence_leeway = 0
	ricochet_chance = 130
	ricochet_decay_damage = 0.5
	shrapnel_type = null
	sharpness = NONE
	embedding = null
