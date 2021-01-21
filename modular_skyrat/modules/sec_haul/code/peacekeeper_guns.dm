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
	name = "g17 handgun magazine (9x19mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "g17"
	ammo_type = /obj/item/ammo_casing/c9x19mm
	caliber = "9x19mm"
	max_ammo = 17
	multiple_sprites = AMMO_BOX_FULL_EMPTY

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
	name = "g18 handgun magazine (9x19mm)"
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/glock.dmi'
	icon_state = "g18"
	ammo_type = /obj/item/ammo_casing/c9x19mm
	caliber = "9x19mm"
	max_ammo = 33
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/pcr
	name = "A-3 Peacekeeper Cyclic Rifle"
	desc = "A cheaply made PCR, it's fairly accurate and has a decent rate of fire. This model is the Automatik-3, meaning 3 round burst. It is chambered in 4.6x30mm."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/pcr.dmi'
	icon_state = "pcr"
	w_class = WEIGHT_CLASS_BULKY
	inhand_icon_state = "arg"
	mag_type = /obj/item/ammo_box/magazine/wt550m9
	fire_delay = 1
	can_suppress = FALSE
	burst_size = 3
	actions_types = list(/datum/action/item_action/toggle_firemode)
	can_bayonet = TRUE
	knife_x_offset = 25
	knife_y_offset = 12
	mag_display = TRUE
	mag_display_ammo = TRUE
	empty_indicator = TRUE
	realistic = TRUE
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/pps/pps.ogg'

/obj/item/gun/energy/e_gun/Initialize(mapload)
	. = ..()
	new /obj/item/gun/ballistic/automatic/pcr(src.loc) //JANKY
	qdel(src)
