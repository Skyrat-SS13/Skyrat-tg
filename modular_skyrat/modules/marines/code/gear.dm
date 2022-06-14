/obj/item/gun/ballistic/automatic/ar/modular/m44a
	name = "\improper NT M44A Pulse Rifle"
	desc = "A specialized Nanotrasen-produced ballistic pulse rifle that uses compressed magazines to output absurd firepower in a compact package."
	icon_state = "m44a"
	icon = 'modular_skyrat/modules/marines/icons/m44a.dmi'
	righthand_file = 'odular_skyrat/modules/marines/icons/m44a_r.dmi'
	lefthand_file = 'odular_skyrat/modules/marines/icons/m44a_l.dmi'
	fire_sound = 'modular_skyrat/modules/marines/sound/m44a.ogg'
	fire_delay = 1
	burst_size = 3
	spread = 6
	can_suppress = FALSE
	emp_damageable = FALSE
	can_bayonet = FALSE
	realistic = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/m44a
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	company_flag = COMPANY_NANOTRASEN

/obj/item/ammo_box/magazine/multi_sprite/m44a
	name = "\improper .300 Compressed Magazine"
	desc = "This magazine uses a bluespace compression chamber to hold a maximum of 99 .300 caliber caseless rounds for the M44A pulse rifle."
	icon = 'modular_skyrat/modules/marines/icons/m44a.dmi'
	icon_state = "300compressed"
	max_ammo = 99
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = AMMO_TYPE_LETHAL
	ammo_type = /obj/item/ammo_casing/caseless/300comp
	caliber = "300c"

/obj/item/ammo_casing/caseless/300comp
	name = ".300 caseless round"
	desc = "A .300 caseless round for proprietary Nanotrasen firearms."
	caliber = "300c"
	projectile_type = /obj/projectile/bullet/300c

/obj/projectile/bullet/300c
	name = ".300 caseless bullet"
	damage = 20
	armor_penetration = 30
	embedding = null
	shrapnel_tyle = null
