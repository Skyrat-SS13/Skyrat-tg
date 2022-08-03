/obj/item/gun/ballistic/automatic/plastikov/nri
	name = "\improper PP-542L SMG"
	desc = "An ancient 9mm submachine gun pattern updated and modernised to increase its efficiency."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns.dmi'
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	icon_state = "bison"
	inhand_icon_state = "bison"
	mag_type = /obj/item/ammo_box/magazine/plastikov9mm
	fire_delay = 1
	burst_size = 5
	dual_wield_spread = 10
	spread = 15
	can_suppress = FALSE
	projectile_damage_multiplier = 0.75 // It's like ~20 damage per bullet, it's close enough to less than 10 shots
	mag_display = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot_alt.ogg'
	company_flag = COMPANY_IZHEVSK
	dirt_modifier = 0.6

/obj/item/gun/ballistic/automatic/pistol/ladon/nri
	name = "\improper Szabo-Ivanek service pistol"
	desc = "A mass produced NRI-made modified reproduction of the PDH-6 line of handguns rechambered in 9×25mm.\
	 'PATRIOT DEFENSE SYSTEMS' is inscribed on the receiver, indicating it's been made with a plasteel printer."
	icon = 'modular_skyrat/modules/novaya_ert/icons/pistol.dmi'
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m9mm_aps
	dirt_modifier = 0.5
	emp_damageable = FALSE
	fire_delay = 3
	company_flag = COMPANY_IZHEVSK
