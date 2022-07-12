/datum/outbound_puzzle_controller
	/// List of initialized puzzle datums
	var/list/puzzles = list()

	// Wire code start
	/// List of active wire conditionals, SHOULD NOT CHANGE ONCE SET
	var/list/wire_conditionals = list()
	/// Weighted list of conditionals
	var/list/possible_conditionals = list(
		/datum/outbound_wire_conditional/evenorodd = 3,
		/datum/outbound_wire_conditional/onecolor = 3,
		/datum/outbound_wire_conditional/multicolor = 2,
		/datum/outbound_wire_conditional/multiwire = 2,
		)
	/// Weighted list of conditional amounts
	var/list/conditional_amount_possible = list(
		3 = 1,
		4 = 4,
		5 = 5,
		6 = 2,
	)
	// Wire code end


/datum/outbound_puzzle_controller/New()
	. = ..()
	for(var/puzzle in subtypesof(/datum/outbound_teamwork_puzzle))
		var/datum/outbound_teamwork_puzzle/new_puzzle = new puzzle
		puzzles[new_puzzle.name] = new_puzzle
	set_up_wire_conditionals()

/datum/outbound_puzzle_controller/proc/set_up_wire_conditionals()
	var/condition_amount = pick_weight(conditional_amount_possible)
	var/list/logic_covered_wires = list()
	for(var/i in 1 to condition_amount)
		var/datum/outbound_wire_conditional/wire_cond = new pick_weight(possible_conditionals)
		var/passed = FALSE
		var/wire_cond_iter = 0
		while(!passed) //god only knows if ANY of this works
			if(wire_cond_iter > 10)
				stack_trace("[src] couldn't make enough conditions and panic stopped!")
				break //should work?
			for(var/wire as anything in logic_covered_wires)
				if(wire in wire_cond.logic_wires)
					wire_cond.set_up_condition()
					wire_cond_iter++
				else
					wire_cond_iter = 0
					passed = TRUE
		wire_conditionals += wire_cond
		logic_covered_wires.Insert(1, wire_cond.logic_wires)
