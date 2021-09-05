/obj/item/strange_rock
	name = "strange rock"
	desc = "It seems like there's something inside, encased with fringe layers of rock that seem like they'd peel away at your touch."
	icon = 'icons/excavation/strange_rock.dmi'
	icon_state = "strange"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/strange_rock/Initialize()
	. = ..()
	icon_state = "strange[rand(0,3)]"

/obj/item/strange_rock/attack_self(mob/user)
	. = ..()
	if(.)
		return
	to_chat(user, "<span class='notice'>You carefully crack open [src].</span>")
	playsound(src, 'sound/effects/break_stone.ogg', 30, TRUE)
	for(var/obj/item/I in contents)
		if(!user.put_in_hand(I))
			I.forceMove(get_turf(src))
	qdel(src)

/obj/item/fossil
	name = "fossil"
	icon = 'icons/excavation/fossils.dmi'
	icon_state = "rock_fauna_2"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/fossil/Initialize()
	. = ..()
	var/amber = prob(50) ? TRUE : FALSE
	var/flora = prob(50) ? TRUE : FALSE
	icon_state = "[amber ? "amber" : "rock"]_[flora ? "flora" : "fauna"]_[rand(1,7)]"
	desc = "You see a fossil of some sort of a [flora ? "plant" : "creature"], it is encased in [amber ? "amber" : "rock"]"
	name = "[amber?"amber":"rock"] fossil"

/obj/item/excavation_junk
	name = "ancient artifact"
	icon = 'icons/excavation/excavation_junk.dmi'
	icon_state = "bowl"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/excavation_junk/Initialize()
	. = ..()
	var/random = rand(1,4)
	switch(random)
		if(1)
			name = "ancient bowl"
			desc = "An ancient looking bowl, used for obvious reasons."
			icon_state = "bowl"
		if(2)
			name = "ancient urn"
			desc = "An ancient urn, did aliens cremate their own?"
			icon_state = "urn"
		if(3)
			name = "ancient statuette"
			desc = "An ancient statuette, you're not quite sure what it's depicting."
			icon_state = "statuette"
		if(4)
			name = "ancient instrument"
			desc = "An ancient instrument, you can't wrap your head around on how to even begin to play that."
			icon_state = "instrument"

/obj/item/unknown_artifact
	name = "unknown artifact"
	desc = "An intricate artifact, from a glance you can tell that this is way more advanced than pottery."
	icon = 'icons/excavation/excavation_unknown.dmi'
	icon_state = "unknown1"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/unknown_artifact/Initialize()
	. = ..()
	icon_state = "unknown[rand(1,4)]"
