//////////////////GLOCK
/obj/item/gun/ballistic/automatic/pistol/g17
	name = "\improper Glock 17"
	desc = "A somewhat reliable 9mm sidearm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "glock"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/g17
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE

/obj/item/ammo_box/magazine/g17
	name = "g17 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 17
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/g17/hp
	name = "g17 handgun magazine (9mm hollowpoint)"
	icon_state = "g17_h"
	ammo_type = /obj/item/ammo_casing/b9mm/hp

/obj/item/ammo_box/magazine/g17/rubber
	name = "g17 handgun magazine (9mm rubber)"
	icon_state = "g17_r"
	ammo_type = /obj/item/ammo_casing/b9mm/rubber

/obj/item/ammo_box/magazine/g17/ihdf
	name = "g17 handgun magazine (9mm ihdf)"
	icon_state = "g17_i"
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf

/obj/item/gun/ballistic/automatic/pistol/g18
	name = "\improper Glock 18 Mil Spec"
	desc = "A somewhat reliable 9mm sidearm, this one is in the mil spec class. It has an extended mag."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "glock_spec"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/g18
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	burst_size = 3
	fire_delay = 1
	spread = 10
	actions_types = list(/datum/action/item_action/toggle_firemode)
	realistic = TRUE

/obj/item/ammo_box/magazine/g18
	name = "g18 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g18"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 33
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/g18/hp
	name = "g18 handgun magazine (9mm hollowpoint)"
	icon_state = "g18_h"
	ammo_type = /obj/item/ammo_casing/b9mm/hp

/obj/item/ammo_box/magazine/g18/rubber
	name = "g18 handgun magazine (9mm rubber)"
	icon_state = "g18_r"
	ammo_type = /obj/item/ammo_casing/b9mm/rubber

/obj/item/ammo_box/magazine/g18/ihdf
	name = "g18 handgun magazine (9mm ihdf)"
	icon_state = "g18_i"
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf



////////////////PDH
/obj/item/gun/ballistic/automatic/pistol/pdh
	name = "\improper PDH 'Osprey'"
	desc = "A modern ballistics sidearm, used by Nanotrasen and given to their command staff. It is chambered in 10mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pdh.dmi'
	icon_state = "pdh"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/pdh
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE

/obj/item/gun/ballistic/automatic/pistol/pdh/alt
	name = "\improper PDH 'Socom'"
	desc = "A pristegious ballistics sidearm, issued to only the highest ranking Nanotrasen employees, namely Captains. It has a 3 round burst mode."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pdh.dmi'
	icon_state = "pdh_alt"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/pdh
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	burst_size = 3
	fire_delay = 1
	spread = 10
	actions_types = list(/datum/action/item_action/toggle_firemode)
	realistic = TRUE

/obj/item/ammo_box/magazine/pdh
	name = "pdh handgun magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/pdh/hp
	name = "pdh handgun magazine (10mm hollowpoint)"
	icon_state = "pdh_h"
	ammo_type = /obj/item/ammo_casing/b10mm/hp

/obj/item/ammo_box/magazine/pdh/rubber
	name = "pdh handgun magazine (10mm rubber)"
	icon_state = "pdh_r"
	ammo_type = /obj/item/ammo_casing/b10mm/rubber

/obj/item/ammo_box/magazine/pdh/ihdf
	name = "pdh handgun magazine (10mm ihdf)"
	icon_state = "pdh_i"
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf

/////////////////////PCR

/obj/item/gun/ballistic/automatic/pcr
	name = "\improper AR-3 'Peacekeeper' Cyclic Rifle"
	desc = "A robustly made PCR, it's fairly accurate and has a decent rate of fire. This model is the Automatik-3, meaning 3 round burst. It is chambered in 4.6x30mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pcr.dmi'
	icon_state = "pcr"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/wt550m9
	fire_delay = 1
	can_suppress = FALSE
	burst_size = 3
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/pps/pps.ogg'

/////////////////DMR
/obj/item/gun/ballistic/automatic/dmr
	name = "\improper DMR 'Ripper' Gen-2"
	desc = "An incredibly powerful rifle, with an internal stabalisation gymbal. It's chambered in .577 Snider."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/dmr.dmi'
	icon_state = "dmr"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/dmr
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/batrifle_fire.ogg'

/obj/item/ammo_box/magazine/dmr
	name = "dmr magazine (.557 Snider)"
	icon_state = "dmr_mag"
	ammo_type = /obj/item/ammo_casing/b577
	caliber = ".557 Snider"
	max_ammo = 15

/obj/item/gun/energy/e_gun/Initialize(mapload)
	. = ..()
	new /obj/item/gun/ballistic/automatic/pcr(src.loc) //JANKY
	qdel(src)
