#define DEFAULT_RAIDER_AMOUNT 3

/datum/outbound_random_event/harmful/meteor
	name = "Meteorite"
	weight = 4

/datum/outbound_random_event/harmful/meteor/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/clear_objective), 45 SECONDS)
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmful/meteor/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.spawn_meteor()
	addtimer(CALLBACK(outbound_controller, /datum/away_controller/outbound_expedition.proc/give_objective_all, outbound_controller.objectives[/datum/outbound_objective/cryo]), 30 SECONDS)
	outbound_controller.current_event = null

/datum/outbound_random_event/harmful/meteor_storm // God really has it out for whoever rolls this
	name = "Meteorite Storm"
	weight = 1
	/// Lower amount of meteors that can spawn
	var/meteor_lower = 5
	/// Upper amount of meteors that can spawn
	var/meteor_upper = 8

/datum/outbound_random_event/harmful/meteor_storm/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/clear_objective), 1 MINUTES)
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmful/meteor_storm/clear_objective()
	OUTBOUND_CONTROLLER
	for(var/i in 1 to rand(meteor_lower, meteor_upper))
		outbound_controller.spawn_meteor()
	addtimer(CALLBACK(outbound_controller, /datum/away_controller/outbound_expedition.proc/give_objective_all, outbound_controller.objectives[/datum/outbound_objective/cryo]), 30 SECONDS)
	outbound_controller.current_event = null

/datum/outbound_random_event/harmful/dust_storm
	name = "Dust Storm"
	weight = 7
	/// Lower amount of dust that can spawn
	var/dust_lower = 8
	/// Upper amount of dust that can spawn
	var/dust_upper = 10

/datum/outbound_random_event/harmful/dust_storm/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/clear_objective), 30 SECONDS)
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmful/dust_storm/clear_objective()
	OUTBOUND_CONTROLLER
	for(var/i in 1 to rand(dust_lower, dust_upper))
		outbound_controller.spawn_meteor(list(/obj/effect/meteor/dust = 1))
	addtimer(CALLBACK(outbound_controller, /datum/away_controller/outbound_expedition.proc/give_objective_all, outbound_controller.objectives[/datum/outbound_objective/cryo]), 30 SECONDS)
	outbound_controller.current_event = null

/datum/outbound_random_event/harmful/part_malf
	name = "Part Malfunction"
	weight = 12
	/// Currently problematic systems
	var/list/broken_systems = list()
	/// Currently problematic continuous systems
	var/list/broken_cont_systems = list()

/datum/outbound_random_event/harmful/part_malf/on_select()
	OUTBOUND_CONTROLLER
	var/list/possible_systems = outbound_controller.puzzle_controller.puzzles.Copy()
	for(var/i in 1 to 3) //change later to be scaling
		var/datum/outbound_teamwork_puzzle/puzzle = pick_n_take(possible_systems)
		puzzle = outbound_controller.puzzle_controller.puzzles[puzzle]
		puzzle.enabled = TRUE
		puzzle.terminal.woop_woop.start()
		if(istype(puzzle, /datum/outbound_teamwork_puzzle/continuous))
			broken_cont_systems += puzzle
		else
			broken_systems += puzzle
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/part_fix])

/datum/outbound_random_event/harmful/part_malf/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo])
	outbound_controller.current_event = null

/datum/outbound_random_event/harmful/raiders
	name = "Raiders"
	weight = 6

/datum/outbound_random_event/harmful/raiders/on_select()
	OUTBOUND_CONTROLLER

	var/list/candidates = poll_ghost_candidates("Do you wish to play as part of a Raider Team?", ROLE_SYNDICATE, FALSE, 10 SECONDS)

	if(!length(candidates))
		addtimer(CALLBACK(src, .proc/clear_objective), 1 MINUTES)
		return //bwomp

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

	var/made_leader = FALSE
	var/amount_to_spawn = round(outbound_controller.calculate_difficulty() * DEFAULT_RAIDER_AMOUNT)
	for(var/mob/dead/observer/person as anything in candidates)
		if(!amount_to_spawn)
			break
		amount_to_spawn--
		if(!length(landmarks))
			break
		var/mob/living/carbon/human/raider = new(get_turf(pick(landmarks)))
		raider.key = person.key
		raider.client?.init_verbs()
		if(!raider.mind)
			raider.mind_initialize()
		if(!made_leader)
			raider.equipOutfit(/datum/outfit/raider/leader)
			made_leader = TRUE
		else
			raider.equipOutfit(/datum/outfit/raider) // make one of them a leader or smth later
		to_chat(raider, span_notice("You are a raider. You have the goal to raid and hijack the ship you've found and interdicted.")) // add what happens if they actually do it later
		outbound_controller.give_objective(raider, outbound_controller.objectives[/datum/outbound_objective/raid_ship])

	addtimer(CALLBACK(src, .proc/clear_objective), 6 MINUTES) //ballpark time
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmful/raiders/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo])
	outbound_controller.current_event = null

/datum/outbound_random_event/harmful/raiders/proc/radio() //remove later?
	OUTBOUND_CONTROLLER
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))

/datum/outbound_random_event/harmful/resonance_cascade
	name = "Resonance Cascade: Black Mesa"
	weight = 8
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

/datum/outbound_random_event/harmful/resonance_cascade/on_select()
	OUTBOUND_CONTROLLER

	storm = mutable_appearance('icons/obj/engine/energy_ball.dmi', "energy_ball_fast", FLY_LAYER)
	storm.plane = ABOVE_GAME_PLANE
	storm.color = "#00FF00"

	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		cause_the_cascade(listener)

	spawn_the_bads()
	clear_objective()

/datum/outbound_random_event/harmful/resonance_cascade/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo/resonance_cascade])

/datum/outbound_random_event/harmful/resonance_cascade/proc/cause_the_cascade(mob/living/carbon/human/listener)
	set waitfor = FALSE

	listener.playsound_local(get_turf(listener), 'sound/magic/lightning_chargeup.ogg')
	sleep(10 SECONDS)
	listener.playsound_local(get_turf(listener), 'sound/magic/lightningbolt.ogg')


/datum/outbound_random_event/harmful/resonance_cascade/proc/spawn_effects(turf/select_turf)
	if(!select_turf)
		log_game("Portal Storm failed to spawn effect due to an invalid location.")
		return
	select_turf = get_step(select_turf, SOUTHWEST) //align center of image with turf
	flick_overlay_static(storm, select_turf, 15)
	playsound(select_turf, 'sound/magic/lightningbolt.ogg', rand(80, 100), TRUE)

/datum/outbound_random_event/harmful/resonance_cascade/proc/spawn_the_bads()
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

/datum/outbound_random_event/harmful/resonance_cascade/proc/spawn_mob(type, spawn_list)
	if(!type)
		return
	var/turf/spawn_turf = pick_n_take(spawn_list)
	if(!spawn_turf)
		return
	new type(spawn_turf)
	spawn_effects(spawn_turf)

/datum/outbound_random_event/harmful/resonance_cascade/xeno
	name = "Resonance Cascade: Xenomorphs"
	possible_enemies = list(
		/mob/living/simple_animal/hostile/alien/drone = 4,
		/mob/living/simple_animal/hostile/alien/sentinel = 3,
		/mob/living/simple_animal/hostile/alien/queen = 1,
		/mob/living/simple_animal/hostile/alien = 3,
		/obj/item/clothing/mask/facehugger = 2, //hehehe
		)
	minimum_spawns = 3
	maximum_spawns = 7

#undef DEFAULT_RAIDER_AMOUNT
