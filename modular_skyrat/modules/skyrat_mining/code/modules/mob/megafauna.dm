/mob/living/simple_animal/hostile/megafauna
	var/glorykill = FALSE //CAN THIS MOTHERFUCKER BE SNAPPED IN HALF FOR HEALTH?
	var/list/glorymessageshand = list() //WHAT THE FUCK ARE THE MESSAGES SAID BY THIS FUCK WHEN HE'S GLORY KILLED WITH AN EMPTY HAND?
	var/list/glorymessagescrusher = list() //SAME AS ABOVE BUT CRUSHER
	var/list/glorymessagespka = list() //SAME AS ABOVE THE ABOVE BUT PKA
	var/list/glorymessagespkabayonet = list() //SAME AS ABOVE BUT WITH A HONKING KNIFE ON THE FUCKING THING
	var/gloryhealth = 200
	var/glorythreshold = 100
	var/list/songs = list()
	var/sound/chosensong
	var/chosenlength
	var/chosenlengthstring
	var/songend
	var/retaliated = FALSE
	var/retaliatedcooldowntime = 6000
	var/retaliatedcooldown

/mob/living/simple_animal/hostile/megafauna/SetRecoveryTime(buffer_time, ranged_buffer_time)
	recovery_time = world.time + buffer_time
	ranged_cooldown = world.time + buffer_time
	if(ranged_buffer_time)
		ranged_cooldown = world.time + ranged_buffer_time

/mob/living/simple_animal/hostile/megafauna
	var/list/enemies = list()

/mob/living/simple_animal/hostile/megafauna/Found(atom/A)
	if(isliving(A))
		var/mob/living/L = A
		if(!L.stat)
			return L
		else
			enemies -= L
	else if(ismecha(A))
		var/obj/vehicle/sealed/mecha/M = A
		if(length(M.occupants))
			return A

/mob/living/simple_animal/hostile/megafauna/ListTargets()
	if(!enemies.len)
		return list()
	var/list/see = ..()
	see &= enemies // Remove all entries that aren't in enemies
	return see

/mob/living/simple_animal/hostile/megafauna/proc/Retaliate()
	var/list/around = view(src, vision_range)
	for(var/atom/movable/A in around)
		if(A == src)
			continue
		if(isliving(A))
			var/mob/living/M = A
			if(faction_check_mob(M) && attack_same || !faction_check_mob(M) && M.client)
				enemies |= M
				chosenlengthstring = pick(songs)
				chosenlength = text2num(chosenlengthstring)
				chosensong = songs[chosenlengthstring]
				if(chosensong && !songend)
					if(M?.client?.prefs?.toggles & SOUND_AMBIENCE)
						M.stop_sound_channel(CHANNEL_JUKEBOX)
						songend = chosenlength + world.time
						SEND_SOUND(M, chosensong) // so silence ambience will mute moosic for people who don't want that, or it just doesn't play at all if prefs disable it
				if(!retaliated)
					src.visible_message("<span class='userdanger'>[src] seems pretty pissed off at [M]!</span>")
					retaliated = TRUE
					retaliatedcooldown = world.time + retaliatedcooldowntime
		else if(ismecha(A))
			var/obj/vehicle/sealed/mecha/M = A
			if(length(M.occupants) && M.occupants[1].client)
				enemies |= M
				enemies |= M.occupants[1]
				var/mob/living/O = M.occupants[1]
				if(O?.client?.prefs?.toggles & SOUND_AMBIENCE)
					O.stop_sound_channel(CHANNEL_JUKEBOX)
					songend = chosenlength + world.time
					SEND_SOUND(O, chosensong)
				if(!retaliated)
					src.visible_message("<span class='userdanger'>[src] seems pretty pissed off at [M]!</span>")
					retaliated = TRUE
					retaliatedcooldown = world.time + retaliatedcooldowntime

	for(var/mob/living/simple_animal/hostile/megafauna/H in around)
		if(faction_check_mob(H) && !attack_same && !H.attack_same)
			H.enemies |= enemies
	return 0

/mob/living/simple_animal/hostile/megafauna/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	. = ..()
	if(. > 0 && stat == CONSCIOUS)
		Retaliate()

/mob/living/simple_animal/hostile/megafauna/Life()
	..()
	if(songend)
		if(world.time >= songend)
			for(var/mob/living/M in view(src, vision_range))
				if(client)
					if(M?.client?.prefs?.toggles & SOUND_AMBIENCE)
						M.stop_sound_channel(CHANNEL_JUKEBOX)
						songend = chosenlength + world.time
						SEND_SOUND(M, chosensong)
	if(health <= glorythreshold && !glorykill && stat != DEAD)
		glorykill = TRUE
		glory()
	if(retaliated)
		if(retaliatedcooldown < world.time)
			retaliated = FALSE

/mob/living/simple_animal/hostile/megafauna/proc/glory()
	desc += "<br><b>[src] is staggered and can be glory killed!</b>"
	animate(src, color = "#00FFFF", time = 5)

/mob/living/simple_animal/hostile/megafauna/death()
	if(health > 0)
		return
	else
		for(var/mob/living/M in view(src, vision_range))
			if(M?.client?.prefs?.toggles & SOUND_AMBIENCE)
				M.stop_sound_channel(CHANNEL_JUKEBOX)
		animate(src, color = initial(color), time = 3)
		desc = initial(desc)
		var/datum/status_effect/crusher_damage/C = has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/crusher_kill = FALSE
		if(C && crusher_loot && C.total_damage >= maxHealth * 0.6)
			spawn_crusher_loot()
			crusher_kill = TRUE
		if(!(flags_1 & ADMIN_SPAWNED_1))
			var/tab = "megafauna_kills"
			if(crusher_kill)
				tab = "megafauna_kills_crusher"
			SSblackbox.record_feedback("tally", tab, 1, "[initial(name)]")
			if(!elimination)	//used so the achievment only occurs for the last legion to die.
				grant_achievement(achievement_type, score_achievement_type, crusher_achievement_type)
		return ..()

/mob/living/simple_animal/hostile/megafauna/AltClick(mob/living/carbon/slayer)
	if(!slayer.canUseTopic(src, TRUE))
		return
	if(glorykill)
		if(ranged)
			if(ranged_cooldown >= world.time)
				ranged_cooldown += 10
			else
				ranged_cooldown = 10 + world.time
		if(do_mob(slayer, src, 10) && (stat != DEAD))
			var/message
			if(!slayer.get_active_held_item() || (!istype(slayer.get_active_held_item(), /obj/item/kinetic_crusher) && !istype(slayer.get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator)))
				message = pick(glorymessageshand)
			else if(istype(slayer.get_active_held_item(), /obj/item/kinetic_crusher))
				message = pick(glorymessagescrusher)
			else if(istype(slayer.get_active_held_item(), /obj/item/gun/energy/kinetic_accelerator))
				message = pick(glorymessagespka)
				var/obj/item/gun/energy/kinetic_accelerator/KA = get_active_held_item()
				if(KA && KA.bayonet)
					message = pick(glorymessagespka | glorymessagespkabayonet)
			if(message)
				visible_message("<span class='danger'><b>[slayer] [message]</b></span>")
			else
				visible_message("<span class='danger'><b>[slayer] does something generally considered brutal to [src]... Whatever that may be!</b></span>")
			adjustHealth(maxHealth, TRUE, TRUE)
			if(mob_biotypes & MOB_ORGANIC)
				new /obj/effect/gibspawner/generic(src.loc)
			else if(mob_biotypes & MOB_ROBOTIC)
				new /obj/effect/gibspawner/robot(src.loc)
			slayer.heal_overall_damage(gloryhealth,gloryhealth)
		else
			to_chat(slayer, "<span class='danger'>You fail to glory kill [src]!</span>")

/mob/living/simple_animal/hostile/megafauna/devour(mob/living/L)
	if(!L)
		return
	visible_message(
		"<span class='danger'>[src] devours [L]!</span>",
		"<span class='userdanger'>You feast on [L], restoring your health!</span>")
	if(!is_station_level(z) || client) //NPC monsters won't heal while on station
		adjustBruteLoss(-L.maxHealth/2)
	if(L?.client?.prefs?.toggles & SOUND_AMBIENCE)
		L.stop_sound_channel(CHANNEL_JUKEBOX)
	L.gib()
	..()
