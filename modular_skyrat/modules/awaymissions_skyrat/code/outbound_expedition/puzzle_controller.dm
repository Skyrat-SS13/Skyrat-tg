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


/datum/outbound_puzzle_controller/New()
	. = ..()
	var/list/typesof_puzzle = typesof(/datum/outbound_teamwork_puzzle) - abstract_puzzles
	for(var/puzzle in typesof_puzzle)
		var/datum/outbound_teamwork_puzzle/new_puzzle = new puzzle
		puzzles[new_puzzle.name] = new_puzzle
	addtimer(CALLBACK(src, .proc/set_up_wire_conditionals), 1 SECONDS)
	//set_up_wire_conditionals()

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
		var/wire_cond_iter = 0
		while(!passed) //god only knows if ANY of this works
			if(!length(logic_covered_wires))
				passed = TRUE
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
		logic_covered_wires.Insert(0, wire_cond.logic_wires)
		compiled_desc += "[wire_cond.desc]\n" //Maybe \n?
	var/datum/outbound_teamwork_puzzle/wires/wire_puzz = puzzles["Wires"]
	wire_puzz.desc = compiled_desc
