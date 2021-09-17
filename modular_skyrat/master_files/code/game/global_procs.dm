/proc/skyrat_postround_handle()
	process_anti_eorg_teleports()
	process_eorg_bans()

/proc/process_anti_eorg_teleports() // Teleport players with prefs from murderbone zone to ghost cafe
	if(CONFIG_GET(flag/disable_eorg_teleport))
		return FALSE
	if(!GLOB.anti_eorg_teleports)
		return FALSE

	var/list/random_safe_locations = GLOB.anti_eorg_teleports
	var/turf/basic_safe_location = pick(GLOB.anti_eorg_teleports)

	for(var/player in GLOB.player_list)
		var/mob/snowman = player
		if(ishuman(snowman))
			var/mob/living/carbon/human/H = snowman
			if(H.handcuffed) //it would be a shame to "have fun" in handcuffs
				qdel(H.handcuffed)
		if(snowman.mind?.special_role || length(snowman.mind.antag_datums) > 0)
			continue //no, no, lad - you ain't going anywhere :^)
		if(snowman.client?.prefs?.anti_eorg_teleport)
			var/my_safe_location = pick(random_safe_locations)
			if(!my_safe_location)
				my_safe_location = basic_safe_location
			snowman.forceMove(my_safe_location)
			random_safe_locations -= my_safe_location
			ADD_TRAIT(snowman, TRAIT_PACIFISM, ROUNDSTART_TRAIT) //make admins work easier
			to_chat(snowman, "<span class='infoplain'><BR><BR><BR><span class='big bold'>Do not make harm. Love one another.</span></span>")

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
