/*
Original PR made by sushifish on Russ Station. Bob joga just did a lazy ass port.
SIF (Sprites and ideas by MetalGearMan)

Sif spawns randomly in lavaland when it can, in the form of a sword which the user needs to interact with in order to summon Sif.

Speical attacks:
	- When Sif's able to he will charge his current target with 200% increased speed for 1 second, getting right next to his target.
	- Sif can also do an AOE spin attack.

	Links for videos on all of Sif's modes and attacks:

	Summon:			  https://bungdeep.com/Sif/Sif_Summon.mp4
	Angered Stage:	  https://bungdeep.com/Sif/Sif_Angered.mp4
	Enraged Stage:	  https://bungdeep.com/Sif/Sif_Enraged.mp4

	Projectile Dodge: https://bungdeep.com/Sif/Sif_Dodge.mp4

	AOE Spin:		  https://bungdeep.com/Sif/Sif_Spin.mp4
	Charge: 		  https://bungdeep.com/Sif/Sif_Charge.mp4
	Spin and Charge:  https://bungdeep.com/Sif/Sif_Spin_and_charge.mp4

	Death:			  https://bungdeep.com/Sif/Sif_Death.mp4

Sif has three stages:
 1. Normal state when it has health above 50%.
 2. When Sif reaches below 50% health it enters a angered state, which makes Sif's movement speed faster and attack speed slower,
 	with increased usage of specials.
 3. At 20% health Sif is significantly slowed but constantly doing special attacks.

WHEN SIF IS ANGERED (Stage 2):
	- Sif's specials take 50% less time to recharge from (Normal = 100) to (Angered = 50)
	- Sif's attack speed decreased by 30% and movement speed increased by 50%

WHEN SIF IS ENRAGED (Stage 3):
	- Sif's specials take 60% less time to recharge from (Angered = 50) to (Enraged = 30)
	- Sif is way slower but does more damage, as well as chances to dodge projectiles and melee attacks more often.

When Sif dies, it leaves behind a:
	!! Sword Of The Forsaken !! -> Giant ass sword that does damage. Small chance of blocking hits and almost no chance to block projectiles.
	!! Necklace Of The Forsaken !! -> Works by instantly reviving or fully healing the user at their discretion (one time use and can be used when dead, knocked out or alive)
	!! Dark Energy !! (If killed with a kinetic crusher) -> A Kinetic Crusher attachment which performs a bash attack for 100 damage (only works on big boy mobs like megafaunas)
Difficulty: Medium
*/

/mob/living/simple_animal/hostile/megafauna/sif
	name = "Great Brown Wolf Sif"
	desc = "Guardian of the abyss. Looks pretty pissed that you're here."
	health = 2000
	maxHealth = 2000
	movement_type = GROUND
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'modular_skyrat/modules/skyrat_mining/sound/sif/sif_slash.ogg'
	icon_state = "Great_Brown_Wolf"
	icon_living = "Great_Brown_Wolf"
	icon_dead = ""
	friendly_verb_continuous = "stares down"
	friendly_verb_simple = "stare down"
	icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/lavaland/sif.dmi'
	speak_emote = list("growls")
	armour_penetration = 50
	melee_damage_lower = 35
	melee_damage_upper = 35
	speed = 1.5
	pixel_x = -32 //Hit box perfectly centered
	pixel_y = -16
	move_to_delay = 3
	rapid_melee = 2
	melee_queue_distance = 10
	ranged = FALSE
	del_on_death = 1
	loot = list(/obj/structure/closet/crate/necropolis/sif)
	crusher_loot = list(/obj/structure/closet/crate/necropolis/sif/crusher)

	gps_name = "Infinity Signal"

	deathmessage = "falls into the abyss."
	var/can_special = 1 //Enables sif to do what he does best, spin and charge
	var/spinIntervals = 0 //Counts how many spins Sif does before setting spinning status to false
	var/spinning = FALSE //AOE spin special attack status
	var/charging = FALSE //dashing special attack status
	var/angered = FALSE //active at < 50% health
	var/enraged = FALSE //active at < 20% health
	var/stageTwo = FALSE
	var/stageThree = FALSE
	var/currentPower = 0 //Every few seconds this variable gets higher, when it gets high
						 //enough it will use a special attack then reset the variable to 0w
	songs = list("2670" = sound(file = 'modular_skyrat/modules/skyrat_mining/sound/ambience/furidanger802.ogg', repeat = 0, wait = 0, volume = 100, channel = CHANNEL_JUKEBOX))
	glorymessageshand = list("climbs atop the wolf's head as it dangles weakly near the ground, ripping its left eye off and jumping down before punching through it's cranium!", "goes around the wolf and rips off their tail, using it as whip on the fiend")
	glorymessagescrusher = list("chops off the wolf's head by it's neck!")
	glorymessagespka = list("shoots at the wolf's eyes with their PKA, exploding them into giblets!")
	glorymessagespkabayonet = list("slides down below Sif, using their bayonet to rip it's stomach open!")
	var/list/hit_things = list()

/obj/item/gps/internal/sif
	icon_state = null
	gpstag = "Infinity Signal"
	desc = "No, it's not thanos."

//Sword structure, used to summon sif.
/obj/structure/sword/sif
	name = "Massive Glowing Sword"
	desc = "Sweet! A free sword!"
	max_integrity = 10000
	anchored = TRUE
	icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/lavaland/sif_sword.dmi'
	icon_state = "Idle_Sword"
	layer = HIGH_OBJ_LAYER //Looks better when its over everything... cause its huge
	var/obj/item/gps/internal/geepm

/obj/structure/sword/sif/Initialize()
	. = ..()
	geepm = new /obj/item/gps/internal/sif(src)

//When the sword is touched it will spawn sif.
/obj/structure/sword/sif/attack_hand(mob/user)
	icon_state = "Interact_Sword"
	playsound(get_turf(src.loc), 'sound/effects/curse1.ogg', 100, 1)
	spawn(30)
		if(!QDELETED(src))
			new /mob/living/simple_animal/hostile/megafauna/sif(get_turf(src.loc))
			visible_message("<span class='notice'>The ground shakes.</span>")
			playsound(get_turf(src.loc), 'sound/effects/curse3.ogg', 100, 1)
			playsound(get_turf(src.loc), 'sound/effects/meteorimpact.ogg', 100, 1)
			qdel(src)

//Sif's charge attack
/mob/living/simple_animal/hostile/megafauna/sif/proc/rush()

	//Target
	if(!target)
		return //Exit porc

	var/chargeturf = get_turf(target)

	//Targets turf
	if(!chargeturf)
		return //Exit proc

	var/dir = get_dir(src, chargeturf)
	var/turf/T = get_ranged_target_turf(chargeturf, dir, 2)

	//Turfs area
	if(!T)
		return //Exit proc

	//Start charging
	charging = TRUE
	DestroySurroundings()
	walk(src, 0)
	setDir(dir)
	var/movespeed = 1
	walk_to(src, T, movespeed)
	var/atom/prevLoc = target.loc
	sleep((get_dist(src, T) * movespeed) + 1)
	src.loc = prevLoc
	walk(src, 0)
	charging = FALSE
	//Stop charging

/mob/living/simple_animal/hostile/megafauna/sif/Move()
	//Move
	..()

	//Can they perform these tasks?
	if(can_special == 1)

		//Charging currentPower every step
		if(!charging || !spinning)
			src.currentPower += 2

		//Sets sif's anger status.
		if(src.health <= 1000 && src.stageTwo == FALSE)
			angered()

		//Sets sifs enrage status.
		if(src.health <= 400 && src.stageThree == FALSE)
			enraged()

		//Whenever Sif moves he destroys walls in his way.
		if(src.angered == TRUE || src.enraged == TRUE)
			DestroySurroundings()

		//Normally Sif will do a special when he has 100 currentPower.
		if(src.angered == FALSE && src.currentPower >= 100)
			special()

		//Now requires 50 power when angery
		if(src.angered == TRUE && src.currentPower >= 50 && src.enraged == FALSE)
			special()

		//Now requires 30 power when enraged
		if(src.enraged == TRUE && src.currentPower >= 30)
			special()

		//visual effect
		if(src.charging == TRUE)
			new /obj/effect/temp_visual/decoy/fading(loc,src)
			DestroySurroundings()

//Sif's AOE spin attack
/mob/living/simple_animal/hostile/megafauna/sif/proc/spinAttack()
	src.spinning = TRUE
	spin(5,2)// Spin me boi

//Chance to dodge projectiles when angered or enraged
/mob/living/simple_animal/hostile/megafauna/sif/bullet_act(obj/projectile/P)
	var/passed = 0

	if(angered)
		switch(rand(0,100))
			if(0 to 1)
				passed = 1

	if(enraged)
		switch(rand(0,100))
			if(0 to 5)
				passed = 1

	if(passed == 1)
		visible_message("<span class='danger'>[src] dodged the projectile!</span>", "<span class='userdanger'>You dodge the projectile!</span>")
		playsound(src, pick('sound/weapons/bulletflyby.ogg', 'sound/weapons/bulletflyby2.ogg', 'sound/weapons/bulletflyby3.ogg'), 300, 1)
		return 0

	return ..()

//Sets Sif's angered stats
/mob/living/simple_animal/hostile/megafauna/sif/proc/angered()
	src.angered = TRUE
	src.stageTwo = TRUE
	src.visible_message("<span class='userdanger'>[src] lets out a ear ripping howl!</span>", "<span class='userdanger'>[src] lets out an ear ripping roar!</span>")
	playsound(src, 'modular_skyrat/modules/skyrat_mining/sound/sif/howl.ogg', 100, 1)
	var/mob/living/L = target
	shake_camera(L, 4, 3)
	src.speed = 6
	src.move_to_delay = 2
	src.melee_damage_lower = 25
	src.melee_damage_upper = 25
	src.rapid_melee = 3

//Sets Sif's enraged stats
/mob/living/simple_animal/hostile/megafauna/sif/proc/enraged()
	src.stageThree = TRUE
	src.enraged = TRUE
	src.visible_message("<span class='userdanger'>[src] lets out a ear ripping yelp!</span>", "<span class='userdanger'>[src] lets out an ear ripping yelp!</span>")
	playsound(src, 'modular_skyrat/modules/skyrat_mining/sound/sif/howl.ogg', 100, 1)
	var/mob/living/L = target
	shake_camera(L, 8, 6)
	src.speed = 3
	src.move_to_delay = 4
	src.melee_damage_lower = 30
	src.melee_damage_upper = 30
	src.rapid_melee = 4
	src.dodge_prob = 50

//Chooses a random special
/mob/living/simple_animal/hostile/megafauna/sif/proc/special()
	src.currentPower = 0
	switch(rand(1,2))
		if(1)
			rush()
		if(2)
			spinAttack()

/mob/living/simple_animal/hostile/megafauna/sif/proc/default_attackspeed()
	if(stageTwo)
		src.move_to_delay = 2
		return 10
	if(stageThree)
		src.move_to_delay = 4
		return 4

	src.move_to_delay = 3
	return 2

/mob/living/simple_animal/hostile/megafauna/sif/do_attack_animation(atom/A, visual_effect_icon,used_item, no_effect)
	if(charging == FALSE)
		..()

//Attack speed delay
//bob's note: everything here is well coded except this like why would you not just use changeNext_move()
/mob/living/simple_animal/hostile/megafauna/sif/AttackingTarget()
	if(charging == FALSE)
		. = ..()
		if(.)
			recovery_time = world.time + 10

/mob/living/simple_animal/hostile/megafauna/sif/Goto(target, delay, minimum_distance)
	if(charging == FALSE)
		..()

/mob/living/simple_animal/hostile/megafauna/sif/MoveToTarget(list/possible_targets)
	if(charging == FALSE)
		..()

//Immune to explosions when spinning or charging
/mob/living/simple_animal/hostile/megafauna/sif/ex_act(severity, target)
	return 0

//stop spinning if you lose the target
/mob/living/simple_animal/hostile/megafauna/sif/LoseTarget()
	. = ..()
	if(spinning)
		icon_state = "Great_Brown_Wolf"
		src.spinIntervals = 0
		spinning = FALSE
		src.speed = default_attackspeed()
		hit_things = list()

/mob/living/simple_animal/hostile/megafauna/sif/Moved()

	if(can_special == 1)

		if(charging == TRUE)
			DestroySurroundings()

		//Stop spinning
		if(src.spinIntervals == 5)
			icon_state = "Great_Brown_Wolf"
			src.spinIntervals = 0
			spinning = FALSE
			src.speed = default_attackspeed()
			hit_things = list()

		//Start spinning
		if(spinning == TRUE)
			icon_state = "Great_Brown_Wolf_Spin"
			src.spinIntervals += 1
			if(isturf(src.loc) || isobj(src.loc) && src.loc.density)
				for(var/turf/T in view(1, src))
					new /obj/effect/temp_visual/small_smoke/halfsecond(T)
				for(var/mob/living/LM in view(1, src))
					if(!(LM in hit_things))
						LM.Stun(30, TRUE)
						hit_things += LM
				playsound(src, pick('modular_skyrat/modules/skyrat_mining/sound/sif/whoosh1.ogg', 'modular_skyrat/modules/skyrat_mining/sound/sif/whoosh2.ogg', 'modular_skyrat/modules/skyrat_mining/sound/sif/whoosh3.ogg'), 300, 1)
				playsound(src, 'modular_skyrat/modules/skyrat_mining/sound/sif/blade_spin.ogg', 400, 1)
				if(angered)
					src.speed = 6
					src.move_to_delay = 2

	playsound(src, 'sound/effects/meteorimpact.ogg', 200, 1, 2, 1)
	..()

//Activated when sif collides with target when charging.
/mob/living/simple_animal/hostile/megafauna/sif/Bump(atom/A)
	if(charging == TRUE)
		if(isturf(A) || isobj(A) && A.density)
			A.ex_act(EXPLODE_HEAVY)
		DestroySurroundings()
		if(isliving(A))
			var/mob/living/L = A
			L.visible_message("<span class='danger'>[src] stomps on [L]!</span>", "<span class='userdanger'>[src] stomps on you!</span>")
			src.forceMove(get_turf(L))
			L.apply_damage(20, BRUTE)
			playsound(get_turf(L), 'modular_skyrat/modules/skyrat_mining/sound/sif/sif_stomp.ogg', 400, 1)
			shake_camera(L, 4, 3)
			shake_camera(src, 2, 3)
	..()
