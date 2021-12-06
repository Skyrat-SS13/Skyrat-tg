// THE MARKED ONE
/mob/living/simple_animal/hostile/megafauna/gladiator
	name = "\proper The Marked One"
	desc = "An ancient miner lost to time, chosen and changed by the Necropolis, encased in a suit of armor. His sword glows with unusual light..."
	icon = 'modular_skyrat/master_files/icons/mob/markedone.dmi'
	icon_state = "marked1"
	icon_dead = "marked_dying"
	attack_verb_simple = "cleave"
	attack_verb_continuous = "cleaves"
	attack_sound = 'sound/weapons/resonator_blast.ogg'
	deathsound = 'sound/creatures/space_dragon_roar.ogg'
	deathmessage = "falls on his sword, ash evaporating from every hole in his armor."
	gps_name = "Forgotten Signal"
	rapid_melee = 1
	melee_queue_distance = 2
	melee_damage_lower = 40
	melee_damage_upper = 40
	speed = 1
	move_to_delay = 2.25
	wander = FALSE
	var/block_chance = 50
	ranged = 1
	ranged_cooldown_time = 30
	minimum_distance = 1
	health = 2000
	maxHealth = 2000
	movement_type = GROUND
	weather_immunities = list("lava","ash")
	var/phase = 1
	var/list/enemies = list()
	var/list/introduced = list()
	var/speen = FALSE
	var/speenrange = 4
	var/obj/savedloot = null
	var/charging = FALSE
	var/chargetiles = 0
	var/chargerange = 21
	var/stunned = FALSE
	var/stunduration = 15
	var/move_to_charge = 1.5
	var/list/songs = list("3850" = sound(file = 'modular_skyrat/master_files/sound/ambience/archnemesis.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX))
	var/sound/chosensong
	var/chosenlength
	var/chosenlengthstring
	var/songend
	var/retaliated = FALSE
	var/retaliatedcooldowntime = 6000
	var/retaliatedcooldown
	loot = list(/obj/structure/closet/crate/necropolis/gladiator)
	crusher_loot = list(/obj/structure/closet/crate/necropolis/gladiator/crusher)

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/Retaliate()
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

/mob/living/simple_animal/hostile/megafauna/gladiator/Life()
	. = ..()
	if(!wander)
		for(var/mob/living/M in view(4, src))
			if(!(M in introduced) && (stat != DEAD))
				introduction(M)

/mob/living/simple_animal/hostile/megafauna/gladiator/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE, spread_damage = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = NONE)
	if(speen)
		visible_message("<span class='danger'>[src] brushes off all incoming attacks!")
		return FALSE
	else if(prob(50) && (phase == 1) && !stunned)
		visible_message("<span class='danger'>[src] blocks all incoming damage with his arm!")
		return FALSE
	..()
	update_phase()
	var/adjustment_amount = min(damage * 0.15, 15)
	if(world.time + adjustment_amount > next_move)
		changeNext_move(adjustment_amount)

/mob/living/simple_animal/hostile/megafauna/gladiator/Retaliate()
	. = ..()
	if(!wander)
		wander = TRUE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/introduction(mob/living/target)
	if(src == target)
		introduced += src
		return
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/datum/species/Hspecies = H.dna.species
		if(Hspecies.id == "ashlizard")
			var/list/messages = list("Another dweller comes to die!",\
									"Let my blade help you to see, walker!",\
									"Have you come to die, fool?")
			say(message = pick(messages), language = /datum/language/draconic)
			introduced |= H
			GiveTarget(H)
			Retaliate()
		else if(Hspecies.id == "human")
			var/list/messages = list("Let us see how worthy you are!",\
									"Die!!",\
									"I will not let you suffer the same fate!")
			say(message = pick(messages))
			introduced |= H
			GiveTarget(H)
			Retaliate()
		else
			var/list/messages = list("Burn beneath my foot!",\
									"You will be crushed beneath me!",\
									"Let us see how worthy you are!",\
									"C'MERE!!")
			say(message = pick(messages))
			introduced |= H
			GiveTarget(H)
			Retaliate()

	else
		say("Coming here was a mistake!")
		introduced |= target

/mob/living/simple_animal/hostile/megafauna/gladiator/Move(atom/newloc, dir, step_x, step_y)
	if(speen || stunned)
		return FALSE
	else
		if(ischasm(newloc))
			var/list/possiblelocs = list()
			switch(dir)
				if(NORTH)
					possiblelocs += locate(x +1, y + 1, z)
					possiblelocs += locate(x -1, y + 1, z)
				if(EAST)
					possiblelocs += locate(x + 1, y + 1, z)
					possiblelocs += locate(x + 1, y - 1, z)
				if(WEST)
					possiblelocs += locate(x - 1, y + 1, z)
					possiblelocs += locate(x - 1, y - 1, z)
				if(SOUTH)
					possiblelocs += locate(x - 1, y - 1, z)
					possiblelocs += locate(x + 1, y - 1, z)
				if(SOUTHEAST)
					possiblelocs += locate(x + 1, y, z)
					possiblelocs += locate(x + 1, y + 1, z)
				if(SOUTHWEST)
					possiblelocs += locate(x - 1, y, z)
					possiblelocs += locate(x - 1, y + 1, z)
				if(NORTHWEST)
					possiblelocs += locate(x - 1, y, z)
					possiblelocs += locate(x - 1, y - 1, z)
				if(NORTHEAST)
					possiblelocs += locate(x + 1, y - 1, z)
					possiblelocs += locate(x + 1, y, z)
			for(var/turf/T in possiblelocs)
				if(ischasm(T))
					possiblelocs -= T
			if(possiblelocs.len)
				var/turf/validloc = pick(possiblelocs)
				if(charging)
					chargetiles++
					if(chargetiles >= chargerange)
						discharge()
				return ..(validloc)
			return FALSE
		else
			if(charging)
				chargetiles++
				if(chargetiles >= chargerange)
					discharge()
			..()

/mob/living/simple_animal/hostile/megafauna/gladiator/Bump(atom/A)
	. = ..()
	if(charging)
		if(isliving(A))
			var/mob/living/LM = A
			forceMove(LM.loc)
			visible_message("<span class='userdanger'>[src] knocks [LM] down!</span>")
			LM.Paralyze(20)
			discharge()
		else if(istype(A, /turf/closed))
			visible_message("<span class='userdanger'>[src] crashes headfirst into [A]!</span>")
			discharge(1.33)

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/update_phase()
	var/healthpercentage = 100 * (health/maxHealth)
	if(src.stat == DEAD)
		return
	switch(healthpercentage)
		if(75 to 100)
			phase = 1
			rapid_melee = initial(rapid_melee)
			move_to_delay = initial(move_to_delay)
			melee_damage_upper = initial(melee_damage_upper)
			melee_damage_lower = initial(melee_damage_lower)
		if(30 to 75)
			phase = 2
			icon_state = "marked2"
			rapid_melee = 2
			move_to_delay = 2
			melee_damage_upper = 30
			melee_damage_lower = 30
		if(0 to 30)
			phase = 3
			icon_state = "marked3"
			rapid_melee = 4
			melee_damage_upper = 25
			melee_damage_lower = 25
			move_to_delay = 1.7
	if(charging)
		move_to_delay = move_to_charge

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/zweispin()
	visible_message("<span class='boldwarning'>[src] lifts his ancient blade, and prepares to spin!</span>")
	speen = TRUE
	animate(src, color = "#ff6666", 10)
	sleep(5)
	var/list/speenturfs = list()
	var/list/temp = (view(speenrange, src) - view(speenrange-1, src))
	speenturfs.len = temp.len
	var/woop = FALSE
	var/start = 0
	for(var/i in 0 to speenrange)
		speenturfs[1+i] = locate(x - i, y - speenrange, z)
		start = i
	for(var/i in 1 to (speenrange*2))
		var/turf/T = speenturfs[start]
		speenturfs[start+i] = locate(T.x, T.y + i, T.z)
		if(i == (speenrange*2))
			start = (start+i)
	for(var/i in 1 to (speenrange*2))
		var/turf/T = speenturfs[start]
		speenturfs[start+i] = locate(T.x + i, T.y, T.z)
		if(i == (speenrange*2))
			start = (start+i)
	for(var/i in 1 to (speenrange*2))
		var/turf/T = speenturfs[start]
		speenturfs[start+i] = locate(T.x, T.y - i, T.z)
		if(i == (speenrange*2))
			start = (start+i)
	for(var/i in 1 to speenrange)
		var/turf/T = speenturfs[start]
		speenturfs[start+i] = locate(T.x - i, T.y, T.z)
	var/list/hit_things = list()
	for(var/turf/T in speenturfs)
		src.dir = get_dir(src, T)
		for(var/turf/U in (get_turf(src)))
			var/obj/effect/temp_visual/small_smoke/smonk = new /obj/effect/temp_visual/small_smoke(U)
			QDEL_IN(smonk, 1.25)
			for(var/mob/living/M in U)
				if(!faction_check(faction, M.faction) && !(M in hit_things))
					playsound(src, 'sound/weapons/slash.ogg', 75, 0)
					if(M.apply_damage(40, BRUTE, BODY_ZONE_CHEST, M.run_armor_check(BODY_ZONE_CHEST), null, null, CANT_WOUND))
						visible_message("<span class = 'userdanger'>[src] slashes [M] with his spinning blade!</span>")
					else
						visible_message("<span class = 'userdanger'>[src]'s spinning blade is stopped by [M]!</span>")
						woop = TRUE
					hit_things += M
		if(woop)
			break
		sleep(1.25)
	animate(src, color = initial(color), 3)
	sleep(3)
	speen = FALSE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/chargeattack(atom/target, var/range)
	face_atom(target)
	visible_message("<span class='boldwarning'>[src] lifts his arm, and prepares to charge!</span>")
	animate(src, color = "#ff6666", 3)
	sleep(4)
	face_atom(target)
	move_to_delay = move_to_charge
	minimum_distance = 0
	charging = TRUE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/discharge(var/modifier = 1)
	stunned = TRUE
	charging = FALSE
	minimum_distance = 1
	chargetiles = 0
	animate(src, color = initial(color), 7)
	update_phase()
	sleep(stunduration * modifier)
	stunned = FALSE

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/teleport(atom/target)
	var/turf/T = get_step(target, -target.dir)
	new /obj/effect/temp_visual/small_smoke/halfsecond(get_turf(src))
	sleep(4)
	if(!ischasm(T) && !(/mob/living in T))
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		forceMove(T)
	else
		var/list/possible_locs = (view(3, target) - view(1, target))
		for(var/atom/A in possiblelocs)
			if(!isturf(A))
				possiblelocs -= A
			else
				if(ischasm(A) || istype(A, /turf/closed) || (/mob/living in A))
					possiblelocs -= A
		if(possiblelocs.len)
			T = pick(possiblelocs)
			new /obj/effect/temp_visual/small_smoke/halfsecond(T)
			forceMove(T)

/mob/living/simple_animal/hostile/megafauna/gladiator/AttackingTarget()
	. = ..()
	if(speen || stunned)
		return FALSE
	if(charging)
		Bump(target)
	if(. && prob(5 * phase))
		teleport(target)

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/boneappletea(atom/target)
	var/obj/item/knife/combat/bone/boned = new /obj/item/knife/combat/bone(get_turf(src))
	boned.throwforce = 35
	playsound(src, 'sound/weapons/bolathrow.ogg', 60, 0)
	boned.throw_at(target, 7, 3, src)
	QDEL_IN(boned, 30)

/mob/living/simple_animal/hostile/megafauna/gladiator/OpenFire()
	if(world.time < ranged_cooldown)
		return FALSE
	if(speen || stunned || charging)
		return FALSE
	ranged_cooldown = world.time
	switch(phase)
		if(1)
			if(prob(25) && (get_dist(src, target) <= 4))
				zweispin()
				ranged_cooldown += 70
			else
				if(prob(66))
					chargeattack(target, 21)
					ranged_cooldown += 40
				else
					teleport(target)
					ranged_cooldown += 35
		if(2)
			if(prob(40) && (get_dist(src, target) <= 4))
				zweispin()
				ranged_cooldown += 55
			else
				if(prob(40))
					boneappletea(target)
					ranged_cooldown += 35
				else
					teleport(target)
					ranged_cooldown += 30
		if(3)
			if(prob(35))
				boneappletea(target)
				ranged_cooldown += 30
			else
				teleport(target)
				ranged_cooldown += 20

//Aggression helpers
/obj/effect/step_trigger/gladiator
	var/mob/living/simple_animal/hostile/megafauna/gladiator/glady

/obj/effect/step_trigger/gladiator/Initialize()
	. = ..()
	for(var/mob/living/simple_animal/hostile/megafauna/gladiator/G in view(7, src))
		if(!glady)
			glady = G

/obj/effect/step_trigger/gladiator/Trigger(atom/movable/A)
	if(isliving(A))
		var/mob/living/bruh = A
		glady.enemies |= bruh
		glady.GiveTarget(bruh)
		for(var/obj/effect/step_trigger/gladiator/glad in view(7, src))
			qdel(glad)
		return TRUE
	return FALSE
