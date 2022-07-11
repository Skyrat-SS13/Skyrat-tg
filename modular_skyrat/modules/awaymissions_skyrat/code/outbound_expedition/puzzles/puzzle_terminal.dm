/obj/machinery/outbound_puzzle_terminal
	name = "generic terminal"
	desc = "Uhh"
	icon_state = "telescreen" //placeholder
	//icon_state = "" //figure out later when I can get some sprites
	/// The puzzle datum this is referencing
	var/datum/outbound_teamwork_puzzle/puzzle_datum

/obj/machinery/outbound_puzzle_terminal/Destroy()
	OUTBOUND_CONTROLLER
	if(puzzle_datum)
		outbound_controller.puzzle_controller.puzzles -= puzzle_datum
		QDEL_NULL(puzzle_datum)
	return ..()

/obj/machinery/outbound_puzzle_terminal/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id, name)
		ui.open()

/obj/effect/landmark/puzzle_terminal_spawn //Placed on the shuttle, once the controller inits it replaces these
	name = "terminalspawn"
