/* THE GLADIATOR
* Has 4 special attacks, which are used depending on the phase (the gladiator has 3 phases).
* AoE Zweihander swing: In a square of 4×4, he swings his sword in a 360 degree arc, damaging anything within it.
* Shield bash: The gladiator charges and chases you with increased speed for 21 tiles, if he makes contact, he bashes you and knocks you down.
He will stun himself for up to 2.25 seconds, no matter the result of the charge attack; This leaves him vulnerable for attacks for a few precious moments.
* Bone daggers: At random times if the player is running, he can throw bone daggers that will go considerably fast in the players direction.
They deal 35 brute (armor is considered).
* Additionally, he gets more speedy and aggressive as he raises in phase, at the cost of some special attacks.
* On phase 1, the gladiator has a 50% block chance for any attack.
* Loot:
* Gladiator tower shield - A powerful and indestructible shield, that can also be used as a surfboard.
* Shielding modkit - A modkit that grants your PKA a 15% chance to block any incoming attack while held.
* Tomahawk - Basically a one handed crusher to complement the shield.
*/
/mob/living/simple_animal/hostile/megafauna/gladiator
	name = "\proper The Gladiator"
	desc = "An immortal ash walker, whose powers have been granted by the necropolis itself."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/lavaland/lavaland_monsters.dmi'
	icon_state = "gladiator1"
	icon_dead = "gladiator-dead"
	attack_verb_simple = "slashes"
	attack_verb_continuous = "slash"
	attack_sound = 'modular_skyrat/modules/skyrat_mining/sound/zweihanderslice.ogg'
	deathmessage = "gets discombobulated and fucking dies."
	rapid_melee = 1
	melee_queue_distance = 2
	melee_damage_lower = 35
	melee_damage_upper = 35
	speed = 1
	move_to_delay = 2.25
	wander = FALSE
	var/block_chance = 50
	ranged = 1
	ranged_cooldown_time = 30
	minimum_distance = 1
	health = 1500
	maxHealth = 1500
	movement_type = GROUND
	weather_immunities = list("lava","ash")
	var/phase = 1
	var/list/introduced = list() //Basically all the mobs which the gladiator has already introduced himself to.
	var/speen = FALSE
	var/speenrange = 4
	var/obj/savedloot = null
	var/charging = FALSE
	var/chargetiles = 0
	var/chargerange = 21
	var/stunned = FALSE
	var/stunduration = 15
	var/move_to_charge = 1.5
	gps_name = "Dreadful Signal"
	songs = list("3850" = sound(file = 'modular_skyrat/modules/skyrat_mining/sound/ambience/gladiator.ogg', repeat = 0, wait = 0, volume = 70, channel = CHANNEL_JUKEBOX))
	loot = list(/obj/structure/closet/crate/necropolis/gladiator)
	crusher_loot = list(/obj/structure/closet/crate/necropolis/gladiator/crusher)
	glorymessageshand = list("grabs the gladiator's arm, flips their zweihander with the other hand, and forcefully makes them chop off their own head with it!", "grabs the gladiator by their zweihander, and mark detonate them into a shower of gibs!", "rips out both of the gladiator's arms, then kicks their limp torso on the groundd and curbstomps their head in so hard it explodes!")
	glorymessagescrusher = list("chops off gladiator's zweihandder arm in one swift move, then grabs the zweihander and swings it against their head, chopping their skull vertically in half!", "bashes the gladiator to the ground with the hilt of their crusher, then elbow drops their skull so hard it explodes in gore!", "chops the gladiator diagonally with their crusher, not quite cutting through but getting their crusher halfway stuck and killing the screaming fiend!")
	glorymessagespka = list("grabs the gladiator by the neck and flips them, shooting through their guts with a PKA blast!", "shoots at the gladiator's shoulder, exploding their arm! To finish the fiend off, they grab their PKA and bonk the gladiator's head inside their torso!", "doesn't bother with being fancy, and simply shoots at the gladiator's head with their PKA, exploding it in one violent blast!")
	glorymessagespkabayonet = list("rams into the gladiator's stomach with their PKA's bayonet, knocking them and themselves down! To finish the fiend off, they simply stab into their torso like a madman with their bayonet!", "kicks the gladiator's knee hard, breaking it! While the fiend is stunned and barely standing, their chop their head off with the PKA's bayonet!")
	glorythreshold = 50

/mob/living/simple_animal/hostile/megafauna/gladiator/Life()
	. = ..()
	if(!wander)
		for(var/mob/living/M in view(4, src))
			if(!(M in introduced) && (stat != DEAD))
				introduction(M)

/mob/living/simple_animal/hostile/megafauna/gladiator/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE, spread_damage = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE) //skyrat edit
	if(speen)
		visible_message("<span class='danger'>[src] brushes off all incoming attacks!")
		return FALSE
	else if(prob(50) && (phase == 1) && !stunned)
		visible_message("<span class='danger'>[src] blocks all incoming damage with his shield!")
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
			var/list/messages = list("I am sorry, tribesssmate. I cannot let you through.",\
									"Pleassse leave, walker.",\
									"The necropolisss must be protected even from it'ss servants. Pleassse retreat.")
			say(message = pick(messages), language = /datum/language/draconic)
			introduced |= H
		else if(Hspecies.id == "lizard")
			var/list/messages = list("Thisss isss not the time nor place to be. Leave.",\
									"Go back where you came from. I am sssafeguarding thisss sssacred place.",\
									"You ssshould not be here. Turn.",\
									"I can sssee an outlander from a mile away. You're not one of us."\
									)
			say(message = pick(messages), language = /datum/language/draconic)
			introduced |= H
		else if(Hspecies.id == "dunmer")
			var/list/messages = list("I will finisssh what little of your race remainsss, starting with you!",\
									"Lavaland belongsss to the lizzzards!",\
									"Thisss sacred land wasn't your property before, it won't be now!")
			say(message = pick(messages))
			introduced |= H
			GiveTarget(H)
			Retaliate()
		else
			var/list/messages = list("Get out of my sssight, outlander.",\
									"You will not run your dirty handsss through what little sssacred land we have left. Out.",\
									"My urge to end your life isss immeasssurable, but I am willing to ssspare you. Leave.",\
									"You're not invited. Get out.")
			say(message = pick(messages))
			introduced |= H

	else
		say("You are not welcome into the necropolisss.")
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
			LM.Knockdown(60)
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
			icon_state = "gladiator2"
			rapid_melee = 2
			move_to_delay = 2
			melee_damage_upper = 30
			melee_damage_lower = 30
		if(0 to 30)
			phase = 3
			icon_state = "gladiator3"
			rapid_melee = 4
			melee_damage_upper = 25
			melee_damage_lower = 25
			move_to_delay = 1.7
	if(charging)
		move_to_delay = move_to_charge

/mob/living/simple_animal/hostile/megafauna/gladiator/proc/zweispin()
	visible_message("<span class='boldwarning'>[src] lifts his zweihander, and prepares to spin!</span>")
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
		for(var/turf/U in (getline(src, T) - get_turf(src)))
			var/obj/effect/temp_visual/small_smoke/smonk = new /obj/effect/temp_visual/small_smoke(U)
			QDEL_IN(smonk, 1.25)
			for(var/mob/living/M in U)
				if(!faction_check(faction, M.faction) && !(M in hit_things))
					playsound(src, 'sound/weapons/slash.ogg', 75, 0)
					if(M.apply_damage(40, BRUTE, BODY_ZONE_CHEST, M.run_armor_check(BODY_ZONE_CHEST), null, null, CANT_WOUND))
						visible_message("<span class = 'userdanger'>[src] slashes [M] with his spinning zweihander!</span>")
					else
						visible_message("<span class = 'userdanger'>[src]'s spinning zweihander is stopped by [M]!</span>")
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
	visible_message("<span class='boldwarning'>[src] lifts his shield, and prepares to charge!</span>")
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
		var/list/possiblelocs = (view(3, target) - view(1, target))
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
	var/obj/item/kitchen/knife/combat/bone/boned = new /obj/item/kitchen/knife/combat/bone(get_turf(src))
	boned.throwforce = 35
	playsound(src, 'sound/weapons/fwoosh.ogg', 60, 0)
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
