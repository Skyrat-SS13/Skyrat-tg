/*
	Experimental boiling water reactor
	This reactor utilises plumbing and atmoshperics to run an internal pressure vessel which generates heat and steam which is transferred into a turbine.

	Reactor layout
	* = fuel rod
	- = control rod

	* - *
	- * -
	* - *

	The reactor uses incoming gas to cool itself down, and then transfers this very hot gas out to be cooled again. It requires a decent cooling set up to work.
*/

/obj/machinery/reactor
	name = "Micron Control Systems GA37W Experimental Nuclear Reactor"
	desc = "A massive experimental boiling water reactor made by Micron Control Systems."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor96x96.dmi'
	icon_state = "idle"
	bound_x = 96
	bound_y = 96
	layer = OBJ_LAYER

	/// Our looping sound for when we're on.
	var/datum/looping_sound/reactor/soundloop
	/// We only process once every second.
	var/next_slowprocess = 0
	/// Is the reactor cover open?
	var/cover = FALSE
	/// The last calculated power output of the reactor.
	var/calculated_power = 0
	/// The last calculated control rod efficiency
	var/calculated_control_rod_efficiency = 1
	/// The last calculated cooling potential in kelvin, it is the incoming gas temperature.
	var/calculated_cooling_potential = T20C
	/// The last calculated environment air temperature.
	var/calculated_ambient_temperature = T20C
	/// The current heat of the reactor vessel in kelvin. We start at room temperature.
	var/core_temperature = T20C
	/// The maximum temperature of the reactor before it starts taking damage.
	var/maximum_temperature = REACTOR_TEMPERATURE_MAXIMUM
	/// The maximum pressure of the reactor before it starts taking damage.
	var/maximum_pressure = REACTOR_PRESSURE_MAXIMUM
	/// The core pressure of the reactor vessel in kilopascals.
	var/core_pressure = 0
	/// The integrity of the internal reactor core, once this reaches 0, the reactor will explode
	var/vessel_integrity = 100
	/// References to currently installed fuel rods.
	var/list/fuel_rods = list()
	/// The maximum amount of fuel rods this reactor can hold.
	var/maximum_fuel_rods = REACTOR_MAX_FUEL_RODS
	/// References to currently installed control rods.
	var/list/control_rods = list()
	/// The maximum amount of control rods this reactor can hold.
	var/maximum_control_rods = REACTOR_MAX_CONTROL_RODS
	/// What insertion percent do we want the control rods to be at?
	var/desired_control_rod_insertion = 0

	/// Are we online or offline?
	var/reactor_status = REACTOR_OFFLINE

	// References to external objects
	/// The currently installed moderator.
	var/obj/item/reactor_moderator/reactor_moderator
	/// A reference to our connected heat exchanger.
	var/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/reactor_heat_exchanger
	/// A reference to our connected control computer.
	var/obj/machinery/computer/reactor_control/connected_computer

/obj/machinery/reactor/prebuilt/Initialize(mapload)
	. = ..()
	for(var/i = 1, i < maximum_fuel_rods, i++)
		var/obj/item/reactor_fuel_rod/rod = new(src)
		fuel_rods += rod
	for(var/i = 1, i < maximum_control_rods, i++)
		var/obj/item/reactor_control_rod/rod = new(src)
		control_rods += rod

/obj/machinery/reactor/Initialize(mapload)
	. = ..()
	update_appearance()
	soundloop = new(src)

/obj/machinery/reactor/update_overlays()
	. = ..()
	if(cover)
		. += "cover"

/obj/machinery/reactor/process()
	if(next_slowprocess < world.time)
		reactor_fire()
		next_slowprocess = world.time + 1 SECONDS

/obj/machinery/reactor/proc/reactor_fire()
	// First off, we calculate the current control rod efficiency.
	calculated_control_rod_efficiency = calculate_control_rod_efficiency()
	// Then, we calculate the current power out put of the combined fuel rods.
	calculated_power = calculate_power()
	// Then we calculate the cooling potential of the reactor vessel.
	calculated_cooling_potential = get_cooling_potential()

	// Control rods do not move instantly, they take time to move.
	move_control_rods()

	// Next, we process the temperature using our caclulated values.
	process_temperature()

	// Now we process the pressure.
	process_pressure()

	// Now we'll check if the above changes damage the reactor hull.
	process_damage()

	// And finally we process effects such as alarms, flames, etc.
	process_effects()

	update_appearance()

	//if(core_pressure <= 0)
		//shut_down()

/**
 * A reactor can be destroyed in the following ways:
 *
 * 1. The reactor has reached maximum temperature and is literally melting. This causes the reactor to meltdown.
 * A meltdown is not as catastrophic as a blowout, but is still plenty dangerous. It will begin oozing out radioactive lava and toxic gasses,
 * and the room will fill with fire. Eventually the reactor will detonate in a small explosion leaving a neutron beam of radiation in a random direction.
 *
 * 2. The reactor has reached maximum pressure and is going to explode. This causes the reactor to blowout.
 * A blowout is far more catastrophic than a meltdown, and will cause the most damage to the station. When a reactor blowsout, it will violently explode in
 * a very large fireball, leaving the station in a state of chaos as radioactive gasses and toxic gasses are released in all directions, landing all across the station.
 */
/obj/machinery/reactor/proc/process_damage()
	if(core_pressure >= REACTOR_PRESSURE_MAXIMUM) // Pressure will kill the reactor before a meltdown happens.
		vessel_integrity -= clamp(core_pressure / 10000, 0, REACTOR_MAX_DAMAGE_PER_SECOND)
		if(vessel_integrity <= 0)
			blowout()
			return

	if(core_temperature >= REACTOR_TEMPERATURE_MAXIMUM)
		vessel_integrity -= clamp(core_temperature / 1000, 0, REACTOR_MAX_DAMAGE_PER_SECOND)
		if(vessel_integrity <= 0)
			meltdown()
			return

/obj/machinery/reactor/proc/meltdown()

/obj/machinery/reactor/proc/blowout()

/obj/machinery/reactor/proc/process_effects()

// Returns the current ambient air temperature.
/obj/machinery/reactor/proc/get_ambient_air_temperature()
	var/turf/our_turf = get_turf(src)
	var/datum/gas_mixture/enviroment = our_turf.return_air()

	return enviroment.temperature

/obj/machinery/reactor/proc/find_heatsink()
	if(reactor_heat_exchanger)
		return FALSE
	for(var/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/found_heatsink in range(5, src)) //TODO: Update connection systems
		reactor_heat_exchanger = found_heatsink
		found_heatsink.parent_reactor = src
		return TRUE
	return FALSE

/obj/machinery/reactor/proc/start_up()
	if(!LAZYLEN(fuel_rods))
		return
	if(reactor_status == REACTOR_ONLINE)
		return
	START_PROCESSING(SSmachines, src)
	playsound(src, pick('modular_skyrat/modules/nuclear_reactor/sound/startup2.ogg', 'modular_skyrat/modules/nuclear_reactor/sound/startup.ogg'), 100, TRUE)
	soundloop.start()
	visible_message(span_notice("[src] clunks loudly as it begins to whirr to life!"))
	icon_state = "running"
	update_appearance()
	reactor_status = REACTOR_ONLINE

/obj/machinery/reactor/proc/shut_down()
	STOP_PROCESSING(SSmachines, src)
	soundloop.stop()
	core_temperature = T20C
	icon_state = "offline"
	update_appearance()
	reactor_status = REACTOR_OFFLINE

/obj/machinery/reactor/proc/process_pressure() //Pressure is what drives the turbine. If the vent is closed, pressure will quickly build up.
	var/pressure_modifier = core_pressure

	if(core_temperature <= REACTOR_TEMPERATURE_MINIMUM) // We are going to drop  pressure as steam is now turning into water.
		pressure_modifier -= REACTOR_PRESSURE_CONDENSATION_RATE * core_temperature
	else // We are going to increase pressure as water is now turning into steam.
		pressure_modifier += REACTOR_PRESSURE_EVAPORATION_RATE * core_temperature

	core_pressure = clamp(pressure_modifier, 0, INFINITY) // We cannot go below zero pressure.

/obj/machinery/reactor/proc/get_cooling_potential()
	if(!reactor_heat_exchanger)
		return get_ambient_air_temperature() //If we do not have a heat exchanger, we just return the temperature of our turf.

	return reactor_heat_exchanger.calculated_cooling_potential

/obj/machinery/reactor/proc/move_control_rods()
	if(!LAZYLEN(control_rods)) //We have no control rods to move... don't bother trying.
		return
	for(var/obj/item/reactor_control_rod/control_rod in control_rods)
		if(control_rod.insertion_percent == desired_control_rod_insertion)
			continue
		var/control_rod_position_delta = desired_control_rod_insertion - control_rod.insertion_percent
		var/control_rod_movement_amount = clamp(control_rod_position_delta, -control_rod.movement_rate, control_rod.movement_rate)
		control_rod.insertion_percent = clamp((control_rod.insertion_percent + control_rod_movement_amount), 0, 100)

/obj/machinery/reactor/proc/calculate_power()
	if(!LAZYLEN(fuel_rods)) //We have no fuel rods to calculate power from.
		return 0
	var/power = 0
	// Overall reactor power is the sum of the power of all the fuel rods.
	for(var/obj/item/reactor_fuel_rod/fuel_rod in fuel_rods)
		power += fuel_rod.radioactivity
	if(reactor_moderator)
		power *= reactor_moderator.moderator_efficiency
	power /= calculated_control_rod_efficiency
	return power

/obj/machinery/reactor/proc/calculate_control_rod_efficiency()
	var/efficiency = 1
	for(var/obj/item/reactor_control_rod/control_rod in control_rods)
		efficiency += (control_rod.efficiency * (control_rod.insertion_percent / 100))
	return efficiency

/obj/machinery/reactor/proc/process_temperature()
	if(reactor_status != REACTOR_ONLINE)
		return
	// The difference between our lowest possible temperature(target) and our core temperature. Positive if heating, negative if cooling.
	var/calculated_temperature_delta = calculated_cooling_potential - core_temperature

	var/calculated_temperature_modifier = clamp(calculated_temperature_delta, -REACTOR_MAX_TEMPERATURE_CHANGE, REACTOR_MAX_TEMPERATURE_CHANGE)

	// We calculate the heat addition from the power of the reactor.
	// If you can get the cooling potential to be equal to the power, then the reactor temp is stable.
	calculated_temperature_modifier += (calculated_power * 10)

	// Update our core temperature.
	core_temperature = abs(core_temperature + calculated_temperature_modifier)

/obj/machinery/reactor/attackby(obj/item/weapon, mob/user, params)
	if(cover)
		to_chat(user, span_warning("You cannot interact with the reactor while the cover is closed."))
		return FALSE
	if(istype(weapon, /obj/item/reactor_fuel_rod))
		var/obj/item/reactor_fuel_rod/fuel_rod = weapon
		if(LAZYLEN(fuel_rods) >= maximum_fuel_rods)
			to_chat(user, span_warning("[src] is already at maximum fuel capacity."))
			return FALSE
		to_chat(user, span_notice("You start to insert [fuel_rod] into [src]..."))
		if(do_after(user, 5 SECONDS, src))
			radiation_pulse(src, 5)
			to_chat(user, span_notice("[fuel_rod] slots into [src] with a clunk."))
			fuel_rods += fuel_rod
			fuel_rod.forceMove(src)
		return TRUE
	if(istype(weapon, /obj/item/reactor_control_rod))
		var/obj/item/reactor_control_rod/control_rod = weapon
		if(LAZYLEN(control_rods) >= maximum_control_rods)
			to_chat(user, span_warning("[src] is already at maximum control rod capacity."))
			return FALSE
		to_chat(user, span_notice("You start to insert [control_rod] into [src]..."))
		if(do_after(user, 5 SECONDS, src))
			to_chat(user, span_notice("[control_rod] slots into [src] with a clunk."))
			control_rods += control_rod
			control_rod.forceMove(src)
		return TRUE
	if(istype(weapon, /obj/item/reactor_moderator))
		var/obj/item/reactor_moderator/moderator = weapon
		if(reactor_moderator)
			to_chat(user, span_warning("[src] already has a moderator."))
			return FALSE
		to_chat(user, span_notice("You start to insert [moderator] into [src]..."))
		if(do_after(user, 5 SECONDS, src))
			to_chat(user, span_notice("[moderator] slots into [src] with a clunk."))
			reactor_moderator = moderator
			moderator.forceMove(src)
		return TRUE

	if(istype(weapon, /obj/item/multitool))
		var/obj/item/multitool/multitool = weapon
		if(!multitool.buffer)
			return FALSE
		if(istype(multitool.buffer, /obj/machinery/atmospherics/components/binary/reactor_heat_exchanger))
			var/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/exchanger = multitool.buffer
			exchanger.parent_reactor = src
			multitool.buffer = null
			return TRUE
	return ..()

/obj/machinery/computer/reactor_control
	name = "GA37W Reactor Control Terminal"
	desc = "This computer controls the Micron Control Systems GA37W Experimental Boiling Water Reactor."
	/// Our connection to the reactor.
	var/obj/machinery/reactor/connected_reactor

/obj/machinery/computer/reactor_control/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ReactorControl")
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

/obj/machinery/computer/reactor_control/proc/find_reactor()
	for(var/obj/machinery/reactor/found_reactor in range(20, src))
		connected_reactor = found_reactor
		found_reactor.connected_computer = src
		return TRUE
	return FALSE

/**
 * Reactor heat exchanger
 *
 * Instead of the reactor itself being an atmospherics nonsense component, we have one machine that controls the reactor cooling.
 * Basically takes a cool temperature gas and cools the reactor with it, expeling the gas at reactor temperature.
 * The output temperature is directly proportional to the reactor core temperature.
 */
/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger
	name = "Micron Control Systems GA37W Reactor Heat Exchanger"
	desc = "A heat exchanger component for the GA37W Experimental Nuclear Reactor."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "reactor_heat_exchanger"
	density = TRUE

	can_unwrench = TRUE
	pipe_flags = PIPING_ONE_PER_TURF

	/// Our calculated cooling potential in kelvin.
	var/calculated_cooling_potential = T20C
	/// A reference to our connected reactor, if we have one.
	var/obj/machinery/reactor/parent_reactor


/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/multitool_act(mob/living/user, obj/item/tool)
	. = ..()
	if(istype(tool, /obj/item/multitool))
		var/obj/item/multitool/multitool = tool
		to_chat(user, span_notice("[src] is set for linking to a reactor."))
		multitool.buffer = src
		return TRUE

/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/proc/get_input_gas()
	return airs[1]

/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/proc/get_output_gas()
	return airs[2]

/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/examine(mob/user)
	. = ..()
	if(!parent_reactor)
		. += "It is not connected to a reactor."
	else
		. += "It is connected to a reactor."

/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/proc/get_ambient_air_temperature()
	var/turf/our_turf = get_turf(src)
	var/datum/gas_mixture/enviroment = our_turf.return_air()

	return enviroment.temperature

/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/process_atmos()
	if(!parent_reactor) // If we have no parent reactor, we do nothing.
		return

	var/datum/gas_mixture/air_input = airs[1]
	var/datum/gas_mixture/air_output = airs[2]

	if(!QUANTIZE(air_input.total_moles()) || !QUANTIZE(air_output.total_moles())) //Don't transfer if there's no gas
		calculated_cooling_potential = get_ambient_air_temperature()
		return

	calculated_cooling_potential = air_input.temperature

	if(air_input.release_gas_to(air_output, air_input.return_pressure()))
		air_output.temperature = max(parent_reactor.core_temperature, TCMB)
		update_parents()

/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/set_init_directions()
	switch(dir)
		if(NORTH, SOUTH)
			initialize_directions = EAST|WEST
		if(EAST, WEST)
			initialize_directions = NORTH|SOUTH

/obj/machinery/atmospherics/components/binary/reactor_heat_exchanger/get_node_connects()
	return list(turn(dir, 90), turn(dir, 270))

/obj/structure/reactor_steam_duct
	name = "steam duct"
	desc = "A large duct for transporting steam from and to a GA37W reactor."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "steam_duct"

/obj/item/reactor_control_rod
	name = "boron control rod"
	desc = "A control rod for a GA37W reactor. It is made of boron."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "control_rod"

	/// How degraded is this control rod? Only degrades if the temperature exceeds the safe operating temperature.
	var/degradation = 0
	/// How much degradation can we take before we become useless?
	var/max_degradation = 100
	/// Our maximum safe heat rating in Kelvin.
	var/heat_rating = 600
	/// If we are inside a reactor, how deep are we?
	var/insertion_percent = 0
	/// How quickly does this control rod insert.
	var/movement_rate = 5
	/// How efficent are we at controlling a reaction?
	var/efficiency = 0.1

/obj/item/reactor_control_rod/proc/degrade(heat_amount)
	if(heat_amount < heat_rating)
		return

	if(efficiency <= 0) //Effectively dead.
		return

	degradation += (0.001 * heat_amount)

	if(degradation >= max_degradation)
		final_degrade()

/obj/item/reactor_control_rod/proc/final_degrade()
	efficiency = 0

/obj/item/reactor_fuel_rod //Uranium is the standard fuel for the GA37W reactor.
	name = "uranium-235 reactor fuel rod"
	desc = "A fuel rod for the GA37W reactor. It is contains uranium-235."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "fuel_rod"
	/// The name of the fuel type.
	var/fuel_name = "uranium-235"
	/// The overlay icon we will add to the fuel rod once inserted.
	var/fuel_overlay_icon = "overlay_uranium"
	/// How radioactive the fuel is - Used to calculate the reactor's power output.
	var/radioactivity = 0.5
	/// How degraded the fuel is
	var/depletion = 0
	/// The depletion where depletion_final() will be called (and does something)
	var/depletion_threshold = 100
	/// Are we depleted?
	var/depleted = FALSE
	/// How many ticks does it take for the fuel to reach half power.
	var/half_life = 2000
	/// How fast do we deplete
	var/depletion_speed_modifier = 1

/obj/item/reactor_fuel_rod/update_overlays()
	. = ..()
	if(fuel_overlay_icon)
		. += fuel_overlay_icon
	else
		. += "overlay_depleted"

/// Called when it is inside a reactor, by the process.
/obj/item/reactor_fuel_rod/proc/deplete(amount)
	depletion += amount * depletion_speed_modifier
	if(depletion >= depletion_threshold && !depleted)
		depletion_final()

/obj/item/reactor_fuel_rod/proc/depletion_final()

/obj/item/reactor_fuel_rod/plutonium
	name = "plutonium-239 reactor fuel rod"
	desc = "A fuel rod for the GA37W reactor. It is contains plutonium-239."
	fuel_name = "plutonium-239"
	fuel_overlay_icon = "overlay_plutonium"
	radioactivity = 4

/obj/item/reactor_fuel_rod/mox
	name = "mox-54 reactor fuel rod"
	desc = "A fuel rod for the GA37W reactor. It is contains mox-54."
	fuel_name = "mox-54"
	fuel_overlay_icon = "overlay_mox"
	radioactivity = 6

/obj/item/reactor_moderator
	name = "graphite reactor moderator block"
	desc = "A graphite moderator block for the GA37W reactor."
	icon = 'modular_skyrat/modules/nuclear_reactor/icons/reactor32x32.dmi'
	icon_state = "reactor_moderator"
	/// How good is the moderator at slowing neutrons down?
	var/moderator_efficiency = 1.2
