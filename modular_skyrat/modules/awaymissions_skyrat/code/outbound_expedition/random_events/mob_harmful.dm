/datum/outbound_random_event/mob_harmful/scrappers
	name = "Autonomous Scrappers"
	weight = 2

/datum/outbound_random_event/mob_harmful/scrappers/on_select()
	OUTBOUND_CONTROLLER
	var/list/debris_points = list()
	addtimer(CALLBACK(src, .proc/summon_da_bot), 30 SECONDS)
	for(var/obj/effect/landmark/outbound/debris_loc/debris_point in GLOB.landmarks_list)
		debris_points += debris_point
	var/obj/effect/landmark/outbound/debris_loc/chosen_point = pick(debris_points)
	var/datum/map_template/chosen_template = new /datum/map_template/ruin/outbound_expedition/scrapper_zone
	chosen_template.load(get_turf(chosen_point), centered = TRUE)

	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])

/datum/outbound_random_event/mob_harmful/scrappers/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo])

/datum/outbound_random_event/mob_harmful/scrappers/proc/summon_da_bot()
	for(var/obj/effect/landmark/outbound/scrapper_evac_point/scrap_point in GLOB.landmarks_list)
		var/mob/living/simple_animal/hostile/auto_scrapper/new_drone = new (get_turf(scrap_point))
		RegisterSignal(new_drone, COMSIG_LIVING_DEATH, .proc/clear_objective)
		// add break if you only ever create one later

/datum/outbound_random_event/mob_harmful/raiders
	name = "Raiders"
	weight = 1

/datum/outbound_random_event/mob_harmful/raiders/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/radio), 1 MINUTES)
	var/list/debris_points = list()
	for(var/obj/effect/landmark/outbound/debris_loc/debris_point in GLOB.landmarks_list)
		debris_points += debris_point
	var/obj/effect/landmark/outbound/debris_loc/chosen_point = pick(debris_points)
	var/datum/map_template/chosen_template = new /datum/map_template/ruin/outbound_expedition/raider_shuttle
	chosen_template.load(get_turf(chosen_point), centered = TRUE)

	var/list/landmarks = list()
	for(var/obj/effect/landmark/outbound/raider_spawn/spawn_loc in GLOB.landmarks_list)
		landmarks += spawn_loc

	var/list/candidates = poll_ghost_candidates("Do you wish to play as part of a Raider Team?", ROLE_SYNDICATE, FALSE, 10 SECONDS)
	for(var/mob/dead/observer/person as anything in candidates)
		if(!length(landmarks))
			return
		var/mob/living/carbon/human/raider = new(get_turf(pick_n_take(landmarks)))
		raider.key = person.key
		raider.client?.init_verbs()
		if(!raider.mind)
			raider.mind_initialize()
		raider.equipOutfit(/datum/outfit/raider) // make one of them a leader or smth later
		to_chat(raider, span_notice("You are a raider. You have the goal to raid and hijack the ship you've found and interdicted.")) // add what happens if they actually do it later
		outbound_controller.give_objective(raider, outbound_controller.objectives[/datum/outbound_objective/raid_ship])

	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/mob_harmful/raiders/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null

/datum/outbound_random_event/mob_harmful/raiders/proc/radio() //remove later?
	OUTBOUND_CONTROLLER
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))

/datum/outbound_random_event/mob_harmful/resonance_cascade
	name = "Resonance Cascade: Black Mesa"
	weight = 2
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
	var/minimum_spawns = 4
	/// Upper bound for possible amount of enemies
	var/maximum_spawns = 8

/datum/outbound_random_event/mob_harmful/resonance_cascade/on_select()
	OUTBOUND_CONTROLLER

	storm = mutable_appearance('icons/obj/tesla_engine/energy_ball.dmi', "energy_ball_fast", FLY_LAYER)
	storm.plane = ABOVE_GAME_PLANE
	storm.color = "#00FF00"

	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		cause_the_cascade(listener)

	spawn_the_bads()
	clear_objective()

/datum/outbound_random_event/mob_harmful/resonance_cascade/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo/resonance_cascade])

/datum/outbound_random_event/mob_harmful/resonance_cascade/proc/cause_the_cascade(mob/living/carbon/human/listener)
	set waitfor = FALSE

	listener.playsound_local(get_turf(listener), 'sound/magic/lightning_chargeup.ogg')
	sleep(10 SECONDS)
	listener.playsound_local(get_turf(listener), 'sound/magic/lightningbolt.ogg')


/datum/outbound_random_event/mob_harmful/resonance_cascade/proc/spawn_effects(turf/select_turf)
	if(!select_turf)
		log_game("Portal Storm failed to spawn effect due to an invalid location.")
		return
	select_turf = get_step(select_turf, SOUTHWEST) //align center of image with turf
	flick_overlay_static(storm, select_turf, 15)
	playsound(select_turf, 'sound/magic/lightningbolt.ogg', rand(80, 100), TRUE)

/datum/outbound_random_event/mob_harmful/resonance_cascade/proc/spawn_the_bads()
	set waitfor = FALSE

	var/list/possible_turfs = list()
	var/area/our_area = GLOB.areas_by_type[/area/awaymission/outbound_expedition/shuttle]
	for(var/turf/open/floor_tile in our_area.contents)
		var/has_dense = FALSE
		for(var/obj/content_object in floor_tile.contents)
			if(content_object.density)
				has_dense = TRUE
				break
		if(has_dense)
			continue
		possible_turfs += floor_tile
	for(var/i in 1 to rand(minimum_spawns, maximum_spawns))
		spawn_mob(pick_weight(possible_enemies), possible_turfs)
		sleep(rand(1 SECONDS, 2.5 SECONDS))

/datum/outbound_random_event/mob_harmful/resonance_cascade/proc/spawn_mob(type, spawn_list)
	if(!type)
		return
	var/turf/spawn_turf = pick_n_take(spawn_list)
	if(!spawn_turf)
		return
	new type(spawn_turf)
	spawn_effects(spawn_turf)

/datum/outbound_random_event/mob_harmful/resonance_cascade/xeno
	name = "Resonance Cascade: Xenomorphs"
	possible_enemies = list(
		/mob/living/simple_animal/hostile/alien/drone = 4,
		/mob/living/simple_animal/hostile/alien/sentinel = 3,
		/mob/living/simple_animal/hostile/alien/queen = 1,
		/mob/living/simple_animal/hostile/alien = 3,
		)
	minimum_spawns = 3
	maximum_spawns = 7
