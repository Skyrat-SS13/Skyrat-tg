/obj/item/gun/ballistic/automatic/pistol/pdh
	name = "\improper PDH-6H 'Osprey'"
	desc = "A modern ballistics sidearm, used primarily by the military, however this one has had a paintjob to match command. It's chambered in 12.7x30mm."
	icon = 'modular_skyrat/master_files/icons/obj/guns/pdh.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/obj/guns/inhands/lefthand40x32.dmi'
	icon_state = "pdh"
	inhand_icon_state = "pdh"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	dirt_modifier = 0.3
	emp_damageable = TRUE
	company_flag = COMPANY_ARMADYNE

/obj/item/gun/ballistic/automatic/pistol/pdh/add_seclight_point()
	AddComponent(/datum/component/seclite_attachable, light_overlay_icon = 'icons/obj/weapons/guns/flashlights.dmi', light_overlay = "flight")

/obj/item/gun/ballistic/automatic/pistol/pdh/alt
	name = "\improper PDH-6C 'SOCOM'"
	desc = "A prestigious 12mm sidearm normally seen in the hands of SolFed special operation units due to its reliable and time-tested design. Now's one of those times that pays to be the strong, silent type."
	icon_state = "pdh_alt"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_suppressed.ogg'
	fire_delay = 8
	fire_sound_volume = 30
	spread = 1
	realistic = TRUE
	dirt_modifier = 0.1
	emp_damageable = FALSE

/obj/item/ammo_box/magazine/multi_sprite/pdh
	name = "12mm PDH-6 magazine"
	desc = "A heavy 12mm magazine made for the PDH-6H and PDH-6C handguns."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list("lethal" = AMMO_TYPE_LETHAL, "hollowpoint" = AMMO_TYPE_HOLLOWPOINT, "rubber" = AMMO_TYPE_RUBBER)

/obj/item/ammo_box/magazine/multi_sprite/pdh/hp
	ammo_type = /obj/item/ammo_casing/b12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pdh/rubber
	ammo_type = /obj/item/ammo_casing/b12mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/gun/ballistic/automatic/pistol/pdh/corpo
	name = "\improper PDH-6M 'Corpo'"
	desc = "A prestigious ballistic sidearm, from Armadyne's military division, normally given to corporate agents. It has a 3 round burst mode and uses .357 Magnum ammunition."
	icon_state = "pdh_corpo"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	burst_size = 3
	fire_delay = 2
	spread = 5
	realistic = TRUE
	dirt_modifier = 0.1
	company_flag = COMPANY_ARMADYNE

/obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	name = "\improper PDH-6M magazine"
	desc = "A magazine for Armadyne's exclusive corporate handgun. Chambered for .357, to your disgrace."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = "357"
	max_ammo = 14
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list("lethal" = AMMO_TYPE_LETHAL)

/*
*	PDH PEACEKEEPER
*/

/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper
	name = "\improper PDH-6B"
	desc = "A modern ballistic sidearm, used primarily by law enforcement, chambered in 9mm Peacekeeper."
	fire_delay = 1.95
	icon_state = "pdh_peacekeeper"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	realistic = TRUE
	dirt_modifier = 0.6
	company_flag = COMPANY_ARMADYNE

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper
	name = "\improper PDH-6B magazine"
	desc = "A magazine for the PDG-6B law enforcement pistol, chambered for 9mm Peacekeeper ammo."
	icon = 'modular_skyrat/master_files/icons/obj/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MMPEACE
	max_ammo = 16
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER
