/obj/machinery/computer/cargo_shuttle_console
	name = "NLV Consign Flight Console"
	desc = "A console used for controlling the NLV Consign."
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/cargo_shuttle_console
	light_color = LIGHT_COLOR_BLUE

	///The name of the shuttle template being used as the cargo shuttle. 'supply' is default and contains critical code. Don't change this unless you know what you're doing.
	var/cargo_shuttle = "supply"
	///The docking port called when returning to the station.
	var/docking_home = "supply_home"
	///The docking port called when leaving the station.
	var/docking_away = "supply_away"

	var/safety_warning = "For safety and ethical reasons, the automated supply shuttle \
		cannot transport human remains, classified nuclear weaponry, mail \
		homing beacons, unstable eigenstates or machinery housing any form of artificial intelligence."
	var/blockade_warning = "Bluespace instability detected. Shuttle movement impossible."

	var/export_categories = EXPORT_CARGO | EXPORT_CONTRABAND | EXPORT_EMAG

	var/last_autopilot_change = 0

	/// radio used by the console to send messages on supply channel
	var/obj/item/radio/headset/radio

/obj/machinery/computer/cargo_shuttle_console/Initialize()
	. = ..()
	radio = new /obj/item/radio/headset/headset_cargo(src)

/obj/item/circuitboard/computer/cargo_shuttle_console
	name = "Flight Control (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/cargo_shuttle_console

/obj/machinery/computer/cargo_shuttle_console/ui_interact(mob/user)
	var/list/dat = list("<b>SHUTTLE CONTROL SYSTEMS</b>")
	var/manual_operation = SSshuttle.supply.manual_operation
	dat += "<b>STATUS:</b> [SSshuttle.supply.getStatusText()]"
	if(manual_operation)
		dat += "<font color='#ff0000'><b>AUTOPILOT OFFLINE</b></font> - <a href='byond://?src=[REF(src)];function=autopilot'>SWITCH TO AUTOPILOT</a>"
		dat += "<b>Flight control:</b>"
		if(SSshuttle.supply.getDockedId() == docking_away)
			dat += "<a href='byond://?src=[REF(src)];function=takeoff'>Navigate to [station_name()]</a>"
		else
			dat += "<a href='byond://?src=[REF(src)];function=takeoff'>Navigate to NCV Titan</a>"
		dat += "<a href='byond://?src=[REF(src)];function=lockdoors'>Bolt doors</a>"
		dat += "<a href='byond://?src=[REF(src)];function=unlockdoors'>Unbolt doors</a>"
	else
		dat += "<font color='#00ff15'>AUTOPILOT ONLINE</font> - <a href='byond://?src=[REF(src)];function=autopilot'>SWITCH TO MANUAL OPERATION</a>"


	var/datum/browser/popup = new(user, "flight_control","FLIGHT CONTROL", 400, 400, src)
	popup.set_content(dat.Join("<br>"))
	popup.open()
	onclose(user, "flight_control")

/obj/machinery/computer/cargo_shuttle_console/Topic(href, href_list)
	if(..())
		return

	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		return

	usr.set_machine(src)

	var/function = href_list["function"]

	if(href_list["close"])
		usr << browse(null, "window=flight_control")
		return

	switch(function)
		if("autopilot")
			if((last_autopilot_change + 1 MINUTES) > world.time)
				say("Autopilot system in cooldown.")
				return
			SSshuttle.supply.manual_operation = !SSshuttle.supply.manual_operation
			say("Autopilot [SSshuttle.supply.manual_operation ? "disengaged" : "engaged"].")
			minor_announce("Cargo shuttle is now in [SSshuttle.supply.manual_operation ? "manual" : "automatic"] operation.", "Cargo Shuttle")
			last_autopilot_change = world.time
		if("takeoff")
			if(!SSshuttle.supply.canMove())
				say(safety_warning)
				return
			if(SSshuttle.supplyBlocked)
				say(blockade_warning)
				return
			if(SSshuttle.supply.getDockedId() == docking_home)
				SSshuttle.supply.export_categories = export_categories
				SSshuttle.moveShuttle(cargo_shuttle, docking_away, TRUE)
				say("Shuttle departing, ETA [SSshuttle.supply.timeLeft(600)] minutes.")
				radio.talk_into(src, "NLV Consign departing the station.", RADIO_CHANNEL_SUPPLY)
				investigate_log("[key_name(usr)] sent the supply shuttle away.", INVESTIGATE_CARGO)
			else
				investigate_log("[key_name(usr)] called the supply shuttle.", INVESTIGATE_CARGO)
				radio.talk_into(src, "NLV Consign departing towards the station, ETA: [SSshuttle.supply.timeLeft(600)] minutes.", RADIO_CHANNEL_SUPPLY)
				say("Shuttle departing, ETA [SSshuttle.supply.timeLeft(600)] minutes.")
				SSshuttle.moveShuttle(cargo_shuttle, docking_home, TRUE)
		if("lockdoors")
			for(var/area/place in SSshuttle.supply.shuttle_areas)
				for(var/obj/machinery/door/airlock/iterating_airlock in place)
					iterating_airlock.close()
					iterating_airlock.bolt()
		if("unlockdoors")
			for(var/area/place in SSshuttle.supply.shuttle_areas)
				for(var/obj/machinery/door/airlock/iterating_airlock in place)
					iterating_airlock.unbolt()
	updateUsrDialog()
