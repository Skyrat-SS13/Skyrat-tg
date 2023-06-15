#define TIME_PER_MESSAGE 2.5 SECONDS
#define REVIVER_INSERT_POINT 2

/obj/machinery/computer/vanguard_shuttle
	name = "Vanguard Corvette Controller"
	desc = "A computer that seems to have a status readout of the ship."
	tgui_id = "CorvetteConsole"

/obj/machinery/computer/vanguard_shuttle/ui_data(mob/user)
	OUTBOUND_CONTROLLER
	var/list/data = list()

	data["jumpsleft"] = outbound_controller.jumps_to_dest == -1 ? "???" : outbound_controller.jumps_to_dest
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

/obj/machinery/computer/outbound_radio/proc/start_talking()
	OUTBOUND_CONTROLLER
	var/total_spiel = ""
	var/curr_time = 0 SECONDS
	if(!outbound_controller.current_event.printout_title || !length(outbound_controller.current_event.printout_strings))
		return

	for(var/string in outbound_controller.current_event.printout_strings)
		curr_time += TIME_PER_MESSAGE
		addtimer(CALLBACK(src, TYPE_PROC_REF(/atom/movable, say), string), curr_time)
		total_spiel += "[string]<br>"

	var/obj/item/paper/spiel_paper = new /obj/item/paper(get_turf(src))
	spiel_paper.name = "paper - '[outbound_controller.current_event.printout_title]'"
	spiel_paper.add_raw_text(total_spiel)
	spiel_paper.update_appearance()

	outbound_controller.current_event.on_radio()

/obj/machinery/computer/outbound_sensor
	name = "Sensor Terminal"
	desc = "A computer that allows the user to use short-range sensors and change the shuttle's trajectory."
	/// The odds of the computer succeeding on this jump
	var/succeed_odds = 33

/obj/machinery/computer/outbound_sensor/examine(mob/user)
	. = ..()
	. += span_notice("There's a <b>disk slot</b> next to the keyboard.")

/obj/machinery/computer/outbound_sensor/attack_hand(mob/living/user, list/modifiers)
	OUTBOUND_CONTROLLER
	if(!outbound_controller.puzzle_controller.can_scan)
		to_chat(user, span_warning("You can't use this currently - the coordinates are locked in and the shuttle's on autopilot."))
		return

	if(outbound_controller.puzzle_controller.has_scanned)
		to_chat(user, span_warning("Sensors have already scanned the nearby area this jump."))
		return

	to_chat(user, span_notice("You start scanning for nearby structures..."))
	if(!do_after(user, 10 SECONDS, src))
		to_chat(user, span_warning("You need to stand still to scan with the console!"))
		return

	if(!prob(outbound_controller.is_system_dead("Sensors") ? (succeed_odds / 2) : succeed_odds)) //good luck lmao
		to_chat(user, span_notice("You don't find anything nearby this jump, maybe the next one?"))
		outbound_controller.puzzle_controller.has_scanned = TRUE
		return

	to_chat(user, span_notice("You found something not too far off, coordinates locked in."))
	outbound_controller.puzzle_controller.can_scan = FALSE
	outbound_controller.puzzle_controller.on_computer_scan()
	return ..()

/obj/machinery/computer/outbound_sensor/attackby(obj/item/weapon, mob/user, params)
	OUTBOUND_CONTROLLER
	if(!istype(weapon, /obj/item/computer_disk))
		return ..()

	if(!istype(outbound_controller.current_event, /datum/outbound_random_event/story/radar)) // de-hardcode later if this gets used for anything else
		return

	var/obj/item/computer_disk/our_disk = weapon
	var/datum/computer_file/found_file = locate(/datum/computer_file/data/outbound_radar_data) in our_disk.stored_files
	if(!found_file)
		balloon_alert(user, "nothing to upload")
		return

	balloon_alert(user, "uploading...")
	if(!do_after(user, 10 SECONDS, src))
		balloon_alert(user, "uploading stopped")
		return
	playsound(src, 'sound/machines/ping.ogg', 75)
	var/randoms_to_make = rand(5, 7)
	for(var/i in 1 to randoms_to_make - REVIVER_INSERT_POINT)
		outbound_controller.event_order += "random"

	outbound_controller.event_order += /datum/outbound_random_event/ruin/guaranteed/reviver
	for(var/i in 1 to REVIVER_INSERT_POINT)
		outbound_controller.event_order += "random"
		
	outbound_controller.event_order += /datum/outbound_random_event/story/the_end
	outbound_controller.jumps_to_dest = outbound_controller.event_order.Find(/datum/outbound_random_event/story/the_end)
	say("Large energy emission signal located. Coordinates locked.")
	outbound_controller.give_objective_all(outbound_controller.objectives[/datum/outbound_objective/cryo])
	outbound_controller.current_event = null

#undef TIME_PER_MESSAGE
#undef REVIVER_INSERT_POINT
