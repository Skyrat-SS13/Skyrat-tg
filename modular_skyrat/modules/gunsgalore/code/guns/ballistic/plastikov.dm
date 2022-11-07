/obj/item/gun/ballistic/automatic/plastikov
	name = "\improper PP-95 SMG"
	desc = "An ancient 9mm submachine gun pattern updated and simplified to lower costs, though perhaps simplified too much."
	icon_state = "plastikov"
	inhand_icon_state = "plastikov"
	mag_type = /obj/item/ammo_box/magazine/plastikov9mm
	burst_size = 5
	spread = 15
	can_suppress = FALSE
	projectile_damage_multiplier = 0.35 // It's like 10.5 damage per bullet, it's close enough to 10 shots
	mag_display = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot_alt.ogg'
	company_flag = COMPANY_IZHEVSK
	dirt_modifier = 0.75

/obj/item/gun/ballistic/automatic/plastikov/nri
	name = "\improper PP-542L SMG"
	desc = "An ancient 9mm submachine gun pattern updated and modernised to increase its efficiency."
	icon = 'modular_skyrat/master_files/icons/obj/guns/gunsgalore_guns.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/gunsgalore_righthand.dmi'
	icon_state = "bison"
	inhand_icon_state = "bison"
	mag_type = /obj/item/ammo_box/magazine/plastikov9mm
	fire_delay = 1
	burst_size = 5
	dual_wield_spread = 10
	spread = 10
	can_suppress = FALSE
	projectile_damage_multiplier = 0.75 // It's like ~20 damage per bullet, it's close enough to less than 10 shots
	mag_display = TRUE
	empty_indicator = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot_alt.ogg'
	company_flag = COMPANY_IZHEVSK
	dirt_modifier = 0.6

/obj/item/gun/ballistic/automatic/plastikov/nri_pirate
	name = "\improper PP-105 SMG"
	desc = "An ancient 9mm submachine gun pattern updated and modernised to increase its efficiency, although very insignificantly."
	icon = 'modular_skyrat/master_files/icons/obj/guns/gunsgalore_guns.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/gunsgalore_righthand.dmi'
	icon_state = "bizon"
	inhand_icon_state = "bizon"
	fire_delay = 1
	burst_size = 3
	dual_wield_spread = 10
	spread = 10
	projectile_damage_multiplier = 0.35 // It's like 10.5 damage per bullet, it's close enough to 10 shots
	mag_display = TRUE
	empty_indicator = TRUE
	dirt_modifier = 1.25
