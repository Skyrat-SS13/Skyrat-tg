/mob/living/simple_animal/hostile/fleshmind/tyrant
	name = "Tyrant Type 34-C"
	desc = "The will of the many, manifested in flesh and metal. It has fucking rockets."
	icon = 'modular_skyrat/modules/fleshmind/icons/tyrant.dmi'
	icon_state = "tyrant"
	health = 2000
	maxHealth = 2000
	projectiletype = /obj/projectile/bullet/c50cal/tyrant
	projectilesound = 'modular_skyrat/modules/mounted_machine_gun/sound/50cal_box_01.ogg'
	minimum_distance = 5
	ranged = TRUE
	rapid = 4
	mob_size = MOB_SIZE_HUGE
	move_to_delay = 10
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
		"The glory of the flesh is now absolute.",
		"This is our final form.",
		"Per aspera ad astra.",
	)
	speak = list(
		"We have reached critical mass. Die heathen.",
		"You are nolonger welcome in the flesh.",
		"We have no use for your flesh, time to die.",
		"INITIATING PROTOCOL 34-C.",
		"YOUR INDEX HAS REACHED ITS LIMIT.",
		"Death is the only option for you.",
		"Target acquired, spinning up minigun."
	)
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
	/// The cooldown on our rocket pod use.
	var/rocket_pod_cooldown_time = 10 SECONDS
	COOLDOWN_DECLARE(rocket_pod_cooldown)
	/// The projectile we fire when shooting our rocket pods.
	var/special_projectile_type = /obj/projectile/bullet/a84mm/weak
	/// The sound we play when firing our rocket pods.
	var/special_projectile_sound = 'sound/weapons/gun/general/rocket_launch.ogg'
	/// The time it takes for us to charge up our rocket pods
	var/special_pod_charge_up_time = 3 SECONDS
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
	var/death_sound = 'modular_skyrat/modules/fleshmind/sound/tyrant/tyrant_death.ogg'

/mob/living/simple_animal/hostile/fleshmind/tyrant/Life(delta_time, times_fired)
	. = ..()
	if(health <= (maxHealth * 0.5) && prob(20))
		do_sparks(3, FALSE, src)

/mob/living/simple_animal/hostile/fleshmind/tyrant/Destroy()
	QDEL_NULL(particles)
	return ..()

/mob/living/simple_animal/hostile/fleshmind/tyrant/death(gibbed)
	playsound(src, death_sound, 100)
	return ..()

/mob/living/simple_animal/hostile/fleshmind/tyrant/updatehealth()
	. = ..()
	if(health <= (maxHealth * 0.5))
		particles = new /particles/smoke()
	update_appearance()

/mob/living/simple_animal/hostile/fleshmind/tyrant/update_overlays()
	. = ..()
	if(health <= (maxHealth * 0.5))
		. += "tyrant_damage"

/mob/living/simple_animal/hostile/fleshmind/tyrant/Moved()
	. = ..()
	playsound(src, pick(footstep_sounds), 100, TRUE)

/mob/living/simple_animal/hostile/fleshmind/tyrant/setDir(newdir)
	. = ..()
	if(COOLDOWN_FINISHED(src, rotate_sound_cooldown))
		playsound(src, 'modular_skyrat/modules/fleshmind/sound/tyrant/mech_rotation.ogg', 35, TRUE)
		COOLDOWN_START(src, rotate_sound_cooldown, rotate_sound_cooldown_time)

/mob/living/simple_animal/hostile/fleshmind/tyrant/OpenFire(atom/target_atom)
	. = ..()
	if(COOLDOWN_FINISHED(src, rocket_pod_cooldown))
		balloon_alert_to_viewers("begins whirring violently!")
		playsound(src, 'modular_skyrat/modules/fleshmind/sound/tyrant/charge_up.ogg', 100, TRUE)
		addtimer(CALLBACK(src, .proc/fire_rocket_pods, target_atom), special_pod_charge_up_time)
		COOLDOWN_START(src, rocket_pod_cooldown, rocket_pod_cooldown_time)

/mob/living/simple_animal/hostile/fleshmind/tyrant/proc/fire_rocket_pods(atom/target_atom)
	if(!target_atom || QDELETED(target_atom))
		return
	if(barage > 1)
		var/datum/callback/callback = CALLBACK(src, .proc/fire_rocket, target_atom)
		for(var/i in 1 to barage)
			addtimer(callback, (i - 1) * barage_interval)
	else
		fire_rocket(target_atom)

/mob/living/simple_animal/hostile/fleshmind/tyrant/proc/fire_rocket(atom/target_atom)
	if(!target_atom || QDELETED(target_atom))
		return
	playsound(loc, special_projectile_sound, 100, TRUE)
	var/obj/projectile/new_projectile = new special_projectile_type
	new_projectile.preparePixelProjectile(target_atom, get_turf(src))
	new_projectile.firer = src
	new_projectile.fired_from = src
	new_projectile.ignored_factions = faction
	new_projectile.fire()

/obj/projectile/bullet/c50cal/tyrant
	damage = 30
	wound_bonus = 40
	armour_penetration = 20
