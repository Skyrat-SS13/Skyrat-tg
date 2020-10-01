/obj/item/gun/ballistic
	var/alt_icons = FALSE //Does this gun have mag and nomag on mob variance?
	var/realistic = FALSE //realistic guns that use reliability and dirt
	var/reliability = 0 //How reliable a gun is, set this to change starting reliablity. Lower is better.
	var/jammed = FALSE //Is it jammed?
	var/dirt_level = 0 //how dirty a gun is
	var/dirt_modifier = 1 //Tied in with how good a gun is, if firing it causes a lot of dirt to form, then change this accordingly.
	var/jam_chance = 0 //Used when calculating if a gun will jam or not.

/obj/item/gun/ballistic/update_overlays()
	if(alt_icons)
		if(!magazine)
			inhand_icon_state = "[initial(icon_state)]_nomag"
			worn_icon_state = "[initial(icon_state)]_nomag"
		else
			inhand_icon_state = "[initial(icon_state)]"
			worn_icon_state = "[initial(icon_state)]"
	. = ..()

/obj/item/gun/ballistic/ComponentInitialize()
	if(alt_icons)
		AddElement(/datum/element/update_icon_updates_onmob)
	. = ..()

/obj/item/gun/ballistic/shoot_live_shot(mob/living/user, pointblank, atom/pbtarget, message)
	if(realistic)
		dirt_level += 0.5*dirt_modifier

		if(jammed)
			return

		jam_chance = dirt_level/5+reliability/2

		if(reliability >= 10)
			if(prob(jam_chance))
				jammed = TRUE
				playsound(src, 'sound/effects/stall.ogg', 60, TRUE)
				to_chat(user, "<span class='danger'>The [src] jams!</span>")
		else if(dirt_level > 10)
			if(prob(jam_chance))
				jammed = TRUE
				playsound(src, 'sound/effects/stall.ogg', 60, TRUE)
				to_chat(user, "<span class='danger'>The [src] jams!</span>")
	. = ..()

/obj/item/gun/ballistic/automatic/ppsh/can_shoot()
	if(realistic)
		if(jammed)
			return
		else
			. = ..()
	else
		. = ..()

/obj/item/gun/ballistic/AltClick(mob/user)
	. = ..()
	if(realistic)
		if(!user.canUseTopic(src))
			return
		if(jammed)
			jammed = FALSE
			to_chat(user, "<span class='notice'>You unjam the [src]'s bolt.</span>")
			playsound(src, 'sound/weapons/gun/l6/l6_rack.ogg', 60, TRUE)

/obj/item/gun/ballistic/afterattack(atom/target as mob|obj|turf, mob/living/user as mob|obj, flag, params)
	if(realistic)
		if(jammed)
			to_chat(user, "<span class='warning'>[src]'s is jammed, unjam it before firing!</span>")
			return
		else
			. = ..()
			update_icon()
	else
		. = ..()

/obj/item/gun/ballistic/examine(mob/user)
	. = ..()
	if(realistic)
		switch(dirt_level)
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

		if(jammed)
			. += "<b>It is jammed, alt+click it to unjam it!</b>"
		else
			. += "It is functioning normally."

/obj/item/gun/ballistic/attackby(obj/item/A, mob/user, params)
	. = ..()
	if(realistic)
		if(istype(A, /obj/item/soap))
			var/obj/item/soap/S = A
			to_chat(user, "<span class='notice'>You start cleaning the [src].</span>")
			if(do_after(user, S.cleanspeed))
				dirt_level -= S.cleanspeed
				if(dirt_level < 0)
					dirt_level = 0
				to_chat(user, "<span class='notice'>You clean the [src], improving it's reliability!")


//NEW CARTRAGES

//7.92mm german
/obj/item/ammo_casing/a792
	name = "7.92 bullet casing"
	desc = "A 7.92 bullet casing."
	icon_state = "762-casing"
	caliber = "a762"
	projectile_type = /obj/projectile/bullet/a792

/obj/projectile/bullet/a792
	name = "7.92 bullet"
	damage = 60
	armour_penetration = 5
	wound_bonus = -50
	wound_falloff_tile = 0

//CRATES

//all that shit
/obj/structure/closet/crate/secure/weapon/ww2
	desc = "A secure weapons crate. Looks like it's from the old-era world war 2."
	name = "ww2 weapons crate"
	icon_state = "weaponcrate"

/obj/structure/closet/crate/secure/weapon/ww2/PopulateContents()
	new /obj/item/gun/ballistic/automatic/fg42
	new /obj/item/ammo_box/magazine/fg42
	new /obj/item/gun/ballistic/automatic/akm
	new /obj/item/ammo_box/magazine/akm
	new /obj/item/gun/ballistic/automatic/m4
	new /obj/item/ammo_box/magazine/m45
	new /obj/item/gun/ballistic/automatic/l6_saw/unrestricted/mg34
	new /obj/item/ammo_box/magazine/mg34
	new /obj/item/gun/ballistic/automatic/mp40
	new /obj/item/ammo_box/magazine/mp40
	new /obj/item/gun/ballistic/automatic/stg
	new /obj/item/ammo_box/magazine/stg
	new /obj/item/gun/ballistic/automatic/ppsh
	new /obj/item/ammo_box/magazine/ppsh
	..()
