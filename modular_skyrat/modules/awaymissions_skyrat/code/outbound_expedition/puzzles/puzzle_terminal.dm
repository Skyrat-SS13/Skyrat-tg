/obj/machinery/outbound_expedition/puzzle_terminal
	name = "generic terminal"
	desc = "Uhh"
	icon_state = "telescreen" //placeholder
	//icon_state = "" //figure out later when I can get some sprites
	/// The puzzle datum this is referencing
	var/datum/outbound_teamwork_puzzle/puzzle_datum
	/// Looping warning klaxon (might move off terminal later)
	var/datum/looping_sound/klaxon/woop_woop

/obj/machinery/outbound_expedition/puzzle_terminal/Initialize(mapload)
	. = ..()
	woop_woop = new(src)

/obj/machinery/outbound_expedition/puzzle_terminal/Destroy()
	OUTBOUND_CONTROLLER
	if(puzzle_datum)
		outbound_controller.puzzle_controller.puzzles -= puzzle_datum
		QDEL_NULL(puzzle_datum)
	return ..()

/obj/machinery/outbound_expedition/puzzle_terminal/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id, name)
		ui.open()

/obj/machinery/outbound_expedition/puzzle_terminal/ui_data(mob/user)
	return puzzle_datum?.ui_data(user)

/obj/machinery/outbound_expedition/puzzle_terminal/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	return puzzle_datum?.ui_act(action, params)

/obj/machinery/outbound_expedition/puzzle_terminal/attack_hand(mob/living/user, list/modifiers)
	OUTBOUND_CONTROLLER
	if(!istype(outbound_controller.current_event, /datum/outbound_random_event/harmful/part_malf))
		to_chat(user, span_warning("You don't feel the need to open this yet."))
		return
	return ..()

/obj/effect/landmark/puzzle_terminal_spawn //Placed on the shuttle, once the controller inits it replaces these
	name = "terminalspawn"

// Fills the "two player" component of certain puzzles by giving the answers
/obj/machinery/computer/puzzle_answers
	name = "digitized instruction manual"
	desc = "A computer containing an instruction manual for repair of onboard systems."
	tgui_id = "OutboundPuzzleAnswer"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	max_integrity = INFINITY

/obj/machinery/computer/puzzle_answers/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id, name)
		ui.open()

/obj/machinery/computer/puzzle_answers/ui_static_data(mob/user)
	OUTBOUND_CONTROLLER
	var/list/data = list()
	var/list/payload = list()
	for(var/puzzle_name in outbound_controller.puzzle_controller.puzzles)
		var/datum/outbound_teamwork_puzzle/puzzle = outbound_controller.puzzle_controller.puzzles[puzzle_name]
		payload.Add(list(list(
			"puzzname" = puzzle_name,
			"desc" = puzzle.desc,
		)))
	data["all_puzzles"] = payload
	return data

