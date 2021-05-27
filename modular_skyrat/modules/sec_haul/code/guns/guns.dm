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
	caliber = CALIBER_9MM
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
	name = "\improper Armadyne Glock-18"
	desc = "A special anniversary edition of the Glock-18 from Armadyne, it has a 3 round burst mode and accepts extended magazines."
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
	realistic = TRUE
	mag_display = FALSE
	mag_display_ammo = FALSE
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/g18
	name = "g18 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g18"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MM
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
	name = "\improper Armadyne PDH-6H 'Osprey'"
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
	emp_damageable = TRUE

/obj/item/gun/ballistic/automatic/pistol/pdh/alt
	name = "\improper Armadyne PDH-6C 'SOCOM'"
	desc = "A prestigious 12mm sidearm normally seen in the hands of Sol special operation units due to its reliable and time-tested design. Now's one of those times that pays to be the strong, silent type."
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
	can_flashlight = TRUE
	emp_damageable = FALSE

/obj/item/ammo_box/magazine/multi_sprite/pdh
	name = "pdh handgun magazine (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
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
	name = "\improper Armadyne PDH-6M 'Corporate'"
	desc = "A prestigious ballistic sidearm, from Armadyne's military division, normally given to corporate agents. It has a 3 round burst mode and uses .357 Magnum ammunition."
	icon_state = "pdh_corpo"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	can_suppress = FALSE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/hpistol_fire.ogg'
	burst_size = 3
	fire_delay = 1
	spread = 5
	realistic = TRUE
	dirt_modifier = 0.1
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pdh_corpo
	name = "pdh handgun magazine (357)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/a357
	caliber = "357"
	max_ammo = 14
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list("lethal" = AMMO_TYPE_LETHAL)


///////////////////////////PDH PEACEKEEPER
/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper
	name = "\improper Armadyne PDH-6B 'Peacekeeper'"
	desc = "A modern ballistic sidearm, used primarily by law enforcement, however this one has had a paintjob to match the peacekeeper theme."
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
	caliber = CALIBER_9MM
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
	desc = "A modern ballistic sidearm based off the PDH models, chambered in 10mm and quite recent on the market. It has an <p style='color:red'>Armadyne</p> embroidery on the grip."
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
	caliber = CALIBER_10MM
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
	desc = "A mediocre pocket-sized handgun of seemingly Russian origin, chambered in 10mm."
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
	caliber = CALIBER_10MM
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
	name = "\improper Cyberdyne MK-58"
	desc = "A modern 9mm handgun with an olive polymer lower frame. Looks like a generic 21st century military sidearm."
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
	name = "mk-58 handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MM
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
	name = "\improper Armadyne P-92 'Firefly'"
	desc = "A 9mm sidearm made by Armadyne's Medical Directive, with a heavy front for weak wrists. A small warning label on the back says it's not fit for surgical work."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/firefly.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "firefly"
	inhand_icon_state = "firefly"
	w_class = WEIGHT_CLASS_NORMAL
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/firefly
	can_suppress = FALSE
	realistic = TRUE
	can_flashlight = TRUE
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/firefly
	name = "firefly handgun magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pdh"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MM
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
	name = "\improper Armadyne PCR-9 'Mitrailleuse'"
	desc = "A standard PCR, accurate and fast-firing. It fires three-round bursts of 9mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pcr.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	inhand_icon_state = "pcr"
	icon_state = "pcr"
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pcr
	fire_delay = 1.5
	can_suppress = FALSE
	burst_size = 3
	spread = 10
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/smg_fire.ogg'
	emp_damageable = TRUE
	armadyne = TRUE
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pcr
	name = "pcr smg magazine (9mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b9mm
	caliber = CALIBER_9MM
	max_ammo = 30
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
	name = "\improper Armadyne 'Pitbull' Battle Rifle"
	desc = "A sturdy battle rifle normally issued to Armadyne's military division. Rechambered for peacekeeping work, it fires three-round bursts of 10mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pitbull.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "pitbull"
	icon_state = "pitbull"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/pitbull
	fire_delay = 2
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 3
	spread = 15
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sfrifle_fire.ogg'
	emp_damageable = FALSE
	armadyne = TRUE
	can_bayonet = TRUE
	can_flashlight = TRUE

/obj/item/ammo_box/magazine/multi_sprite/pitbull
	name = "pitbull br magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = CALIBER_10MM
	max_ammo = 25
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
	name = "\improper Armadyne DTR-6 'Ostwind' Rifle"
	desc = "The DTR-6 is a fast-firing infantry rifle chambered in 6mm, for a more collateral approach to crowd control."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	inhand_icon_state = "pcr"
	icon_state = "ostwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/ostwind.dmi'
	worn_icon_state = "ostwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/ostwind
	spread = 25
	fire_delay = 0.7
	can_suppress = FALSE
	burst_size = 4
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'sound/weapons/gun/smg/shot.ogg'
	emp_damageable = TRUE
	armadyne = TRUE
	can_bayonet = TRUE

/obj/item/ammo_box/magazine/multi_sprite/ostwind
	name = "ostwind rifle magazine (6mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "pcr"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = CALIBER_6MM
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/ostwind/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/ostwind/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF


/////////////////////CROON 40x32
/obj/item/gun/ballistic/automatic/croon
	name = "\improper DT-4 'Croon' SMG"
	desc = "A low-quality 6mm reproduction of one of Armadyne's popular SMG models, jams like a bitch. Although crude and unofficial, it gets the job done."
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
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC, SELECT_BURST_SHOT)
	realistic = TRUE
	dirt_modifier = 1.7
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/croon
	name = "croon smg magazine (6mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/b6mm
	caliber = CALIBER_6MM
	max_ammo = 15
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_RUBBER, AMMO_TYPE_IHDF)

/obj/item/ammo_box/magazine/multi_sprite/croon/rubber
	ammo_type = /obj/item/ammo_casing/b6mm/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/croon/ihdf
	ammo_type = /obj/item/ammo_casing/b6mm/ihdf
	round_type = AMMO_TYPE_IHDF

///////////////////////////Dozer
/obj/item/gun/ballistic/automatic/dozer
	name = "\improper Armadyne DZR-10 'Dozer'"
	desc = "The DZR-10, a notorious 10mm PDW that lives up to its nickname. For safety concerns, this peacekeeping model has been locked to semi-automatic."
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
	burst_size = 1
	fire_delay = 0
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	fire_sound = 'sound/weapons/gun/rifle/shot.ogg'
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/slide_drop.ogg'
	realistic = TRUE
	emp_damageable = TRUE
	armadyne = TRUE

/obj/item/ammo_box/magazine/multi_sprite/dozer
	name = "dozer pdw magazine (10mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "croon"
	ammo_type = /obj/item/ammo_casing/b10mm
	caliber = CALIBER_10MM
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
	name = "\improper Armadyne M112 'Norwind' Designated Marksman Rifle"
	desc = "A rare M112 DMR rechambered to 12mm for peacekeeping work, it comes with a scope for medium-long range engagements. Comes with a bayonet lug if you want to make it personal."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	icon_state = "norwind"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	inhand_icon_state = "norwind"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	alt_icons = TRUE
	alt_icon_state = "norwind_worn"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/norwind
	can_suppress = FALSE
	can_bayonet = TRUE
	mag_display = TRUE
	can_flashlight = TRUE
	mag_display_ammo = TRUE
	actions_types = null
	realistic = TRUE
	zoomable = TRUE
	zoom_amt = 7
	zoom_out_amt = 5
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'
	emp_damageable = TRUE
	armadyne = TRUE
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	burst_size = 1
	fire_delay = 5

/obj/item/ammo_box/magazine/multi_sprite/norwind
	name = "norwind dmr magazine (12mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "norwind"
	ammo_type = /obj/item/ammo_casing/b12mm
	caliber = CALIBER_12MM
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	possible_types = list(AMMO_TYPE_LETHAL, AMMO_TYPE_HOLLOWPOINT, AMMO_TYPE_RUBBER)

/obj/item/ammo_box/magazine/multi_sprite/norwind/hp
	ammo_type = /obj/item/ammo_casing/b12mm/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/norwind/rubber
	ammo_type = /obj/item/ammo_casing/b12mm/rubber
	round_type = AMMO_TYPE_RUBBER


/obj/item/gun/ballistic/automatic/vintorez
	name = "\improper Armadyne VKC 'Vintorez'"
	desc = "The VKC Vintorez is a lightweight integrally-suppressed scoped carbine usually employed in stealth operations. It was rechambered to 9mm for peacekeeping work."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/vintorez.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "vintorez"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/norwind.dmi'
	worn_icon_state = "norwind_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	inhand_icon_state = "vintorez"
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/vintorez
	can_suppress = FALSE
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
	caliber = CALIBER_9MM
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
	name = "\improper Armadyne DMR 'Ripper' Gen-2"
	desc = "An incredibly powerful autorifle, with an internal stabalisation gymbal. It's chambered in .577 Snider."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/dmr.dmi'
	icon_state = "dmr"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/dmr.dmi'
	worn_icon_state = "dmr_worn"
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand40x32.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand40x32.dmi'
	inhand_icon_state = "dmr"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	mag_type = /obj/item/ammo_box/magazine/dmr
	fire_delay = 1.7
	can_suppress = FALSE
	burst_size = 3
	can_bayonet = FALSE
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound_volume = 60
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/sniper_fire.ogg'

/obj/item/ammo_box/magazine/dmr
	name = "dmr magazine (.557 Snider)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "dmr"
	ammo_type = /obj/item/ammo_casing/b577
	caliber = ".557 Snider"
	max_ammo = 25
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

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
	ammo_type = /obj/item/ammo_casing/b10mm/rubber
	caliber = CALIBER_10MM
	max_ammo = 6

/obj/item/ammo_box/revolver/zeta
	name = "zeta speed loader(10mm)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/b10mm
	max_ammo = 6
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	caliber = CALIBER_10MM
	start_empty = TRUE

/////////////////////////////////////////////////////////REVOLUTION
/obj/item/gun/ballistic/revolver/revolution
	name = "\improper Armadyne Revolution-8 'Spurmaster'"
	desc = "An upgraded version of the Zeta-6, this has the superior spurmaster technology inbuilt, and is chambered in 9mm with an 8 round cylinder."
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
	ammo_type = /obj/item/ammo_casing/b9mm/rubber
	caliber = CALIBER_9MM
	max_ammo = 8

/obj/item/ammo_box/revolver/revolution
	name = "revolution speed loader(9mm)"
	desc = "Designed to quickly reload revolvers."
	icon_state = "speedloader"
	ammo_type = /obj/item/ammo_casing/b9mm
	max_ammo = 8
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC
	caliber = CALIBER_9MM
	start_empty = TRUE

/////////////////SMARTGUN 40x32
/obj/item/gun/ballistic/automatic/smartgun
	name = "\improper Armadyne 'S.M.A.R.T.' Rifle"
	desc = "Suppressive Manual Action Reciprocating Taser rifle. A modified version of an Armadyne heavy machine gun fitted to fire miniature shock-bolts."
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

//////////////////////////////////////////////////////////
/////////////////KRAUT SPACE MAGIC G11////////////////////
//////////////////////////////////////////////////////////

/obj/item/gun/ballistic/automatic/g11
	name = "\improper Armadyne G11 K2"
	desc = "A futuristic battle rifle made with the finest German polymer and engineering. This gun is cheap to produce yet so very technologically advanced. It's chambered in 4.73×33mm caseless ammunition."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/g11.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/righthand.dmi'
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/guns/inhands/lefthand.dmi'
	icon_state = "g11"
	inhand_icon_state = "g11"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/guns/g11.dmi'
	worn_icon_state = "g11_worn"
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK | ITEM_SLOT_BELT | ITEM_SLOT_OCLOTHING
	mag_type = /obj/item/ammo_box/magazine/multi_sprite/g11
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 0.5
	spread = 10
	mag_display = TRUE
	mag_display_ammo = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/sec_haul/sound/ltrifle_fire.ogg'
	emp_damageable = FALSE
	armadyne = TRUE
	can_bayonet = TRUE
	can_flashlight = TRUE
	dirt_modifier = 0.1

/obj/item/ammo_box/magazine/multi_sprite/g11
	name = "g11 toploader magazine (4.73×33mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/mags.dmi'
	icon_state = "g11"
	ammo_type = /obj/item/ammo_casing/caseless/b473
	caliber = CALIBER_473MM
	max_ammo = 50
	multiple_sprites = AMMO_BOX_FULL_EMPTY_BASIC

/obj/item/ammo_box/magazine/multi_sprite/g11/hp
	ammo_type = /obj/item/ammo_casing/caseless/b473/hp
	round_type = AMMO_TYPE_HOLLOWPOINT

/obj/item/ammo_box/magazine/multi_sprite/g11/rubber
	ammo_type = /obj/item/ammo_casing/caseless/b473/rubber
	round_type = AMMO_TYPE_RUBBER

/obj/item/ammo_box/magazine/multi_sprite/g11/ihdf
	ammo_type = /obj/item/ammo_casing/caseless/b473/ihdf
	round_type = AMMO_TYPE_IHDF
