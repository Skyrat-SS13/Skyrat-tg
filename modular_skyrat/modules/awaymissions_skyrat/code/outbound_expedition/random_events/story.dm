/datum/outbound_random_event/story/betrayal
	name = "The Betrayal"
	printout_title = "goodbye"
	printout_strings = list(
		"INCOMING RECORDED AUDIO MESSAGE.",
		"Congratulations on going beyond the halfway point on your journey.",
		"Unfortunately, this won't be one you're coming back from.",
		"Your sensors and long-range communications back to the outpost have been disabled,",
		"you won't be able to navigate back.",
		"With this tragic loss of explorers to the void,",
		"I think the government may finally give us proper funding.",
	)

/datum/outbound_random_event/story/betrayal/on_select()
	OUTBOUND_CONTROLLER
	outbound_controller.current_stage = 2 // I should really make the defines for this global
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])
	outbound_controller.jumps_to_dest = -1

/datum/outbound_random_event/story/betrayal/on_radio()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo/betrayal])
	outbound_controller.puzzle_controller.can_scan = TRUE

/datum/outbound_random_event/story/radar
	name = "Stray Radar Station"
	printout_title = "sensor_readout"
	printout_strings = list(
		"Deep-space telescope-radar located near the ship.",
		"Proceed to secure the data onboard.",
	)

/datum/outbound_random_event/story/radar/on_select()
	OUTBOUND_CONTROLLER
	outbound_controller.current_stage = 3 // I should really make the defines for this global
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])

	var/list/debris_points = list()
	for(var/obj/effect/landmark/outbound/debris_loc/debris_point in GLOB.landmarks_list)
		debris_points += debris_point
	var/obj/effect/landmark/outbound/debris_loc/chosen_point = pick(debris_points)
	var/datum/map_template/chosen_template = new /datum/map_template/ruin/outbound_expedition/radar_station
	chosen_template.load(get_turf(chosen_point), centered = TRUE)

/datum/outbound_random_event/story/radar/on_radio()
	OUTBOUND_CONTROLLER
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radar_station])

/datum/outbound_random_event/story/the_end
	name = "The Last Stand"
	printout_title = "sensor readout"
	printout_strings = list(
		"High energy signature located nearby the corvette.",
		"Proceed to the signature.",
	)

/datum/outbound_random_event/story/the_end/on_select()
	OUTBOUND_CONTROLLER
	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])

	var/list/debris_points = list()
	for(var/obj/effect/landmark/outbound/debris_loc/debris_point in GLOB.landmarks_list)
		debris_points += debris_point
	var/obj/effect/landmark/outbound/debris_loc/chosen_point = pick(debris_points)
	var/datum/map_template/chosen_template = new /datum/map_template/ruin/outbound_expedition/gateway_finale
	chosen_template.load(get_turf(chosen_point), centered = TRUE)
