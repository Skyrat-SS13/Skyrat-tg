GLOBAL_LIST_EMPTY(hell) //eorg banned players go here

/mob/living/Login()
	. = ..()
	if(ckey)
		if(is_banned_from(ckey, BAN_PACIFICATION))
			ADD_TRAIT(src, TRAIT_PACIFISM, ROUNDSTART_TRAIT)

/mob/dead/observer/Login()
	. = ..()
	if(ckey)
		if(is_banned_from(ckey, BAN_DONOTREVIVE))
			to_chat(src, "<span class='notice'>As you are revival banned, you cannot reenter your body.")
			can_reenter_corpse = FALSE

/datum/outfit/chicken
	name = "Chicken"
	suit = /obj/item/clothing/suit/chickensuit
	head = /obj/item/clothing/head/chicken

/obj/effect/landmark/hell
	name = "Hell"
	icon_state = "portal_exit"

/obj/effect/landmark/hell/Initialize(mapload)
	..()
	GLOB.hell += loc
	return INITIALIZE_HINT_QDEL

