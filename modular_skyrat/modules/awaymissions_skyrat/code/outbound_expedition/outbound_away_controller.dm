/datum/away_controller/outbound_expedition
	name = "Away Controller: Outbound Expedition"
	ss_delay = 10 SECONDS
	/// List of mobs hooked up to the away mission
	var/list/participating_mobs = list()
	/// List of systems on the ship, destroyed ones still stay in the list
	var/list/ship_systems = list()
	/// Reference to the puzzle controller
	var/datum/outbound_puzzle_controller/puzzle_controller
	/// If we've processed the available terminal landmarks before
	var/landmarks_checked = FALSE

/datum/away_controller/outbound_expedition/New()
	. = ..()
	for(var/ship_sys in subtypesof(/datum/outbound_ship_system))
		var/datum/outbound_ship_system/new_system = new ship_sys
		ship_systems[new_system.name] = new_system
	puzzle_controller = new

/datum/away_controller/outbound_expedition/Destroy(force, ...)
	for(var/datum/system as anything in ship_systems)
		system = ship_systems[system]
		QDEL_NULL(system)
	if(puzzle_controller)
		QDEL_NULL(puzzle_controller)
	return ..()

/datum/away_controller/outbound_expedition/fire()
	if(!landmarks_checked)
		var/list/landmark_list = list()
		for(var/obj/effect/landmark/puzzle_terminal_spawn/terminal in GLOB.landmarks_list)
			landmark_list |= terminal

		for(var/puzzle_name in puzzle_controller.puzzles)
			var/datum/outbound_teamwork_puzzle/puzzle_datum = puzzle_controller.puzzles[puzzle_name]
			var/obj/landmark = pick_n_take(landmark_list)
			var/obj/machinery/outbound_expedition/puzzle_terminal/term = new (get_turf(landmark))
			qdel(landmark)
			term.puzzle_datum = puzzle_datum
			term.tgui_id = puzzle_datum.tgui_name
			term.name = puzzle_datum.terminal_name
			term.desc = puzzle_datum.terminal_desc
			puzzle_datum.terminal = term

		for(var/obj/landmark as anything in landmark_list)
			qdel(landmark)

	for(var/datum/outbound_teamwork_puzzle/continuous/cont_puzzle in puzzle_controller.puzzles)
		cont_puzzle.puzzle_process()

// Objective procs

/datum/away_controller/outbound_expedition/proc/clear_objective(mob/living/person_cleared)
	person_cleared?.hud_used?.away_dialogue.clear_text()
	var/datum/status_effect/pinpointer = person_cleared.has_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	qdel(pinpointer)

/datum/away_controller/outbound_expedition/proc/objective_pinpoint(mob/living/person_to_point, atom/point_to)
	if(!point_to)
		person_to_point.balloon_alert(person_to_point, "no objective!")
		return
	var/datum/status_effect/agent_pinpointer/away_objective/away_pinpointer = person_to_point.apply_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	away_pinpointer.scan_target = point_to

// Event stuff

/datum/away_controller/outbound_expedition/proc/select_event()
	return //make sure for wires to regen everything
