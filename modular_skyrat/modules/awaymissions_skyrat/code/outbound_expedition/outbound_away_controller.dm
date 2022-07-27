/datum/away_controller/outbound_expedition
	name = "Away Controller: Outbound Expedition"
	ss_delay = 10 SECONDS
	/// Assoc list of mobs hooked up to the away mission, mob:objective datum
	var/list/participating_mobs = list()
	/// List of systems on the ship, destroyed ones still stay in the list
	var/list/ship_systems = list()
	/// Reference to the puzzle controller
	var/datum/outbound_puzzle_controller/puzzle_controller
	/// If we've processed the available terminal landmarks before
	var/landmarks_checked = FALSE
	/// List of initialized event datums
	var/list/event_datums = list()
	/// What event are we currently in? Any event will block the shuttle from moving until it's resolved
	var/datum/outbound_random_event/current_event
	/// How many jumps to our destination (not always accurate)
	var/jumps_to_dest = 0
	/// Assoc list of machine-to-datum for ship systems
	var/list/machine_datums = list()
	/// Time until the elevator hits the bottom, locking anyone else from entering
	var/elevator_time = 5 MINUTES
	/// List of elevator doors
	var/list/elevator_doors = list()
	/// Assoc list of initialized objective datums, type:datum
	var/list/objectives = list()

/datum/away_controller/outbound_expedition/New()
	. = ..()
	for(var/ship_sys in subtypesof(/datum/outbound_ship_system))
		var/datum/outbound_ship_system/new_system = new ship_sys
		ship_systems[new_system.name] = new_system
	for(var/type in subtypesof(/datum/outbound_random_event))
		var/datum/new_type = new type
		event_datums += new_type
	puzzle_controller = new /datum/outbound_puzzle_controller
	for(var/obj/machinery/machine_piece as anything in GLOB.outbound_ship_systems)
		for(var/ship_system in ship_systems)
			var/datum/outbound_ship_system/system_datum = ship_systems[ship_system]
			if(istype(machine_piece, system_datum.machine_type))
				machine_datums[machine_piece] = system_datum
				break
		RegisterSignal(machine_piece, COMSIG_ATOM_TAKE_DAMAGE, .proc/on_sys_damage)
	for(var/objective_type in subtypesof(/datum/outbound_objective))
		var/datum/new_objective = new objective_type
		objectives[objective_type] = new_objective
	RegisterSignal(src, COMSIG_AWAY_CRYOPOD_EXITED, .proc/exited_cryopod)
	RegisterSignal(src, COMSIG_AWAY_CRYOPOD_ENTERED, .proc/entered_cryopod)

/datum/away_controller/outbound_expedition/Destroy(force, ...)
	for(var/datum/system as anything in ship_systems)
		system = ship_systems[system]
		QDEL_NULL(system)
	if(puzzle_controller)
		QDEL_NULL(puzzle_controller)
	return ..()

/datum/away_controller/outbound_expedition/fire()
	if(!landmarks_checked)
		landmark_check()
	for(var/puzzle in puzzle_controller.puzzles)
		var/datum/outbound_teamwork_puzzle/continuous/cont_puzzle = puzzle_controller.puzzles[puzzle]
		if(!istype(cont_puzzle, /datum/outbound_teamwork_puzzle/continuous))
			continue
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

/datum/away_controller/outbound_expedition/proc/give_objective(mob/living/person_chosen, datum/outbound_objective/chosen_objective)
	var/obj/effect/landmark/away_objective/corresponding_landmark = GLOB.outbound_objective_landmarks[chosen_objective.landmark_id]
	objective_pinpoint(person_chosen, corresponding_landmark)
	person_chosen?.hud_used?.away_dialogue.set_text(chosen_objective.desc)

// Event stuff

/datum/away_controller/outbound_expedition/proc/select_event()
	return //make sure for wires to regen everything



// Landmark check

/datum/away_controller/outbound_expedition/proc/landmark_check()
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
	landmarks_checked = TRUE

// System code

/datum/away_controller/outbound_expedition/proc/on_sys_damage(datum/source, damage_amount, damage_type, damage_flag, sound_effect, attack_dir, aurmor_penetration)
	SIGNAL_HANDLER
	// code is probably bad and can be improved
	for(var/obj/machinery/ship_system as anything in machine_datums)
		if(!(source == ship_system))
			continue
		var/datum/outbound_ship_system/system_datum = machine_datums[source]
		system_datum.adjust_health(-damage_amount)
		break

// """Moving""" the ship

/datum/away_controller/outbound_expedition/proc/move_shuttle(list/affected_areas)
	for(var/area/affected_area as anything in affected_areas)
		for(var/atom/to_delete as obj|mob|turf in affected_area)
			qdel(to_delete) // probably a crime but what can you do
		qdel(affected_area)

/datum/away_controller/outbound_expedition/proc/tick_elevator_time()
	elevator_time -= 1 SECONDS
	if(elevator_time > 1 SECONDS)
		addtimer(CALLBACK(src, .proc/tick_elevator_time), 1 SECONDS)
	else
		for(var/obj/machinery/door/poddoor/shutters/indestructible/shutter in elevator_doors)
			shutter.open()

// Cryopod procs

/datum/away_controller/outbound_expedition/proc/entered_cryopod(datum/source, mob/living/living_mob)
	SIGNAL_HANDLER

/datum/away_controller/outbound_expedition/proc/exited_cryopod(datum/source, mob/living/living_mob)
	SIGNAL_HANDLER
