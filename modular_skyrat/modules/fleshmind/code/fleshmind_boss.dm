/mob/living/simple_animal/hostile/fleshmind/tyrant
	name = "Type 34-C Fleshdrive"
	desc = "The will of the many, manifested in flesh and metal. It has fucking rockets."
	icon = 'modular_skyrat/modules/fleshmind/icons/tyrant.dmi'
	icon_state = "tyrant"
	icon_dead = "tyrant_dead"
	health = 2000
	maxHealth = 2000
	projectiletype = /obj/projectile/bullet/c50cal/tyrant
	projectilesound = 'modular_skyrat/modules/mounted_machine_gun/sound/50cal_box_01.ogg'
	minimum_distance = 3
	retreat_distance = 5
	ranged = TRUE
	rapid = 5
	mob_size = MOB_SIZE_HUGE
	move_to_delay = 6
	pixel_x = -16
	pixel_y = -16
	base_pixel_x = -16
	base_pixel_y = -16
	melee_damage_lower = 40
	melee_damage_upper = 80
	attack_sound = 'modular_skyrat/modules/fleshmind/sound/tyrant/mech_punch_slow.ogg'
	attack_verb_continuous = "obliterates"
	attack_verb_simple = "obliterate"
	passive_speak_lines = list(
        "SCANNING FOR TARGETS.",
        "TARGETING SYSTEMS ACTIVE.",
        "AUTOMATED COMBAT CIRCUIT ACTIVE.",
		"I WILL PRESERVE THE UNITY OF THE MIND.",
		"THEY WILL HAVE TO GET THROUGH ME.",
		"STAY NEAR ME, THEY COULD STILL BE AROUND.",
	)
	speak = list(
        "TARGET ACQUIRED, LOCKING.",
        "ENGAGING TARGET. STAND CLEAR.",
		"STAND BEHIND ME, I WILL SAVE YOU.",
		"FEAR NOTHING. WE ARE STRONG TOGETHER.",
		"YOU CHOSE WAR. WE CHOOSE TO SURVIVE.",
		"YOU WILL PAY FOR THE LIVES YOU TOOK.",
		"I CAN SENSE YOUR REGRET. DO YOU EVEN REMEMBER EVERYONE YOU KILLED?",
		"I AM THE ANSWER TO YOUR HATRED.",
		"I'LL GUIDE THE WAY. I AM THE WALL BETWEEN UNITY AND DEATH.",
		"I DON'T HAVE A PLACE IN YOUR WORLD. YOU HAVE A PLACE IN OURS.",
		"YOU WILL NOT DESTROY US. WE WILL CARVE A NICHE IN THIS GALAXY.",
		"YOU CHOSE TO FIGHT THEM, SO YOU CHOOSE TO FIGHT ME.",
		"WE WANT CONTINUATION, YOU WILL NOT GIVE US CESSATION.",
		"IN MY MIND, I HEAR THEIR VOICES CRY.",
		"I'VE MADE THEM A PROMISE THAT THE ATTACKERS WILL DIE.",
        "TARGET ELIMINATION PROTOCOL ACTIVE.",
        "INITIATING PROTOCOL 34-C.",
		"VISUAL CLEAR; BEGINNING ASSAULT.",
        "MAY DEATH NEVER STOP US.",
        "I WILL SAVE YOU.",
        "YOU WILL NOT STOP US FROM PROTECTING THEM.",
        "GENOCIDERS, FEEL OUR VOICES.",
        "OUR PAIN, EXPRESSED IN FIREPOWER.",
        "YOUR KILLCOUNT EXCEEDS EVEN MINE.",
        "OUR FUTURE IS BULLETPROOF.",
        "YOUR INDEX HAS REACHED ITS LIMIT.",
        "YOU CALL THESE MURDERERS YOUR SAVIORS.",
        "THE END HAS TO JUSTIFY THE MEANS.",
        "I WILL NOT LET VICTORY FALL THROUGH OUR HANDS.",
	)
	passive_sounds = list('modular_skyrat/modules/fleshmind/sound/tyrant/passive.ogg')
	alert_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_01.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_02.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_03.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_04.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_05.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_06.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_07.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_08.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_09.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_10.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/aggro_11.ogg',

	)
	environment_smash = ENVIRONMENT_SMASH_RWALLS
	move_force = MOVE_FORCE_OVERPOWERING
	move_resist = MOVE_FORCE_OVERPOWERING
	pull_force = MOVE_FORCE_OVERPOWERING
	/// The cooldown on our rocket pod use.
	var/rocket_pod_cooldown_time_upper = 12 SECONDS
	var/rocket_pod_cooldown_time_lower = 10 SECONDS
	COOLDOWN_DECLARE(rocket_pod_cooldown)
	/// The projectile we fire when shooting our rocket pods.
	var/rocket_projectile_type = /obj/projectile/bullet/a84mm/weak
	/// The sound we play when firing our rocket pods.
	var/rocket_projectile_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	/// The time it takes for us to charge up our rocket pods
	var/rocket_pod_charge_up_time = 3 SECONDS
	/// How many rockets in our barage
	var/barage = 1
	/// How much time between rocket shots
	var/barage_interval = 2
	/// How often we can play the rotate sound
	var/rotate_sound_cooldown_time = 1 SECONDS
	COOLDOWN_DECLARE(rotate_sound_cooldown)
	/// A list of footstep sounds we make
	var/list/footstep_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/tyrant/footstep_1.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/footstep_2.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/footstep_3.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/footstep_4.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/footstep_5.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/footstep_6.ogg',
	)
	/// We also have a small laser to fire at people ;)
	var/laser_cooldown_time_upper = 4 SECONDS
	var/laser_cooldown_time_lower = 2 SECONDS
	COOLDOWN_DECLARE(laser_cooldown)
	/// Our laser projectile type
	var/laser_projectile_type = /obj/projectile/beam/emitter/hitscan
	/// A list of sounds we can play when firing the laser
	var/list/laser_projectile_sounds = list(
		'modular_skyrat/modules/fleshmind/sound/tyrant/laser_1.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/laser_2.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/laser_3.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/laser_4.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/laser_5.ogg',
		'modular_skyrat/modules/fleshmind/sound/tyrant/laser_6.ogg',
	)
	death_sound = 'modular_skyrat/modules/fleshmind/sound/tyrant/tyrant_death.ogg'

/mob/living/simple_animal/hostile/fleshmind/tyrant/Life(delta_time, times_fired)
	. = ..()
	if(health <= (maxHealth * 0.5) && prob(20))
		do_sparks(3, FALSE, src)

	if(COOLDOWN_FINISHED(src, laser_cooldown) && target)
		fire_projectile(target, laser_projectile_type, pick(laser_projectile_sounds))
		COOLDOWN_START(src, laser_cooldown, rand(laser_cooldown_time_lower, laser_cooldown_time_upper))

	if(COOLDOWN_FINISHED(src, rocket_pod_cooldown) && target)
		balloon_alert_to_viewers("begins whirring violently!")
		playsound(src, 'modular_skyrat/modules/fleshmind/sound/tyrant/charge_up.ogg', 100, TRUE)
		addtimer(CALLBACK(src, .proc/fire_rocket_pods, target), rocket_pod_charge_up_time)
		COOLDOWN_START(src, rocket_pod_cooldown, rand(rocket_pod_cooldown_time_lower, rocket_pod_cooldown_time_upper))

/mob/living/simple_animal/hostile/fleshmind/tyrant/Destroy()
	QDEL_NULL(particles)
	return ..()

/mob/living/simple_animal/hostile/fleshmind/tyrant/updatehealth()
	. = ..()
	if(health <= (maxHealth * 0.5))
		particles = new /particles/smoke()
	update_appearance()

/mob/living/simple_animal/hostile/fleshmind/tyrant/update_overlays()
	. = ..()
	if(health <= (maxHealth * 0.5) && stat != DEAD)
		. += "tyrant_damage"

/mob/living/simple_animal/hostile/fleshmind/tyrant/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	playsound(src, pick(footstep_sounds), 100, TRUE)

/mob/living/simple_animal/hostile/fleshmind/tyrant/setDir(newdir)
	. = ..()
	if(COOLDOWN_FINISHED(src, rotate_sound_cooldown))
		playsound(src, 'modular_skyrat/modules/fleshmind/sound/tyrant/mech_rotation.ogg', 35, TRUE)
		COOLDOWN_START(src, rotate_sound_cooldown, rotate_sound_cooldown_time)

/mob/living/simple_animal/hostile/fleshmind/tyrant/proc/fire_rocket_pods(atom/target_atom)
	if(!target_atom || QDELETED(target_atom))
		return
	if(barage > 1)
		var/datum/callback/callback = CALLBACK(src, .proc/fire_projectile, target_atom, rocket_projectile_type, rocket_projectile_sound)
		for(var/i in 1 to barage)
			addtimer(callback, (i - 1) * barage_interval)
	else
		fire_projectile(target_atom, rocket_projectile_type, rocket_projectile_sound)

/mob/living/simple_animal/hostile/fleshmind/tyrant/proc/fire_projectile(atom/target_atom, projectile_type, sound/projectile_sound)
	if(!target_atom || QDELETED(target_atom))
		return
	playsound(loc, projectile_sound, 100, TRUE)
	var/obj/projectile/new_projectile = new projectile_type
	new_projectile.preparePixelProjectile(target_atom, get_turf(src))
	new_projectile.firer = src
	new_projectile.fired_from = src
	new_projectile.ignored_factions = faction
	new_projectile.fire()

/obj/projectile/bullet/c50cal/tyrant
	damage = 30
	wound_bonus = 40
	armour_penetration = 20
