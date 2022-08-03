/datum/outbound_random_event/mob_harmful/scrappers
	name = "Autonomous Scrappers"
	weight = 3

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
