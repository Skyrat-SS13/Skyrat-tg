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
			to_chat(src, span_notice("As you are revival banned, you cannot reenter your body."))
			can_reenter_corpse = FALSE

/proc/process_eorg_bans()
	for(var/mob/iterating_player in GLOB.mob_list)
		if(iterating_player.ckey && is_banned_from(iterating_player.ckey, BAN_EORG))
			var/turf/picked_turf = pick(GLOB.hell)
			new /obj/effect/particle_effect/sparks/quantum (iterating_player.loc)
			if(ishuman(iterating_player))
				var/mob/living/carbon/human/our_human = iterating_player
				our_human.equipOutfit(/datum/outfit/chicken)
			iterating_player.visible_message(span_notice("[iterating_player] is teleported back home, hopefully to an everloving family!"), span_userdanger("As you are EORG banned, you will now be sent to hell."))
			iterating_player.forceMove(picked_turf)

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

