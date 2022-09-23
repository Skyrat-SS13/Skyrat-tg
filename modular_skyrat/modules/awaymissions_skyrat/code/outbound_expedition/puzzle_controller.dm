/datum/outbound_puzzle_controller
	/// List of initialized puzzle datums
	var/list/puzzles = list()

	/// List of abstract typed puzzles that shouldn't be spawned
	var/list/abstract_puzzles = list(
		/datum/outbound_teamwork_puzzle,
		/datum/outbound_teamwork_puzzle/continuous,
	)

	// Wire code start
	/// List of active wire conditionals, SHOULD NOT CHANGE ONCE SET
	var/list/wire_conditionals = list()
	/// Weighted list of conditionals
	var/list/possible_conditionals = list(
		/datum/outbound_wire_conditional/act_wires = 2,
		/datum/outbound_wire_conditional/onecolor = 3,
		/datum/outbound_wire_conditional/multicolor = 2,
		///datum/outbound_wire_conditional/multiwire = 2,
		)
	// Wire code end
	// Arguably a puzzle, sensor computer start
	/// If we've scanned this jump
	var/has_scanned = FALSE
	/// If we can scan currently
	var/can_scan = FALSE
	// Sensor computer end


/datum/outbound_puzzle_controller/New()
	. = ..()
	var/list/typesof_puzzle = typesof(/datum/outbound_teamwork_puzzle) - abstract_puzzles
	for(var/puzzle in typesof_puzzle)
		var/datum/outbound_teamwork_puzzle/new_puzzle = new puzzle
		puzzles[new_puzzle.name] = new_puzzle
	addtimer(CALLBACK(src, .proc/set_up_wire_conditionals), 1 SECONDS)
	RegisterSignal(src, COMSIG_AWAY_PUZZLE_COMPLETED, .proc/puzzle_finish)

/datum/outbound_puzzle_controller/proc/puzzle_finish(datum/outbound_puzzle_controller/source, datum/outbound_teamwork_puzzle/puzzle)
	OUTBOUND_CONTROLLER
	var/datum/outbound_random_event/harmful/part_malf/malf_event = outbound_controller.current_event
	if(puzzle in malf_event.broken_systems)
		malf_event.broken_systems -= puzzle
	puzzle.enabled = FALSE
	puzzle.terminal.woop_woop.stop()
	if(length(malf_event.broken_systems))
		return
	for(var/datum/outbound_teamwork_puzzle/continuous/cont_puzzle as anything in malf_event.broken_cont_systems)
		cont_puzzle.enabled = FALSE
		malf_event.broken_cont_systems -= cont_puzzle
		cont_puzzle.terminal.woop_woop.stop()
	outbound_controller.current_event.clear_objective()

/datum/outbound_puzzle_controller/proc/set_up_wire_conditionals()
	var/conditional_amount = rand(1, 12)
	var/compiled_desc = ""
	switch(conditional_amount)
		if(1)
			conditional_amount = 3
		if(2 to 5)
			conditional_amount = 4
		if(6 to 10)
			conditional_amount = 5
		if(11 to 12)
			conditional_amount = 6
	var/list/logic_covered_wires = list()
	for(var/i in 1 to conditional_amount)
		var/conditional = pick_weight(possible_conditionals)
		var/datum/outbound_wire_conditional/wire_cond = new conditional
		var/datum/outbound_teamwork_puzzle/wires/wire_puzzle = puzzles["Wires"]
		wire_cond.conditional_check(wire_puzzle.wires)
		var/passed = FALSE
		while(!passed) //god only knows if ANY of this works
			if(!length(logic_covered_wires))
				passed = TRUE
			for(var/wire as anything in logic_covered_wires)
				if(wire in wire_cond.logic_wires)
					passed = "abort" //making a bool into this, cursed ik
					break
				else
					passed = TRUE
		if(passed == "abort")
			continue
		wire_conditionals += wire_cond
		logic_covered_wires.Insert(0, wire_cond.logic_wires)
		compiled_desc += "[wire_cond.desc]\n" //Maybe \n?
	var/datum/outbound_wire_conditional/act_wires/act_cond = new
	wire_conditionals += act_cond
	compiled_desc += "[act_cond.desc]"
	var/datum/outbound_teamwork_puzzle/wires/wire_puzz = puzzles["Wires"]
	wire_puzz.desc = compiled_desc

/// We succeeded scanning for a signal after the betrayal
/datum/outbound_puzzle_controller/proc/on_computer_scan()
	OUTBOUND_CONTROLLER
	for(var/i in 1 to rand(3, 5))
		outbound_controller.event_order += "random"
	outbound_controller.event_order += /datum/outbound_random_event/story/radar
	outbound_controller.jumps_to_dest = outbound_controller.event_order.Find(/datum/outbound_random_event/story/radar)

/// What happens after a jump is made by the ship
/datum/outbound_puzzle_controller/proc/on_jump()
	has_scanned = FALSE
	var/datum/outbound_teamwork_puzzle/wires/wire_puzzle = puzzles["Wires"]
	wire_puzzle.generate_wires()
	var/datum/outbound_teamwork_puzzle/dials/dial_puzzle = puzzles["Dials"]
	dial_puzzle.choose_phrase()
