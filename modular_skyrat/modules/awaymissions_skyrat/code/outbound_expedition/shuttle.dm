#define TIME_PER_MESSAGE 2.5 SECONDS

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
	var/list/systems = list()
	for(var/datum/outbound_ship_system/system as anything in outbound_controller.ship_systems)
		system = outbound_controller.ship_systems[system]
		var/list/system_data = list()
		system_data["name"] = system.name
		system_data["health"] = system.health / system.max_health
		systems += list(system_data)
	data["systems"] = systems

	return data

/obj/machinery/computer/vanguard_shuttle/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, tgui_id, name)
		ui.open()

/obj/machinery/computer/outbound_radio
	name = "Communications Terminal"
	desc = "A computer that appears to have a variety of sensor-reading and communication gizmos."

/obj/machinery/computer/outbound_radio/proc/start_talking(talk_type)
	var/total_spiel = ""
	var/title = ""
	var/list/text_strings = list()
	var/curr_time = 0 SECONDS
	switch(talk_type)
		if("cargo")
			title = "sensor readout"
			text_strings = list("Sensors have detected a cargo pod nearby your corvette.",
			"Ship has been slowed down to allow for EVA to retrieve the materials if wished.",
			"Retrieval not mandatory.",
			)
	for(var/string in text_strings)
		curr_time += TIME_PER_MESSAGE
		addtimer(CALLBACK(src, /atom/movable.proc/say, string), curr_time)
		total_spiel += "[string]<br>"

	var/obj/item/paper/spiel_paper = new /obj/item/paper(get_turf(src))
	spiel_paper.name = "paper - '[title]'"
	spiel_paper.info = total_spiel
	spiel_paper.update_appearance()

#undef TIME_PER_MESSAGE
