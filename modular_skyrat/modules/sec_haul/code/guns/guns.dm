/obj/item/gun/ballistic
	var/emp_damageable = FALSE
	var/armadyne = FALSE

/obj/item/gun/ballistic/automatic/emp_act(severity)
	. = ..()
	if(emp_damageable)
		jammed = TRUE
		playsound(src, 'sound/effects/stall.ogg', 60, TRUE)
		if(magazine)
			magazine.forceMove(src.loc)
			playsound(src, load_empty_sound, load_sound_volume, load_sound_vary)

/obj/item/gun/ballistic/automatic/examine(mob/user)
	. = ..()
	if(!emp_damageable)
		. += "It has an EMP prevention system."
	if(armadyne)
		. +=  "It has an <p style='color:red'>Armadyne</p> embroidery on the grip."

//////////////////GLOCK
/obj/item/gun/ballistic/automatic/pistol/g17
	name = "\improper Armadyne Glock-17"
	desc = "A weapon from bygone times, this has been made to feel and look exactly like the 21st century version. Let's hope it's more reliable. Chambered in 9mm."
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
	can_flashlight = TRUE
	dirt_modifier = 1.7
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/g17
	name = "g17 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 17
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

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
	name = "\improper Armadyne Glock-18 Mil Spec"
	desc = "A special anniversary edition of the Glock-18 from Armadyne, it has a 3 round burst mode and extended mag."
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
	mag_display = FALSE
	mag_display_ammo = FALSE
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/g18
	name = "g18 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g18"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 33
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/g18/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g18/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/g18/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF


////////////////PDH 40x32
/obj/item/gun/ballistic/automatic/pistol/pdh
	name = "\improper Armadyne PDH 'Osprey'"
	desc = "A modern ballistics sidearm, used primarily by the military, however this one has had a paintjob to match command. It's chambered in 12mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pdh.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
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
	armadyne = TRUE
	can_flashlight = TRUE

/obj/item/gun/ballistic/automatic/pistol/pdh/alt
	name = "\improper Armadyne PDH 'Socom'"
	desc = "A pristegious ballistics sidearm, from Armadyne's military division, normally given to Captains. It has a 3 round burst mode and uses 12mm."
	icon_state = "pdh_alt"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	burst_size = 3
	fire_delay = 1
	spread = 10
	actions_types = list(/datum/action/item_action/toggle_firemode)
	realistic = TRUE
	dirt_modifier = 0.1
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pdh
	name = "pdh handgun magazine (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = "12mm"
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
	name = "\improper Armadyne PDH 'Corporate'"
	desc = "A pristegious ballistics sidearm, from Armadyne's military division, normally given to Armadyne Corporate. It has a 3 round burst mode and uses .357."
	icon_state = "pdh_corpo"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	burst_size = 3
	fire_delay = 1
	spread = 5
	actions_types = list(/datum/action/item_action/toggle_firemode)
	realistic = TRUE
	dirt_modifier = 0.1
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	name = "pdh handgun magazine (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = "12mm"
	max_ammo = 14
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list("lethal" = AMMO_TYPE_LETHAL)


///////////////////////////PDH PEACEKEEPER
/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper
	name = "\improper Armadyne PDH 'Peacekeeper'"
	desc = "A modern ballistics sidearm, used primarily by the military, however this one has had a paintjob to match the peacekeeper theme."
	icon_state = "pdh_peacekeeper"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	realistic = TRUE
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper
	name = "pdh handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 14
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/pdh_peacekeeper/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

///////////////////////LADON 40x32
/obj/item/gun/ballistic/automatic/pistol/ladon
	name = "\improper Armadyne P-3 'Ladon'"
	desc = "A well built all round decent 10mm pistol, it's got a few nice features, feels good in the hand, this is a nice gun! It has an <p style='color:red'>Armadyne</p> embroidery on the grip."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ladon.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "ladon"
	inhand_icon_state = "ladon"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ladon
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	can_flashlight = TRUE
	dirt_modifier = 0.8
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/ladon
	name = "ladon handgun magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/ladon/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/ladon/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/ladon/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_IHDF

/////////////////////MAKAROV
/obj/item/gun/ballistic/automatic/pistol/makarov
	name = "\improper RusCo 'Makarov' Pistol"
	desc = "This gun is really small, it would likely fit in your pocket. It feels russian. It uses 10mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/makarov.dmi'
	icon_state = "makarov"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/makarov
	can_suppress = TRUE
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	dirt_modifier = 0.7
	emp_damageable = TRUE


/obj/item/ammo_box/magazine/multi_sprite/makarov
	name = "makarov handgun magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/makarov/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/makarov/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/makarov/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_IHDF

////////////////////////////MK58

/obj/item/gun/ballistic/automatic/pistol/mk58
	name = "\improper Cyberdyne MK-58 Semi-Auto"
	desc = "This gun feels very military to the touch, makes you feel like you're in the army, or something. It uses 9mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mk58.dmi'
	icon_state = "mk58"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/mk58
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/pistol_fire.ogg'
	rack_sound = 'sound/weapons/gun/pistol/rack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	dirt_modifier = 0.4
	emp_damageable = TRUE

/obj/item/ammo_box/magazine/multi_sprite/mk58
	name = "ladon handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 12
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/mk58/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/mk58/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/mk58/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_IHDF

//////////////////////FIREFLY
/obj/item/gun/ballistic/automatic/pistol/firefly
	name = "\improper Armadyne PMC 'Firefly'"
	desc = "This nifty litle sidarm is from Armadyne's medical directive, brought right into your capable hands. NOT A SURGERY TOOL. Chambered in 9mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/firefly.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "firefly"
	inhand_icon_state = "firefly"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/firefly
	can_suppress = FALSE
	realistic = TRUE
	can_flashlight = FALSE
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/firefly
	name = "firefly handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "10mm"
	max_ammo = 10
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/firefly/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/firefly/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/firefly/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/////////////////////PCR

/obj/item/gun/ballistic/automatic/pcr
	name = "\improper Armadyne AR-3 'Peacekeeper' Cyclic Rifle"
	desc = "A robustly made PCR, it's fairly accurate and has a decent rate of fire. This model is the Automatik-3, meaning 3 round burst. It is chambered in 9mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pcr.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "pcr"
	icon_state = "pcr"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pcr
	fire_delay = 1.5
	can_suppress = FALSE
	burst_size = 3
	spread = 10
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/smg_fire.ogg'
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pcr
	name = "pcr smg magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 25
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/pcr/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pcr/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/pcr/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/obj/item/gun/ballistic/automatic/pitbull
	name = "\improper Armadyne 'Pitbull' Auto Rifle"
	desc = "A sturdy feeling rifle, it's part of Armadyne's military divsion used in peacekeeping. It's chambered in 10mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pitbull.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "pitbull"
	icon_state = "pitbull"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pitbull
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 3
	spread = 15
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sfrifle_fire.ogg'
	emp_damageable = FALSE
	armadyne = TRUE
	can_bayonet = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pitbull
	name = "pitbull smg magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 20
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/pitbull/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/pitbull/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/pitbull/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/////////////////DTR
/obj/item/gun/ballistic/automatic/ostwind
	name = "\improper Armadyne DTR 'Ostwind' Rapid Rifle"
	desc = "The DTR Ostwind is a rapid fire rifle chambered in 6mm, it's decent at crowd control, if your aim is maximum collateral damage."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "pcr"
	icon_state = "ostwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "norwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ostwind
	spread = 25
	fire_delay = 0.7
	can_suppress = FALSE
	burst_size = 4
	actions_types = list(/datum/action/item_action/toggle_firemode)
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	emp_damageable = TRUE
	armadyne = TRUE
	can_bayonet = TRUE

/obj/item/ammo_box/magazine/multi_sprite/ostwind
	name = "ostwind smg magazine (6mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = "6mm"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list("lethal" = AMMO_TYPE_LETHAL, "rubber" = AMMO_TYPE_RUBBER, "ihdf" = AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/ostwind/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/ostwind/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF


/////////////////////CROON 40x32
/obj/item/gun/ballistic/automatic/croon
	name = "\improper DT-4 'Croon' SMG"
	desc = "The DT-4. A bad ripoff of one of Armadyne's sub companies, this thing loves to jam. It's crude but gets the job done. Chambered in 6mm. Not made by Armadyne."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/croon.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	icon_state = "croon"
	inhand_icon_state = "croon"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/croon
	can_suppress = FALSE
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	burst_size = 3
	fire_delay = 2
	spread = 20
	mag_display = FALSE
	mag_display_ammo = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	realistic = TRUE
	dirt_modifier = 1.7
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/croon
	name = "croon smg magazine (6mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = "6mm"
	max_ammo = 15
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list("lethal" = AMMO_TYPE_LETHAL, "rubber" = AMMO_TYPE_RUBBER, "ihdf" = AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/croon/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/croon/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF

///////////////////////////Dozer
/obj/item/gun/ballistic/automatic/dozer
	name = "\improper Armadyne 'Dozer' Semi-Auto"
	desc = "The DZR, it's quite literally only good for dozing people down. It's chambered in 10mm for a reason."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/dozer.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "dozer"
	inhand_icon_state = "dozer"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/dozer
	can_suppress = TRUE
	mag_display = FALSE
	mag_display_ammo = FALSE
	actions_types = null
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/dozer
	name = "dozer smg magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/dozer/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/dozer/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/dozer/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF


/////////////////////NORWIND

/obj/item/gun/ballistic/automatic/norwind
	name = "\improper Armadyne LG-2 'Norwind' Rifle"
	desc = "The Norwind is one of Armadyne's rarer weapons, it's chambered in 12mm but has a low magazine capacity and firerate. Scoped to zoom."
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
	can_suppress = FALSE
	can_bayonet = TRUE
	mag_display = TRUE
	mag_display_ammo = TRUE
	actions_types = null
	realistic = TRUE
	zoomable = TRUE
	zoom_amt = 7
	zoom_out_amt = 5
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/norwind
	name = "norwind rifle magazine (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = "12mm"
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list("lethal" = AMMO_TYPE_LETHAL, "hollowpoint" = AMMO_TYPE_HOLLOWPOINT, "rubber" = AMMO_TYPE_RUBBER)

/obj/item/ammo_box/magazine/multi_sprite/norwind/hp
	ammo_type = /obj/item/ammo_casing/b12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/norwind/rubber
	ammo_type = /obj/item/ammo_casing/b12mm/rubber
	round_type = AMMO_TYPE_RUBBER


/obj/item/gun/ballistic/automatic/vintorez
	name = "\improper Armadyne LSR 'Vintorez'"
	desc = "The LSR Vintorez is a light-weight long-range scoped rifle, it is chambered in 9mm, you won't be dealing much damage, but, at least you won't be in danger. It also has a built in suppressor."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/vintorez.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "vintorez"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	inhand_icon_state = "vintorez"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/vintorez
	can_suppress = FALSE
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = FALSE
	mag_display = FALSE
	mag_display_ammo = FALSE
	realistic = TRUE
	burst_size = 2
	fire_delay = 4
	spread = 10
	zoomable = TRUE
	zoom_amt = 7
	zoom_out_amt = 5
	fire_sound = 'sound/weapons/gun/smg/shot_suppressed.ogg'
	emp_damageable = TRUE
	armadyne = TRUE
/obj/item/ammo_box/magazine/multi_sprite/vintorez
	name = "vintorez rifle magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 15
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/vintorez/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/vintorez/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/vintorez/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF


/////////////////DMR 40x32

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

/////////////////////////////////////////////ZETA
/obj/item/gun/ballistic/revolver/zeta
	name = "\improper Armadyne Zeta-6 'Spurchamber'"
	desc = "A nice looking revolver with spurchamber technology, don't ask what it does. It's 10mm with a 6 round cylinder."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/zeta.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "zeta"
	inhand_icon_state = "zeta"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/zeta
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	armadyne = TRUE

/obj/item/ammo_box/magazine/internal/cylinder/zeta
	name = "revolver cylinder"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = "10mm"
	max_ammo = 8

/obj/item/ammo_box/revolver/multi_sprite/zeta
	name = "zeta speed loader(10mm)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/b10mm
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/revolver/multi_sprite/zeta/hp
	ammo_type = /obj/item/ammo_casing/b10mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/revolver/multi_sprite/zeta/rubber
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/revolver/multi_sprite/zeta/ihdf
	ammo_type = /obj/item/ammo_casing/b10mm/ihdf
	round_type = AMMO_TYPE_IHDF

/////////////////////////////////////////////////////////REVOLUTION
/obj/item/gun/ballistic/revolver/revolution
	name = "\improper Armadyne Revolution-8 'Spurmaster'"
	desc = "A surprisingly premium feeling revolver, even though it uses 9mm, it seems to have a nice weight to it. This handle feels nice too. 8 rounds."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/revolution.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "revolution"
	inhand_icon_state = "revolution"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/revolution
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/revolver_fire.ogg'
	armadyne = TRUE

/obj/item/ammo_box/magazine/internal/cylinder/revolution
	name = "revolver cylinder"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = "9mm"
	max_ammo = 8

/obj/item/ammo_box/revolver/multi_sprite/revolution
	name = "revolution speed loader(9mm)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/revolver/multi_sprite/revolution/hp
	ammo_type = /obj/item/ammo_casing/b9mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/revolver/multi_sprite/revolution/rubber
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/revolver/multi_sprite/revolution/ihdf
	ammo_type = /obj/item/ammo_casing/b9mm/ihdf
	round_type = AMMO_TYPE_IHDF

/////////////////SMARTGUN 40x32
/obj/item/gun/ballistic/automatic/smartgun
	name = "\improper Armadyne 'S-M-A-R-T-GUN'"
	desc = "The SMARTGUN is one of Armadyne finest creations in regards to law enforcement and shredding things. Some say they use thses to shred paper."
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
	actions_types = null
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
	var/recharge_time = 5 SECONDS
	var/recharging = FALSE
	armadyne = TRUE

/obj/item/gun/ballistic/automatic/smartgun/process_chamber()
	. = ..()
	recharging = TRUE
	addtimer(CALLBACK(src, .proc/recharge), recharge_time)

/obj/item/gun/ballistic/automatic/smartgun/proc/recharge()
	recharging = FALSE
	playsound(src, 'sound/weapons/kenetic_reload.ogg', 60, 1)

/obj/item/gun/ballistic/automatic/smartgun/can_shoot()
	. = ..()
	if(recharging)
		return FALSE

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
