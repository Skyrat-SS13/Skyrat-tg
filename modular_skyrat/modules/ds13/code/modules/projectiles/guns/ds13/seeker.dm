/obj/item/weapon/gun/projectile/seeker
	name = "Seeker Rifle"
	desc = "The Seeker Rifle is a riot control device that is meant for accuracy at long-range. Comes with a built in scope"
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "seeker"
	item_state = "seeker"
	wielded_item_state = "seeker-wielded"
	w_class = ITEM_SIZE_HUGE
	handle_casings = CLEAR_CASINGS
	magazine_type = /obj/item/ammo_magazine/seeker
	allowed_magazines = /obj/item/ammo_magazine/seeker
	load_method = MAGAZINE
	caliber = "seeker"
	slot_flags = SLOT_BACK
	accuracy = -30	//Don't try to hipfire
	ammo_type = /obj/item/ammo_casing/seeker
	mag_insert_sound = 'sound/weapons/guns/interaction/rifle_load.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/pulse_magout.ogg'
	one_hand_penalty = -30	//Don't try to fire this with one hand
	fire_sound = 'sound/weapons/gunshot/sniper.ogg'
	aiming_modes = list(/datum/extension/aim_mode/sniper/seeker, /datum/extension/aim_mode/sniper/seeker/far, /datum/extension/aim_mode/sniper/seeker/near)


	firemodes = list(
		list(mode_name="semi-automatic",  fire_delay=10),
		)

/obj/item/weapon/gun/projectile/seeker/empty
	magazine_type = null

/*-----------------------
	Ammo
------------------------*/

/obj/item/ammo_casing/seeker
	name = "seeker shell"
	desc = "A high caliber round designed for the Seeker marksman rifle"
	icon_state = "empshell"
	spent_icon = "empshell-spent"
	projectile_type  = /obj/item/projectile/bullet/seeker
	caliber = "seeker"


/obj/item/projectile/bullet/seeker
	icon_state = "seeker"
	damage = 60
	embed = 1
	structure_damage_factor = 3
	penetration_modifier = 1.25
	penetrating = TRUE
	step_delay = 0.75	//Real fast
	expiry_method = EXPIRY_FADEOUT
	fire_sound = 'sound/weapons/gunshot/sniper.ogg'
	stun = 3
	weaken = 3
	penetrating = 5
	armor_penetration = 10


/obj/item/ammo_magazine/seeker
	name = "seeker shells"
	desc = "High caliber armor piercing shells designed for use in the Seeker Rifle"
	icon = 'icons/obj/ammo.dmi'
	icon_state = "seekerclip"
	caliber = "seeker"
	ammo_type = /obj/item/ammo_casing/seeker
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 5
	multiple_sprites = TRUE
	mag_type = MAGAZINE

/obj/item/ammo_magazine/seeker/update_icon()
	overlays.Cut()
	if (stored_ammo.len)
		overlays += image('icons/obj/ammo.dmi', "sc-[stored_ammo.len]")



/*------------------
	Aiming Modes
------------------*/
/datum/extension/aim_mode/sniper/seeker
	name = "2x Zoom"
	damage_mod = 0.5	//The seeker does far more damage when scoped
	view_offset	=	8*WORLD_ICON_SIZE
	view_range = -2
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.85,
	STATMOD_RANGED_ACCURACY = 70)

/datum/extension/aim_mode/sniper/seeker/far
	name = "4x Zoom"
	damage_mod = 0.6
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.85,
	STATMOD_RANGED_ACCURACY = 80)
	view_offset	=	16*WORLD_ICON_SIZE
	view_range = -3

/datum/extension/aim_mode/sniper/seeker/near
	name = "reflex sight"
	damage_mod = 0.25
	view_offset	=	4*WORLD_ICON_SIZE
	view_range = -1
	statmods = list(STATMOD_MOVESPEED_ADDITIVE = -0.85,
	STATMOD_RANGED_ACCURACY = 60)




/*
	Acquisition
*/
/decl/hierarchy/supply_pack/security/seeker_ammo
	name = "Ammunition - Seeker Shells"
	contains = list(/obj/item/ammo_magazine/seeker = 8)
	cost = 80
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "\improper seeker shells crate"
	access = access_security
	security_level = SUPPLY_SECURITY_ELEVATED


/decl/hierarchy/supply_pack/security/seeker_rifle
	name = "Weapon - Seeker Rifle"
	contains = list(/obj/item/ammo_magazine/seeker = 4,
	/obj/item/weapon/gun/projectile/seeker/empty = 1)
	cost = 80
	containertype = /obj/structure/closet/crate/secure/weapon
	containername = "\improper seeker rifle crate"
	access = access_security
	security_level = SUPPLY_SECURITY_ELEVATED