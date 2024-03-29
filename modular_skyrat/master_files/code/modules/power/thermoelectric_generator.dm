#define TEG_EFFICIENCY 0.45

/obj/machinery/power/thermoelectric_generator
	name = "thermoelectric generator"
	desc = "It's a high efficiency thermoelectric generator."
	icon = 'modular_skyrat/master_files/icons/obj/machines/thermoelectric.dmi'
	icon_state = "teg-unassembled"
	density = TRUE
	use_power = NO_POWER_USE
	integrity_failure = 0.375


	///The cold circulator machine, containing cold gas for the mix.
	var/obj/machinery/atmospherics/components/binary/circulator/cold_circ
	///The hot circulator machine, containing very hot gas for the mix.
	var/obj/machinery/atmospherics/components/binary/circulator/hot_circ
	///The amount of power the generator is currently producing.
	var/lastgen = 0
	///The amount of power the generator has last produced.
	var/lastgenlev = -1
	/**
	 * Used in overlays for the TEG, basically;
	 * one number is for the cold mix, one is for the hot mix
	 * If the cold mix has pressure in it, then the first number is 1, else 0
	 * If the hot mix has pressure in it, then the second number is 1, else 0
	 * Neither has pressure: 00
	 * Only cold has pressure: 10
	 * Only hot has pressure: 01
	 * Both has pressure: 11
	 */
	var/last_pressure_overlay = "00"

/obj/machinery/power/thermoelectric_generator/Initialize(mapload)
	. = ..()
	find_circulators()
	connect_to_network()
	SSair.start_processing_machine(src, mapload)
	update_appearance()
	component_parts = list(new /obj/item/circuitboard/machine/thermoelectric_generator)


/obj/machinery/power/thermoelectric_generator/Destroy()
	null_circulators()
	SSair.stop_processing_machine(src)
	return ..()

/obj/machinery/power/thermoelectric_generator/update_appearance()
	cut_overlays()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)

	if(machine_stat & (BROKEN))
		icon_state = "teg-broken"
		return
	if(hot_circ && cold_circ)
		icon_state = "teg-assembled"
	else
		icon_state = "teg-unassembled"
		if(panel_open)
			add_overlay("teg-panel")
		return

	if(machine_stat & (NOPOWER))
		return
	else
		var/level = min(round(lastgenlev/100000),11)
		if(level != 0)
			add_overlay("teg-op[level]")
	return ..()


/obj/machinery/power/thermoelectric_generator/process()
	//Setting this number higher just makes the change in power output slower, it doesnt actualy reduce power output cause **math**
	var/power_output = round(lastgen / 10)
	add_avail(power_output)
	lastgenlev = power_output
	lastgen -= power_output

/obj/machinery/power/thermoelectric_generator/process_atmos()
	if(!cold_circ || !hot_circ)
		return
	if(!powernet)
		return

	var/datum/gas_mixture/cold_air = cold_circ.return_transfer_air()
	var/datum/gas_mixture/hot_air = hot_circ.return_transfer_air()
	if(cold_air && hot_air)
		var/cold_air_heat_capacity = cold_air.heat_capacity()
		var/hot_air_heat_capacity = hot_air.heat_capacity()
		var/delta_temperature = hot_air.temperature - cold_air.temperature
		if(delta_temperature > 0 && cold_air_heat_capacity > 0 && hot_air_heat_capacity > 0)
			var/efficiency = TEG_EFFICIENCY
			var/energy_transfer = delta_temperature*hot_air_heat_capacity*cold_air_heat_capacity/(hot_air_heat_capacity+cold_air_heat_capacity)
			var/heat = energy_transfer*(1-efficiency)
			lastgen += (1000000 * (LOGISTIC_FUNCTION(2,0.5,(delta_temperature/10000),0)-1))
			hot_air.temperature = hot_air.temperature - energy_transfer/hot_air_heat_capacity
			cold_air.temperature = cold_air.temperature + heat/cold_air_heat_capacity

	if(hot_air)
		var/datum/gas_mixture/hot_circ_air1 = hot_circ.airs[1]
		hot_circ_air1.merge(hot_air)

	if(cold_air)
		var/datum/gas_mixture/cold_circ_air1 = cold_circ.airs[1]
		cold_circ_air1.merge(cold_air)

	var/current_pressure = "[cold_circ?.last_pressure_delta > 0 ? "1" : "0"][hot_circ?.last_pressure_delta > 0 ? "1" : "0"]"
	if(current_pressure != last_pressure_overlay)
		//this requires an update to overlays.
		last_pressure_overlay = current_pressure

	update_appearance(UPDATE_ICON)

/obj/machinery/power/thermoelectric_generator/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "ThermoElectricGenerator", name)
		ui.open()

/obj/machinery/power/thermoelectric_generator/ui_data(mob/user)
	var/list/data = list()
	data["error_message"] = null
	if(!powernet)
		data["error_message"] = "Unable to connect to the power network!"
		return data
	if(!cold_circ && !hot_circ)
		data["error_message"] = "Unable to locate any parts! Multitool the machine to sync to nearby parts."
		return data
	if(!cold_circ)
		data["error_message"] = "Unable to locate cold circulator!"
		return data
	if(!hot_circ)
		data["error_message"] = "Unable to locate hot circulator!"
		return data

	var/datum/gas_mixture/cold_circ_air1 = cold_circ.airs[1]
	var/datum/gas_mixture/cold_circ_air2 = cold_circ.airs[2]

	var/datum/gas_mixture/hot_circ_air1 = hot_circ.airs[1]
	var/datum/gas_mixture/hot_circ_air2 = hot_circ.airs[2]

	data["last_power_output"] = display_power(lastgenlev)

	var/list/cold_data = list()
	cold_data["temperature_inlet"] = round(cold_circ_air2.temperature, 0.1)
	cold_data["temperature_outlet"] = round(cold_circ_air1.temperature, 0.1)
	cold_data["pressure_inlet"] = round(cold_circ_air2.return_pressure(), 0.1)
	cold_data["pressure_outlet"] = round(cold_circ_air1.return_pressure(), 0.1)
	data["cold_data"] = list(cold_data)

	var/list/hot_data = list()
	hot_data["temperature_inlet"] = round(hot_circ_air2.temperature, 0.1)
	hot_data["temperature_outlet"] = round(hot_circ_air1.temperature, 0.1)
	hot_data["pressure_inlet"] = round(hot_circ_air2.return_pressure(), 0.1)
	hot_data["pressure_outlet"] = round(hot_circ_air1.return_pressure(), 0.1)
	data["hot_data"] = list(hot_data)

	return data

///Finds and connects nearby valid circulators to the machine, nulling out previous ones.
/obj/machinery/power/thermoelectric_generator/proc/find_circulators()
	null_circulators()
	var/list/valid_circulators = list()

	if(dir & (NORTH|SOUTH))
		var/obj/machinery/atmospherics/components/binary/circulator/east_circulator = locate() in get_step(src, EAST)
		if(east_circulator && east_circulator.dir == WEST)
			valid_circulators += east_circulator
		var/obj/machinery/atmospherics/components/binary/circulator/west_circulator = locate() in get_step(src, WEST)
		if(west_circulator && west_circulator.dir == EAST)
			valid_circulators += west_circulator
	else
		var/obj/machinery/atmospherics/components/binary/circulator/north_circulator = locate() in get_step(src, NORTH)
		if(north_circulator && north_circulator.dir == SOUTH)
			valid_circulators += north_circulator
		var/obj/machinery/atmospherics/components/binary/circulator/south_circulator = locate() in get_step(src, SOUTH)
		if(south_circulator && south_circulator.dir == NORTH)
			valid_circulators += south_circulator

	if(!valid_circulators.len)
		return

	for(var/obj/machinery/atmospherics/components/binary/circulator/circulators as anything in valid_circulators)
		if(circulators.mode == CIRCULATOR_COLD && !cold_circ)
			cold_circ = circulators
			circulators.generator = src
			continue
		if(circulators.mode == CIRCULATOR_HOT && !hot_circ)
			hot_circ = circulators
			circulators.generator = src

/obj/machinery/power/thermoelectric_generator/wrench_act(mob/living/user, obj/item/I)
	. = ..()

	if(!panel_open) //connect/disconnect circulators
		if(!anchored)
			balloon_alert(user, span_warning("Anchor [src] before trying to connect the circulators!"))
			return TRUE
		else
			if(hot_circ && cold_circ)
				balloon_alert(user, span_notice("You start removing the circulators..."))
				if(I.use_tool(src, user, 30, volume=50))
					null_circulators()
					update_appearance()
					balloon_alert(user, span_notice("You disconnect [src]'s circulator links."))
					playsound(src, 'sound/misc/box_deploy.ogg', 50)
				return TRUE

			balloon_alert(user, span_notice("You attempt to attach the circulators..."))
			if(I.use_tool(src, user, 30, volume=50))
				switch(find_circulators())
					if(0)
						balloon_alert(user, span_warning("No circulators found!"))
					if(1)
						balloon_alert(user, span_warning("Only one circulator found!"))
					if(2)
						balloon_alert(user, span_notice("You connect [src]'s circulator links."))
						playsound(src, 'sound/misc/box_deploy.ogg', 50)
						return TRUE
					if(3)
						balloon_alert(user, span_warning("Both circulators are the same mode!"))
				return TRUE

	set_anchored(!anchored)
	I.play_tool_sound(src)
	if(!anchored)
		null_circulators()
	connect_to_network()
	balloon_alert(user, span_notice("You [anchored?"secure":"unsecure"] [src]."))
	update_appearance()
	return TRUE

/obj/machinery/power/thermoelectric_generator/screwdriver_act(mob/user, obj/item/I)
	if(..())
		return TRUE

	if(hot_circ && cold_circ)
		balloon_alert(user, span_warning("Disconnect the circulators first!"))
		return TRUE
	panel_open = !panel_open
	I.play_tool_sound(src)
	balloon_alert(user, span_notice("You [panel_open?"open":"close"] the panel on [src]."))
	update_appearance()
	return TRUE

/obj/machinery/power/thermoelectric_generator/crowbar_act(mob/user, obj/item/I)

	if(anchored)
		balloon_alert(user, span_warning("[src] is anchored!"))
		return TRUE
	else if(!panel_open)
		balloon_alert(user, span_warning("Open the panel first!"))
		return TRUE
	else
		default_deconstruction_crowbar(I)
		return TRUE

/obj/machinery/power/thermoelectric_generator/on_deconstruction()
	null_circulators()

/obj/machinery/power/thermoelectric_generator/proc/null_circulators()
	if(hot_circ)
		hot_circ.generator = null
		hot_circ = null
	if(cold_circ)
		cold_circ.generator = null
		cold_circ = null

/obj/machinery/power/thermoelectric_generator/atom_break(damage_flag)
	null_circulators()
	..()

#undef TEG_EFFICIENCY
