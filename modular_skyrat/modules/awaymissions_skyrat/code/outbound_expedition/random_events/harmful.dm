/datum/outbound_random_event/harmful/meteor
	name = "Meteorite"
	weight = 4

/datum/outbound_random_event/harmful/meteor/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/clear_objective), 2 MINUTES)
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
	addtimer(CALLBACK(src, .proc/clear_objective), 2 MINUTES)
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmful/meteor_storm/clear_objective()
	OUTBOUND_CONTROLLER
	for(var/i in 1 to rand(meteor_lower, meteor_upper))
		outbound_controller.spawn_meteor()
	addtimer(CALLBACK(outbound_controller, /datum/away_controller/outbound_expedition.proc/give_objective_all, outbound_controller.objectives[/datum/outbound_objective/cryo]), 30 SECONDS)
	outbound_controller.current_event = null

/datum/outbound_random_event/harmful/dust_storm
	name = "Dust Storm"
	weight = 8
	/// Lower amount of dust that can spawn
	var/dust_lower = 4
	/// Upper amount of dust that can spawn
	var/dust_upper = 6

/datum/outbound_random_event/harmful/dust_storm/on_select()
	OUTBOUND_CONTROLLER
	addtimer(CALLBACK(src, .proc/clear_objective), 2 MINUTES)
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/wait])

/datum/outbound_random_event/harmful/dust_storm/clear_objective()
	OUTBOUND_CONTROLLER
	for(var/i in 1 to rand(dust_lower, dust_upper))
		outbound_controller.spawn_meteor(list(/obj/effect/meteor/dust = 1))
	addtimer(CALLBACK(outbound_controller, /datum/away_controller/outbound_expedition.proc/give_objective_all, outbound_controller.objectives[/datum/outbound_objective/cryo]), 30 SECONDS)
	outbound_controller.current_event = null

/datum/outbound_random_event/harmful/part_malf
	name = "Part Malfunction"
	weight = 16
	/// Currently problematic systems
	var/list/broken_systems = list()
	/// Currently problematic continuous systems
	var/list/broken_cont_systems = list()

/datum/outbound_random_event/harmful/part_malf/on_select()
	OUTBOUND_CONTROLLER
	var/datum/outbound_teamwork_puzzle/wires/wire_puzzle = outbound_controller.puzzle_controller.puzzles["Wires"]
	wire_puzzle.generate_wires()
	var/datum/outbound_teamwork_puzzle/dials/dial_puzzle = outbound_controller.puzzle_controller.puzzles["Dials"]
	dial_puzzle.choose_phrase() //maybe refactor these into the controller or smth? Seems unsustainable currently
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
