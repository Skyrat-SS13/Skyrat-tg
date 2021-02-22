/*-----------------------
	Gun
------------------------*/
/obj/item/weapon/gun/projectile/automatic/bullpup
	name = "SCAF Bullpup Rifle"
	desc = "The standard issued rifle of the Sovereign Colonies Armed Forces. "
	icon = 'icons/obj/weapons/ds13guns48x32.dmi'
	icon_state = "bullpuprifle"
	item_state = "bullpuprifle"
	wielded_item_state = "bullpuprifle-wielded"
	w_class = ITEM_SIZE_HUGE
	handle_casings = CLEAR_CASINGS
	magazine_type = /obj/item/ammo_magazine/bullpup
	allowed_magazines = /obj/item/ammo_magazine/bullpup
	load_method = MAGAZINE
	caliber = "bullpup"
	slot_flags = SLOT_BACK
	ammo_type = /obj/item/ammo_casing/pulse
	mag_insert_sound = 'sound/weapons/guns/interaction/smg_magin.ogg'
	mag_remove_sound = 'sound/weapons/guns/interaction/smg_magout.ogg'
	one_hand_penalty = 6	//Don't try to fire this with one hand
	dispersion = list()

	aiming_modes = list(/datum/extension/aim_mode/rifle)

	firemodes = list(
		FULL_AUTO_300,
		list(mode_name="semiauto", fire_delay=2)
		)



/*-----------------------
	Ammo
------------------------*/

/obj/item/ammo_casing/bullpup
	name = "bullpup round"
	desc = "A low caliber round designed for the SWS motorized pulse rifle"
	caliber = "bullpup"
	icon_state = "rifle_casing"
	spent_icon = "rifle_casing-spent"
	projectile_type  = /obj/item/projectile/bullet/bullpup


/obj/item/projectile/bullet/bullpup
	damage = 9
	step_delay = 1.2
	expiry_method = EXPIRY_FADEOUT

/obj/item/ammo_magazine/bullpup
	name = "SCAF universal ammo"
	desc = "A pack of 20 rounds to fit the SCAF bullpup rifle"
	icon = 'icons/obj/ammo.dmi'
	icon_state = "bullpup"
	caliber = "bullpup"
	ammo_type = /obj/item/ammo_casing/bullpup
	matter = list(MATERIAL_STEEL = 1260)
	max_ammo = 20
	multiple_sprites = TRUE
	mag_type = MAGAZINE


