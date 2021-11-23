/* Removed until someone fixes it.
/obj/item/melee/energy/sword/ignis
	name = "\improper FTU 'Ignis' plasma sword"
	desc = "An expensive FTU design, the Ignis is one of many prototypes at making an energy sword out of plasma, rather than hardlight. This one has the FTU flag imprinted on its high-quality wooden hilt, and unlike earlier models, can sustain several hits without exhausting its battery. "
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi'
	icon_state = "ignis"
	icon_state_on = "ignis_active"
	lefthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/righthand.dmi'
	force = 3
	force_on = 48
	block_chance = 65
	sharpness = SHARP_EDGED
	sword_color = null
	throwforce = 5
	throwforce_on = 40
	wound_bonus = 50
	hitsound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/ignis_hit.ogg'
	throw_speed = 4
	throw_range = 10
	w_class = WEIGHT_CLASS_SMALL
	w_class_on = WEIGHT_CLASS_HUGE
	armour_penetration = 90
	attack_verb_on = list("rips", "evaporates", "penetrates", "tears", "lacerates", "impales", "masterfully brutalizes")
	resistance_flags = FIRE_PROOF
	damtype = BURN

/obj/item/melee/energy/sword/ignis/transform_messages(mob/living/user, supress_message_text)
	playsound(user, 'modular_skyrat/modules/ERT_Factions/FTU/sound/ignis_toggle.ogg', 35, TRUE)  //changed it from 50% volume to 35% because deafness
	if(!supress_message_text)
		to_chat(user, span_notice("[src] [active ? "is now active":"can now be concealed"]."))
*/

///////40x32 R37 PULSE RIFLE
/obj/item/gun/ballistic/automatic/pitbull/pulse/r37
	name = "\improper Xan-Jing R37 'Killer Hornet' Pulse Rifle"
	desc = "A Xan-Jing Armories pulse rifle, nicknamed 'Killer Hornet' by FTU Mercenaries and Expeditioners. This one has an integrated computer that displays an objective compass, ammo counter and comes with a HUD link for easy targetting."
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi'
	righthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/lefthand.dmi'
	lefthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/lefthand.dmi'
	inhand_icon_state = "killerhornet_lefthand"
	icon_state = "killerhornet"
	worn_icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi'
	worn_icon_state = "killerhornet_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/pulse/r37
	fire_delay = 4
	can_suppress = FALSE
	burst_size = 5
	spread = 3
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/r37.ogg'
	emp_damageable = FALSE
	armadyne = FALSE
	can_bayonet = FALSE
	can_flashlight = TRUE
	mag_type = /obj/item/ammo_box/magazine/pulse/r37

/obj/item/ammo_box/magazine/pulse/r37
	name = "6.5mm XJP box magazine"
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/mags.dmi'
	icon_state = "hornet"
	ammo_type = /obj/item/ammo_casing/pulse/mm65
	caliber = "6.5mm"
	max_ammo = 36


///////40x32 R40 MACHINE GUN
/obj/item/gun/ballistic/automatic/pitbull/pulse/r40
	name = "\improper Xan-Jing R40 'Enforcer' Pulse MMG"
	desc = "A Xan-Jing Armories medium machine gun, nicknamed 'Enforcer' by FTU Mercenaries and Private Militaries. This one has a custom wood furnishing and its batteries power up the sights."
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi'
	righthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/righthand.dmi'
	inhand_icon_state = "enforcer_righthand"
	icon_state = "enforcer"
	worn_icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi'
	worn_icon_state = "killerhornet_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/pulse/r40
	fire_delay = 1
	can_suppress = FALSE
	burst_size = 8
	spread = 5
	mag_display = TRUE
	mag_display_ammo = FALSE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/r40.ogg'
	emp_damageable = FALSE
	armadyne = FALSE
	can_bayonet = FALSE
	can_flashlight = TRUE
	mag_type = /obj/item/ammo_box/magazine/pulse/r40

/obj/item/ammo_box/magazine/pulse/r40
	name = "7.2mm XJP belted box"
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/mags.dmi'
	icon_state = "enforcer"
	ammo_type = /obj/item/ammo_casing/pulse/mm72
	caliber = "7.2mm"
	max_ammo = 140

//////////12.7 SAPHE GOLDEN EAGLE
/obj/item/gun/ballistic/automatic/pistol/pdh/pulse/golden_eagle
	name = "\improper FTU PDH-6G 'Sea Serpent' Magnum"
	desc = "A custom-made high-power combat pistol seen in the hands of high ranking FTU Mercenaries and important executives, with a custom 24-karat gold finish and green laser sight. It has a chinese dragon engraved along its slide."
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi'
	icon_state = "eagle"
	can_suppress = FALSE
	mag_display = TRUE
	fire_sound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/serpent_fire.ogg'
	fire_sound_volume = 100
	rack_sound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/magnum_slide.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/pulse/mm12/saphe
	can_suppress = FALSE
	fire_delay = 25 //Mind your wrists.
	fire_sound_volume = 110
	rack_sound_volume = 110
	spread = 1
	realistic = TRUE
	can_flashlight = FALSE
	emp_damageable = FALSE

/obj/item/ammo_box/magazine/pulse/mm12/saphe
	name = "12.7x35mm SAP-HE Magnum magazine"
	icon_state = "50ae"
	ammo_type = /obj/item/ammo_casing/pulse/mm12
	caliber = "12mm SAP-HE"
	max_ammo = 12
