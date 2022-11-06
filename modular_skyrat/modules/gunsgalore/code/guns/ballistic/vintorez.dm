/obj/item/gun/ballistic/automatic/vintorez
	name = "\improper VKC 'Vintorez'"
	desc = "The VKC Vintorez is a lightweight integrally-suppressed scoped carbine usually employed in stealth operations. It was rechambered to 9x19mm for peacekeeping work."
	icon = 'modular_skyrat/master_files/icons/obj/guns/vintorez.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand.dmi'
	icon_state = "vintorez"
	worn_icon = 'modular_skyrat/master_files/icons/obj/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	alt_icons = TRUE
	alt_icon_state = "vintorez_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	inhand_icon_state = "vintorez"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/vintorez
	suppressed = TRUE
	can_unsuppress = FALSE
	can_bayonet = FALSE
	mag_display = FALSE
	mag_display_ammo = FALSE
	realistic = TRUE
	burst_size = 2
	fire_delay = 4
	spread = 10
	fire_sound = 'sound/weapons/gun/smg/shot_suppressed.ogg'
	emp_damageable = TRUE
	company_flag = COMPANY_OLDARMS

/obj/item/gun/ballistic/automatic/vintorez/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/scope, range_modifier = 1.5)

/obj/item/ammo_box/magazine/multi_sprite/vintorez
	name = "\improper VKC magazine"
	desc = "A twenty-round magazine for the VKC marksman rifle, chambered in 9mm Peacekeeper."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MMPEACE
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/vintorez/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/vintorez/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/vintorez/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER
