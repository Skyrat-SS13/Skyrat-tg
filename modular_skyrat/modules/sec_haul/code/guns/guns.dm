//////////////////GLOCK
/obj/item/gun/ballistic/automatic/pistol/g17
	name = "\improper Glock 17"
	desc = "A somewhat reliable 9mm sidearm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "glock"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g17
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/pistol/shot_alt.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE

/obj/item/ammo_box/magazine/multi_sprite/g17
	name = "g17 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 17
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/g17/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g17/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/g17/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/gun/ballistic/automatic/pistol/g18
	name = "\improper Glock 18 Mil Spec"
	desc = "A somewhat reliable 9mm sidearm, this one is in the mil spec class. It has an extended mag."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "glock_spec"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g18
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

/obj/item/ammo_box/magazine/multi_sprite/g18
	name = "g18 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g18"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 33
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/g18/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g18/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/g18/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF


////////////////PDH
/obj/item/gun/ballistic/automatic/pistol/pdh
	name = "\improper PDH 'Osprey'"
	desc = "A modern ballistics sidearm, used by Nanotrasen and given to their command staff. It is chambered in 10mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pdh.dmi'
	icon_state = "pdh"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh
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
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh
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

/obj/item/ammo_box/magazine/multi_sprite/pdh
	name = "pdh handgun magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/pdh/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pdh/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/pdh/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/////////////////////PCR

/obj/item/gun/ballistic/automatic/pcr
	name = "\improper AR-3 'Peacekeeper' Cyclic Rifle"
	desc = "A robustly made PCR, it's fairly accurate and has a decent rate of fire. This model is the Automatik-3, meaning 3 round burst. It is chambered in 9mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pcr.dmi'
	icon_state = "pcr"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pcr
	fire_delay = 1.5
	can_suppress = FALSE
	burst_size = 3
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/smg_fire.ogg'

/obj/item/ammo_box/magazine/multi_sprite/pcr
	name = "pcr smg magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 25
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/multi_sprite/pcr/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pcr/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/pcr/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/////////////////////NORWIND

/obj/item/gun/ballistic/automatic/norwind
	name = "\improper LG-2 'Norwind' Rifle"
	desc = "The Norwind is one of the rarer rifle types, it's chambered in 12mm but has a low magazine capacity and firerate. Scoped to zoom."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "norwind"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	inhand_icon_state = "norwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	alt_icons = TRUE
	alt_icon_state = "norwind_worn"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/norwind
	fire_delay = 4
	can_suppress = FALSE
	burst_size = 2
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	zoomable = TRUE
	zoom_amt = 7
	zoom_out_amt = 5
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'

/obj/item/ammo_box/magazine/multi_sprite/norwind
	name = "norwind rifle magazine (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = "12mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY
	possible_types = list("lethal" = AMMO_TYPE_LETHAL, "hollowpoint" = AMMO_TYPE_HOLLOWPOINT, "rubber" = AMMO_TYPE_RUBBER)

/obj/item/ammo_box/magazine/multi_sprite/norwind/hp
	ammo_type = /obj/item/ammo_casing/b12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/norwind/rubber
	ammo_type = /obj/item/ammo_casing/b12mm/rubber
	round_type = AMMO_TYPE_RUBBER


/////////////////DMR
/obj/item/gun/ballistic/automatic/dmr
	name = "\improper DMR 'Ripper' Gen-2" //TBA
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
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sniper_fire.ogg'

/obj/item/ammo_box/magazine/dmr
	name = "dmr magazine (.557 Snider)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "dmr_mag"
	ammo_type = /obj/item/ammo_casing/b577
	caliber = ".557 Snider"
	max_ammo = 15

/////////////////SMARTGUN
/obj/item/gun/ballistic/automatic/smartgun
	name = "\improper ArmaTek 'S-M-A-R-T-GUN'"
	desc = "The SMARTGUN is one of ArmaTek finest creations in regards to law enforcement and shredding things. Some say they use thses to shred paper."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/smartgun.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "smartgun"
	w_class = WEIGHT_CLASS_HUGE
	weapon_weight = WEAPON_HEAVY
	slot_flags = ITEM_SLOT_BACK
	inhand_icon_state = "smartgun_worn"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/smartgun.dmi'
	worn_icon_state = "smartgun_worn"
	mag_type = /obj/item/ammo_box/magazine/smartgun
	can_suppress = FALSE
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_alarm = TRUE
	tac_reloads = FALSE
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_fire.ogg'
	rack_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_cock.ogg'
	lock_back_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_open.ogg'
	bolt_drop_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_cock.ogg'
	load_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magin.ogg'
	eject_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magout.ogg'
	load_empty_sound = 'modular_skyrat/modules/sec_haul/sound/chaingun_magout.ogg'

/obj/item/gun/ballistic/automatic/smartgun/update_icon()
	. = ..()
	if(!magazine)
		icon_state = "smartgun_open"
	else
		icon_state = "smartgun_closed"

/obj/item/ammo_box/magazine/smartgun
	name = "smartgun magazine (smartgun)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "smartgun"
	ammo_type = /obj/item/ammo_casing/smartgun
	caliber = "smartgun"
	max_ammo = 5
	multiple_sprites = AMMO_BOX_PER_BULLET

/obj/item/gun/ballistic/automatic/smartgun/nomag
	spawnwithmagazine = FALSE

/obj/structure/closet/secure_closet/smartgun
	name = "Smartgun Locker"
	req_access = list(ACCESS_ARMORY)
	icon_state = "shotguncase"

/obj/structure/closet/secure_closet/smartgun/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/smartgun/nomag(src)
	new /obj/item/ammo_box/magazine/smartgun(src)
	new /obj/item/ammo_box/magazine/smartgun(src)
	new /obj/item/ammo_box/magazine/smartgun(src)
