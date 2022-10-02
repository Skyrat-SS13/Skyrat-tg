/datum/outbound_gateway_event
	/// Name of the event
	var/name
	/// Threat cost
	var/threat = 0

/datum/outbound_gateway_event/proc/on_event()
	set waitfor = FALSE
	return

/datum/outbound_gateway_event/portal
	name = "Portal Storm - Black Mesa"
	threat = 30
	/// Mutable appearance for the effect when enemies spawn
	var/mutable_appearance/storm
	/// Possible enemies
	var/list/possible_enemies = list(
		/mob/living/simple_animal/hostile/blackmesa/xen/bullsquid = 1,
		/mob/living/simple_animal/hostile/blackmesa/xen/houndeye = 1,
		/mob/living/simple_animal/hostile/blackmesa/xen/headcrab = 1,
		/mob/living/simple_animal/hostile/blackmesa/xen/vortigaunt/slave = 1,
	)
	/// Lower bound for possible amount of enemies
	var/minimum_spawns = 5
	/// Upper bound for possible amount of enemies
	var/maximum_spawns = 8

/datum/outbound_gateway_event/portal/on_event()
	storm = mutable_appearance('icons/obj/engine/energy_ball.dmi', "energy_ball_fast", FLY_LAYER)
	storm.plane = ABOVE_GAME_PLANE
	storm.color = "#00FF00"

	spawn_the_bads()

/datum/outbound_gateway_event/portal/proc/spawn_effects(turf/select_turf)
	if(!select_turf)
		log_game("Portal Storm gateway event failed to spawn effect due to an invalid location.")
		return
	select_turf = get_step(select_turf, SOUTHWEST) //align center of image with turf
	flick_overlay_static(storm, select_turf, 15)
	playsound(select_turf, 'sound/magic/lightningbolt.ogg', rand(80, 100), TRUE)

/datum/outbound_gateway_event/portal/proc/spawn_the_bads()
	set waitfor = FALSE

	var/list/possible_spawns = list()
	for(var/obj/effect/landmark/outbound/gateway_portal_spawn/landmark_thing in GLOB.landmarks_list)
		possible_spawns += landmark_thing

	for(var/i in 1 to rand(minimum_spawns, maximum_spawns))
		spawn_mob(pick_weight(possible_enemies), possible_spawns)
		sleep(rand(0.5 SECONDS, 1.5 SECONDS))

/datum/outbound_gateway_event/portal/proc/spawn_mob(type, spawn_list)
	if(!type)
		return
	var/turf/spawn_turf = pick_n_take(spawn_list)
	if(!spawn_turf)
		return
	new type(get_turf(spawn_turf))
	spawn_effects(spawn_turf)

/datum/outbound_gateway_event/portal/syndicate
	name = "Portal Storm - Syndicates"
	threat = 60
	possible_enemies = list(
		/mob/living/simple_animal/hostile/syndicate/melee/space = 3,
		/mob/living/simple_animal/hostile/syndicate/ranged/space = 4,
		/mob/living/simple_animal/hostile/syndicate/ranged/smg/space = 3,
		/mob/living/simple_animal/hostile/syndicate/ranged/shotgun/space = 3,
		/mob/living/simple_animal/hostile/syndicate/mecha_pilot = 1,
		/mob/living/simple_animal/hostile/syndicate/space = 3,
	)
	minimum_spawns = 3
	maximum_spawns = 8

/datum/outbound_gateway_event/portal/xenomorph
	name = "Portal Storm - Xenomorphs"
	threat = 40
	possible_enemies = list(
		/mob/living/simple_animal/hostile/alien/drone = 4,
		/mob/living/simple_animal/hostile/alien/sentinel = 3,
		/mob/living/simple_animal/hostile/alien/queen = 1,
		/mob/living/simple_animal/hostile/alien = 3,
	)

/datum/outbound_gateway_event/portal/syndicate/lone_wolf
	name = "Portal Storm - Syndicates (Lone Wolf)"
	threat = 75
	possible_enemies = list(
		/mob/living/simple_animal/hostile/syndicate/melee/space/stormtrooper = 4,
		/mob/living/simple_animal/hostile/syndicate/ranged/space/stormtrooper = 3,
		/mob/living/simple_animal/hostile/syndicate/ranged/smg/space/stormtrooper = 3,
		/mob/living/simple_animal/hostile/syndicate/ranged/shotgun/space/stormtrooper = 3,
		/mob/living/simple_animal/hostile/syndicate/mecha_pilot = 1,
		/mob/living/simple_animal/hostile/syndicate/space/stormtrooper = 4,
		/mob/living/simple_animal/hostile/syndicate/melee/sword/space/stormtrooper = 2,
	)
	minimum_spawns = 8 // this isn't meant to be fair
	maximum_spawns = 12
