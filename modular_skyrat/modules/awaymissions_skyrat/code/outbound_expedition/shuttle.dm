/datum/map_template/shuttle/vanguard_corvette
	prefix = "_maps/shuttles/skyrat/"
	suffix = "corvette"
	port_id = "vanguard"
	who_can_purchase = null

/obj/machinery/computer/vanguard_shuttle
	name = "Vanguard Corvette Controller"
	desc = "A computer that seems to have a status readout of the ship."
	tgui_id = "CorvetteConsole"

/obj/machinery/computer/vanguard_shuttle/ui_data(mob/user)
	OUTBOUND_CONTROLLER
	var/list/data = list()

	data["jumpsleft"] = outbound_controller.jumps_to_dest

	return data

/obj/machinery/computer/vanguard_shuttle/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id, name)
		ui.open()
