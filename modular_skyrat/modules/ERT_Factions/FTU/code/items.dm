/obj/item/melee/transforming/energy/sword/ignis
	name = "\improper FTU 'Ignis' plasma sword"
	desc = "An expensive FTU design, the Ignis is one of many prototypes at making an energy sword out of plasma, rather than hardlight. This one has the FTU flag imprinted on its high-quality wooden hilt, and unlike earlier models, can sustain several hits without exhausting its battery. "
	icon = modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi
	icon_state = "ignis"
	icon_state_on = "ignis_active"
	lefthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/righthand.dmi'
	force = 3
	force_on = 48
	block_chance = 70
	sharpness = SHARP_EDGED
	sword_color = null
	throwforce = 5
	throwforce_on = 40
	wound_bonus = 50
	hitsound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/ignis_hit.ogg'
	on_sound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/ignis_toggle.ogg'
	throw_speed = 4
	throw_range = 10
	w_class = WEIGHT_CLASS_SMALL
	w_class_on = WEIGHT_CLASS_HUGE
	armour_penetration = 90
	attack_verb_on = list("rips", "evaporates", "penetrates", "tears", "lacerates", "impales", "masterfully brutalizes")
	resistance_flags = FIRE_PROOF
	
	
	///////40x32 R37 PULSE RIFLE
	/obj/item/gun/ballistic/automatic/pitbull/pulse/r37
	name = "\improper Xan-Jing 'Killer Hornet' Pulse Rifle"
	desc = "A Xan-Jing Armories pulse rifle, nicknamed 'Killer Hornet' by FTU Mercenaries and Expeditioners. This one has an integrated computer that displays an objective compass, ammo counter and comes with a HUD link for easy targetting."
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/serviceguns.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
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
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/ERT_Factions/FTU/sound/r37.ogg'
	emp_damageable = FALSE
	armadyne = FALSE
	can_bayonet = FALSE
	can_flashlight = TRUE
	
	/obj/item/ammo_box/magazine/pulse/r37
	name = "6.5mm XJP box magazine"
	icon = 'modular_skyrat/modules/ERT_Factions/FTU/icons/weapons/mags.dmi'
	icon_state = "hornet"
	ammo_type = /obj/item/ammo_casing/pulse/65mm
	caliber = "6.5mm"
	max_ammo = 36
