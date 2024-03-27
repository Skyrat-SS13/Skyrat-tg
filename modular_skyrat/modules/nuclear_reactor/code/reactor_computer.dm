/obj/machinery/computer/reactor_control
	name = "GA37W Reactor Control Terminal"
	desc = "This computer controls the Micron Control Systems GA37W Experimental Boiling Water Reactor."
	/// Our connection to the reactor.
	var/obj/machinery/reactor/connected_reactor

/obj/machinery/computer/reactor_control/Destroy()
	. = ..()
	if(connected_reactor)
		connected_reactor.connected_computer = null
	connected_reactor = null

/obj/machinery/computer/reactor_control/ui_interact(mob/user, datum/tgui/ui)
	. = ..()
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ReactorControl", name)
		ui.open()

/obj/machinery/computer/reactor_control/ui_data(mob/user)
	var/list/data = list()

	// Direct reactor stats
	data["reactor_connected"] = connected_reactor ? TRUE : FALSE

	if(!connected_reactor)
		return data

	data["reactor_status"] = connected_reactor.reactor_status
	data["reactor_temperature"] = connected_reactor.core_temperature
	data["reactor_max_temperature"] = connected_reactor.maximum_temperature
	data["reactor_pressure"] = connected_reactor.core_pressure
	data["reactor_max_pressure"] = connected_reactor.maximum_pressure
	data["reactor_integrity"] = connected_reactor.vessel_integrity
	data["calculated_power"] = connected_reactor.calculated_power
	data["calculated_control_rod_efficiency"] = connected_reactor.calculated_control_rod_efficiency
	data["calculated_cooling_potential"] = connected_reactor.calculated_cooling_potential
	data["ambient_air_temperature"] = connected_reactor.get_ambient_air_temperature()
	data["target_control_rod_insertion"] = connected_reactor.desired_control_rod_insertion

	// Heat exchanger information
	data["exchanger_connected"] = connected_reactor.reactor_heat_exchanger ? TRUE : FALSE
	data["exchanger_ambient_temperature"] = 0

	data["exchanger_input_gases"] = list()
	data["exchanger_input_air_temperature"] = 0
	data["exchanger_input_air_pressure"] = 0

	data["exchanger_output_gases"] = list()
	data["exchanger_output_air_temperature"] = 0
	data["exchanger_output_air_pressure"] = 0

	data["exchanger_cooling_potential"] = 0


	// If we have a heat exchanger, get the details of it.
	if(connected_reactor.reactor_heat_exchanger)
		var/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/exchanger = connected_reactor.reactor_heat_exchanger
		var/datum/gas_mixture/air_input = exchanger.get_input_gas()
		var/datum/gas_mixture/air_output = exchanger.get_output_gas()

		for(var/gasid in air_input.gases)
			data["exchanger_input_gases"] += list(list(
				"name"= air_input.gases[gasid][GAS_META][META_GAS_NAME],
				"amount" = round(100*air_input.gases[gasid][MOLES]/air_input.total_moles(),0.01)
			))

		data["exchanger_input_air_temperature"] = air_input.return_temperature()
		data["exchanger_input_air_pressure"] = air_input.return_pressure()

		for(var/gasid in air_output.gases)
			data["exchanger_output_gases"] += list(list(
				"name"= air_output.gases[gasid][GAS_META][META_GAS_NAME],
				"amount" = round(100*air_output.gases[gasid][MOLES]/air_output.total_moles(),0.01)
			))

		data["exchanger_output_air_temperature"] = air_output.return_temperature()
		data["exchanger_output_air_pressure"] = air_output.return_pressure()

		data["exchanger_ambient_temperature"] = exchanger.get_ambient_air_temperature()

		data["exchanger_cooling_potential"] = exchanger.calculated_cooling_potential

	data["control_rods"] = list()
	if(length(connected_reactor.control_rods))
		for(var/obj/item/reactor_control_rod/rod in connected_reactor.control_rods)
			data["control_rods"] += list(list(
				"name" = rod.name,
				"insertion_percent" = rod.insertion_percent,
				"max_integrity" = rod.max_integrity,
				"efficiency" = rod.efficiency,
				"heat_rating" = rod.heat_rating,
				"degradation" = rod.degradation,
				"movement_rate" = rod.movement_rate,
			))

	data["fuel_rods"] = list()
	if(length(connected_reactor.fuel_rods))
		for(var/obj/item/reactor_fuel_rod/fuel_rod in connected_reactor.fuel_rods)
			data["fuel_rods"] += list(list(
				"fuel_name" = fuel_rod.fuel_name,
				"radioactivity" = fuel_rod.radioactivity,
				"depletion" = fuel_rod.depletion,
				"depletion_threshold" = fuel_rod.depletion_threshold,
			))

	return data

/obj/machinery/computer/reactor_control/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	switch(action)
		if("sync_reactor")
			if(!find_reactor())
				playsound(src, 'sound/machines/buzz-two.ogg', 100)
				balloon_alert_to_viewers("No reactor found!")
				return
		if("sync_heatsink")
			if(!connected_reactor)
				return
			if(!connected_reactor.find_heatsink())
				playsound(src, 'sound/machines/buzz-two.ogg', 100)
				balloon_alert_to_viewers("No heatsink found!")
				return
		if("turn_on")
			connected_reactor.start_up()
			return TRUE
		if("move_control_rods")
			connected_reactor.desired_control_rod_insertion = clamp(params["control_rod_insertion"], 0, 100)
		if("toggle_cover")
			connected_reactor.toggle_cover()

/obj/machinery/computer/reactor_control/proc/find_reactor()
	for(var/obj/machinery/reactor/found_reactor in range(20, src))
		connected_reactor = found_reactor
		found_reactor.connected_computer = src
		RegisterSignal(found_reactor, COMSIG_QDELETING, PROC_REF(reactor_deleted))
		return TRUE
	return FALSE

/obj/machinery/computer/reactor_control/proc/reactor_deleted()
	SIGNAL_HANDLER
	connected_reactor = null
