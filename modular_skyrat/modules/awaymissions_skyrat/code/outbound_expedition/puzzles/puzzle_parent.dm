/datum/outbound_teamwork_puzzle
	/// Name of the puzzle
	var/name = "Generic"
	/// Reference to the terminal that this puzzle is accessable through
	var/obj/machinery/outbound_expedition/puzzle_terminal/terminal
	/// Name of the TGUI UI the terminal will open
	var/tgui_name = ""
	/// Name of the terminal
	var/terminal_name = ""
	/// Description of the terminal
	var/terminal_desc = ""
	/// Describing how to complete the puzzle
	var/desc = ""
	/// If it's enabled or not
	var/enabled = FALSE
	/// What system is damaged by this failing
	var/fail_system = ""

/datum/outbound_teamwork_puzzle/Destroy(force, ...)
	if(terminal)
		terminal = null // terminal destroys the puzzle, puzzle does not destroy the terminal
	return ..()

/// What happens when the puzzle is fucked up and answered incorrectly
/datum/outbound_teamwork_puzzle/proc/fail()
	return
