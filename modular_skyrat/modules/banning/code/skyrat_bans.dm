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
			iterating_player.visible_message(span_notice("[iterating_player] is teleported back home, hopefully to an everloving family!"), span_userdanger("As you are EORG banned, you will now be sent to hell."))
			qdel(iterating_player)

