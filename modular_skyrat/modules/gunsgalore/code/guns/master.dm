/obj/item/gun/ballistic
	var/alt_icons = FALSE //Does this gun have mag and nomag on mob variance?
	var/realistic = FALSE //realistic guns that use reliability and dirt
	var/jammed = FALSE //Is it jammed?
	var/dirt_level = 0 //how dirty a gun is.
	var/dirt_modifier = 0.5 //Tied in with how good a gun is, if firing it causes a lot of dirt to form, then change this accordingly.
	var/jam_chance = 0 //Used when calculating if a gun will jam or not.
	var/unjam_time = 0 //Used when calculating how long a gun takes to unjam.
	var/base_spread = 0
	var/durability = 100 //How used this gun is.
	var/durability_factor = 0.1 //How quickly a gun will degrade. 0.1 = 1000 shots. Edit this to change a guns base reliability.

/obj/item/gun/ballistic/Initialize()
	. = ..()
	if(realistic)
		base_spread = spread

/obj/item/gun/ballistic/update_overlays()
	if(alt_icons)
		if(!magazine)
			inhand_icon_state = "[initial(icon_state)]_nomag"
			worn_icon_state = "[initial(icon_state)]_nomag"
		else
			inhand_icon_state = "[initial(icon_state)]"
			worn_icon_state = "[initial(icon_state)]"
	. = ..()

//gun pickup message
/obj/item/gun/pickup(mob/user)
	. = ..()
	if(w_class > WEIGHT_CLASS_SMALL && !suppressed)
		user.visible_message("<span class='warning'>[user] grabs <b>[src]</b>!</span>",
		"<span class='warning'>You grab [src]!</span>")

/obj/item/gun/ballistic/assault_rifle
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_magout.ogg'
	eject_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_magout.ogg'

/obj/item/gun/ballistic/battle_rifle
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/batrifle_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/batrifle_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/batrifle_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/batrifle_magout.ogg'
	eject_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/batrifle_magout.ogg'

/obj/item/gun/ballistic/machine_gun
	rack_sound = 'sound/weapons/gun/l6/l6_rack.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/lmg_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/lmg_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/lmg_magout.ogg'
	eject_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/lmg_magout.ogg'

/obj/item/gun/ballistic/sniper_rifle
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magout.ogg'
	eject_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/sfrifle_magout.ogg'

/obj/item/gun/ballistic/submachine_gun
	rack_sound = 'sound/weapons/gun/smg/smgrack.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/smg_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/smg_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/smg_magout.ogg'
	eject_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/smg_magout.ogg'

/obj/item/gun/ballistic/ComponentInitialize()
	if(alt_icons)
		AddElement(/datum/element/update_icon_updates_onmob)
	. = ..()

/obj/item/gun/ballistic/proc/jam(unjam = FALSE, mob/living/user)
	if(unjam && jammed != TRUE)
		unjam_time = clamp((jam_chance*10)/(durability/10), 0, 50)
		jammed = TRUE
		playsound(src, 'sound/effects/stall.ogg', 60, TRUE)
		to_chat(user, "<span class='danger'>The [src] jams!</span>")
	else if(jammed)
		to_chat(user, "You start to unjam the bolt!")
		if(do_after(user, unjam_time))
			jammed = FALSE
			to_chat(user, "<span class='notice'>You unjam the [src]'s bolt.</span>")
			playsound(src, 'sound/weapons/gun/l6/l6_rack.ogg', 60, TRUE)

/obj/item/gun/ballistic/can_shoot()
	if(realistic)
		if(jammed)
			return FALSE
		else
			. = ..()
	else
		. = ..()

/obj/item/gun/ballistic/process_burst(mob/living/user, atom/target, message, params, zone_override, sprd, randomized_gun_spread, randomized_bonus_spread, rand_spr, iteration)
	if(realistic)
		if(jammed)
			firing_burst = FALSE
			return FALSE
		else
			. = ..()
	else
		. = ..()

/obj/item/gun/ballistic/process_fire()
	if(realistic)
		if(jammed)
			shoot_with_empty_chamber()
			return
	. = ..()

/obj/item/gun/ballistic/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	if(realistic)
		if(jammed)
			return FALSE

		dirt_level += dirt_modifier

		durability = clamp(durability -= durability_factor, 1, 1000)

		jam_chance = dirt_level/5

		spread = base_spread + ((jam_chance / durability)*100)

		switch(FLOOR(durability, 1))
			if(0 to 9)
				if(prob(90))
					jam(user)
					return FALSE
			if(10 to 29)
				if(prob(10))
					jam(user)
					return FALSE
			if(30 to 49)
				if(prob(5))
					jam(user)
					return FALSE

		if(dirt_level > 30 && prob(jam_chance))
			jam(user)
			return FALSE
	. = ..()

/obj/item/gun/ballistic/AltClick(mob/user)
	if(realistic)
		if(!user.canUseTopic(src))
			return
		if(jammed)
			jam(TRUE, user)
			return
	. = ..()

/obj/item/gun/ballistic/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(realistic)
		if(jammed)
			to_chat(user, "<span class='warning'>[src] is jammed, unjam it before firing!</span>")
			return
		else
			. = ..()
			update_icon()
	else
		. = ..()

/obj/item/gun/ballistic/examine(mob/user)
	. = ..()
	if(realistic)
		switch(FLOOR(dirt_level, 1))
			if(0 to 10)
				. += "It looks clean."
			if(11 to 30)
				. += "It looks slightly dirty."
			if(31 to 50)
				. += "It looks dirty."
			if(51 to 70)
				. += "It looks very dirty."
			else
				. += "<span class='warning'>It is filthy!</span>"

		switch(FLOOR(durability, 1))
			if(0 to 9)
				. += "<span class='warning'><b>It is falling apart!</b></span>"
			if(10 to 29)
				. += "<span class='warning'>It looks battle scarred!</span>"
			if(30 to 49)
				. += "It looks well worn."
			if(50 to 69)
				. += "It has minimal wear."
			else
				. += "It looks factory new."

		if(jammed)
			. += "<span class='warning'><b>It is jammed, alt+click it to unjam it!</b></span>"
		else if(durability < 10)
			. += "<span class='warning'><b>It is barely functioning!</b></span>"
		else
			. += "It is functioning normally."

/obj/item/gun/ballistic/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(realistic)
		if(istype(A, /obj/item/soap))
			var/obj/item/soap/S = A
			to_chat(user, "<span class='notice'>You start cleaning the [src].</span>")
			if(do_after(user, (1000/S.cleanspeed) SECONDS))
				dirt_level -= S.cleanspeed
				if(dirt_level < 0)
					dirt_level = 0
				to_chat(user, "<span class='notice'>You clean the [src], improving it's reliability!</span>")


//CRATES

//all that shit
/obj/structure/closet/crate/secure/weapon/ww2
	desc = "A secure weapons crate. Looks like it's from the old-era world war 2."
	name = "ww2 weapons crate"
	icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/weapon/ww2/PopulateContents()
	. = ..()
	new /obj/item/gun/ballistic/automatic/battle_rifle/fg42(src)
	new /obj/item/ammo_box/magazine/fg42(src)
	new /obj/item/gun/ballistic/automatic/assault_rifle/akm(src)
	new /obj/item/ammo_box/magazine/akm(src)
	new /obj/item/gun/ballistic/automatic/assault_rifle/m16(src)
	new /obj/item/ammo_box/magazine/m16(src)
	new /obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34(src)
	new /obj/item/ammo_box/magazine/mg34(src)
	new /obj/item/gun/ballistic/automatic/submachine_gun/mp40(src)
	new /obj/item/ammo_box/magazine/mp40(src)
	new /obj/item/gun/ballistic/automatic/assault_rifle/stg(src)
	new /obj/item/ammo_box/magazine/stg(src)
	new /obj/item/gun/ballistic/automatic/submachine_gun/ppsh(src)
	new /obj/item/ammo_box/magazine/ppsh(src)
	new /obj/item/gun/ballistic/automatic/submachine_gun/pps(src)
	new /obj/item/ammo_box/magazine/pps(src)

/obj/effect/temp_visual/dir_setting/firing_effect
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_FIRE
