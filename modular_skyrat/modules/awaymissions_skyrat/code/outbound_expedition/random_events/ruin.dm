/datum/outbound_random_event/ruin/salvage
	name = "Drifting Salvage"
	weight = 1
	/// Map templates that can appear
	var/list/possible_templates = list(
		/datum/map_template/ruin/outbound_expedition/prison_shuttle,
		/datum/map_template/ruin/outbound_expedition/survival_bunker,
		/datum/map_template/ruin/outbound_expedition/clock_cult,
		/datum/map_template/ruin/outbound_expedition/blood_cult,
		/datum/map_template/ruin/outbound_expedition/holdout_ai,
		/datum/map_template/ruin/outbound_expedition/syndicate_frigate,
		/datum/map_template/ruin/outbound_expedition/old_shipyard,
		/datum/map_template/ruin/outbound_expedition/reviver_facility,
		/datum/map_template/ruin/outbound_expedition/firestorm,
	)
	/// Map templates that haven't appeared yet
	var/list/unappeared_templates = list()

/datum/outbound_random_event/ruin/salvage/on_select()
	OUTBOUND_CONTROLLER
	var/list/debris_points = list()
	for(var/obj/effect/landmark/outbound/debris_loc/debris_point in GLOB.landmarks_list)
		debris_points += debris_point
	var/obj/effect/landmark/outbound/debris_loc/chosen_point = pick(debris_points)
	if(!length(unappeared_templates))
		unappeared_templates = possible_templates.Copy()
	var/datum/map_template/chosen_template = pick_n_take(unappeared_templates)
	chosen_template = new chosen_template
	chosen_template.load(get_turf(chosen_point), centered = TRUE)

	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])

/datum/outbound_random_event/ruin/salvage/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo/salvage])

/datum/outbound_random_event/ruin/salvage/on_radio()
	clear_objective()

/datum/outbound_random_event/ruin/salvage/interdiction
	name = "Drifting Interdiction"
	possible_templates = list(
		/datum/map_template/ruin/outbound_expedition/prison_shuttle,
		/datum/map_template/ruin/outbound_expedition/survival_bunker,
		/datum/map_template/ruin/outbound_expedition/clock_cult,
		/datum/map_template/ruin/outbound_expedition/blood_cult,
		/datum/map_template/ruin/outbound_expedition/holdout_ai,
		// Syndicate frigate removed: too dangerous
		/datum/map_template/ruin/outbound_expedition/old_shipyard,
		// Reviver facility removed: unneeded in here and salvage, already guaranteed once
		/datum/map_template/ruin/outbound_expedition/firestorm,
	)

/datum/outbound_random_event/ruin/salvage/interdiction/on_select()
	OUTBOUND_CONTROLLER
	. = ..()
	for(var/obj/effect/landmark/outbound/ruin_shuttle_interdictor/interdiction_point in GLOB.landmarks_list)
		new /obj/machinery/outbound_expedition/shuttle_interdictor(get_turf(interdiction_point))
		break
	RegisterSignal(outbound_controller, COMSIG_AWAY_INTERDICTOR_DECONSTRUCTED, .proc/clear_objective)

/datum/outbound_random_event/ruin/salvage/interdiction/on_radio()
	return

// A ruin that is guaranteed to happen, but not a story mission
/datum/outbound_random_event/ruin/guaranteed
	name = "Guaranteed Ruin"
	/// Path of the guaranteed template
	var/template_path
	/// Has an interdictor
	var/has_interdictor = FALSE

/datum/outbound_random_event/ruin/guaranteed/on_select()
	OUTBOUND_CONTROLLER
	var/list/debris_points = list()
	for(var/obj/effect/landmark/outbound/debris_loc/debris_point in GLOB.landmarks_list)
		debris_points += debris_point
	var/obj/effect/landmark/outbound/debris_loc/chosen_point = pick(debris_points)
	var/datum/map_template/chosen_template = new template_path
	chosen_template.load(get_turf(chosen_point), centered = TRUE)

	for(var/mob/living/carbon/human/listener as anything in outbound_controller.participating_mobs)
		to_chat(listener, span_notice("<i>You hear a faint, static crackling noise come from the bridge.</i>"))
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/radio_listen])
	if(has_interdictor)
		for(var/obj/effect/landmark/outbound/ruin_shuttle_interdictor/interdiction_point in GLOB.landmarks_list)
			new /obj/machinery/outbound_expedition/shuttle_interdictor(get_turf(interdiction_point))
			break
		RegisterSignal(outbound_controller, COMSIG_AWAY_INTERDICTOR_DECONSTRUCTED, .proc/clear_objective)

/datum/outbound_random_event/ruin/guaranteed/clear_objective()
	OUTBOUND_CONTROLLER
	outbound_controller.current_event = null
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo/salvage])

/datum/outbound_random_event/ruin/guaranteed/on_radio()
	if(!has_interdictor)
		clear_objective()

// Hey, they may need it
/datum/outbound_random_event/ruin/guaranteed/reviver
	name = "Guaranteed Ruin (Reviver Facility)"
	template_path = /datum/map_template/ruin/outbound_expedition/reviver_facility
