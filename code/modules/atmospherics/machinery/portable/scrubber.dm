/obj/machinery/portable_atmospherics/scrubber
	name = "portable air scrubber"
	icon_state = "scrubber"
	density = TRUE
	max_integrity = 250
	volume = 1000

	///Is the machine on?
	var/on = FALSE
	///the rate the machine will scrub air
	var/volume_rate = 1000
	///Multiplier with ONE_ATMOSPHERE, if the enviroment pressure is higher than that, the scrubber won't work
	var/overpressure_m = 80
	///Should the machine use overlay in update_overlays() when open/close?
	var/use_overlays = TRUE
	///List of gases that can be scrubbed
	var/list/scrubbing = list(
		/datum/gas/plasma,
		/datum/gas/carbon_dioxide,
		/datum/gas/nitrous_oxide,
		/datum/gas/bz,
		/datum/gas/nitrium,
		/datum/gas/tritium,
		/datum/gas/hypernoblium,
		/datum/gas/water_vapor,
		/datum/gas/freon,
		/datum/gas/hydrogen,
		/datum/gas/healium,
		/datum/gas/proto_nitrate,
		/datum/gas/zauker,
		/datum/gas/halon,
	)

/obj/machinery/portable_atmospherics/scrubber/on_deconstruction(disassembled)
	var/turf/local_turf = get_turf(src)
	local_turf.assume_air(air_contents)
	return ..()

/obj/machinery/portable_atmospherics/scrubber/update_icon_state()
	icon_state = "[initial(icon_state)]_[on]"
	return ..()

/obj/machinery/portable_atmospherics/scrubber/update_overlays()
	. = ..()
	if(!use_overlays)
		return
	if(holding)
		. += "scrubber-open"
	if(connected_port)
		. += "scrubber-connector"

/obj/machinery/portable_atmospherics/scrubber/process_atmos()
	if(take_atmos_damage())
		excited = TRUE
		return ..()

	if(!on)
		return ..()

	excited = TRUE

	var/atom/target = holding || get_turf(src)
	scrub(target.return_air())
	//SKYRAT EDIT ADDITION
	for(var/turf/open/open_turf in view(3, src))
		if(open_turf.pollution)
			open_turf.pollution.scrub_amount(POLLUTION_HEIGHT_DIVISOR)
	//SKYRAT EDIT END
	return ..()

/**
 * Called in process_atmos(), handles the scrubbing of the given gas_mixture
 * Arguments:
 * * mixture: the gas mixture to be scrubbed
 */
/obj/machinery/portable_atmospherics/scrubber/proc/scrub(datum/gas_mixture/mixture)
	if(air_contents.return_pressure() >= overpressure_m * ONE_ATMOSPHERE)
		return

	var/transfer_moles = min(1, volume_rate / mixture.volume) * mixture.total_moles()

	var/datum/gas_mixture/filtering = mixture.remove(transfer_moles) // Remove part of the mixture to filter.
	var/datum/gas_mixture/filtered = new
	if(!filtering)
		return

	filtered.temperature = filtering.temperature
	for(var/gas in filtering.gases & scrubbing)
		filtered.add_gas(gas)
		filtered.gases[gas][MOLES] = filtering.gases[gas][MOLES] // Shuffle the "bad" gasses to the filtered mixture.
		filtering.gases[gas][MOLES] = 0
	filtering.garbage_collect() // Now that the gasses are set to 0, clean up the mixture.

	air_contents.merge(filtered) // Store filtered out gasses.
	mixture.merge(filtering) // Returned the cleaned gas.
	if(!holding)
		air_update_turf(FALSE, FALSE)

/obj/machinery/portable_atmospherics/scrubber/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	if(is_operational)
		if(prob(50 / severity))
			on = !on
			if(on)
				SSair.start_processing_machine(src)
		update_appearance()

/obj/machinery/portable_atmospherics/scrubber/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PortableScrubber", name)
		ui.open()

/obj/machinery/portable_atmospherics/scrubber/ui_data()
	var/data = list()
	data["on"] = on
	data["connected"] = connected_port ? 1 : 0
	data["pressure"] = round(air_contents.return_pressure() ? air_contents.return_pressure() : 0)

	data["hasHypernobCrystal"] = !!nob_crystal_inserted
	data["reactionSuppressionEnabled"] = !!suppress_reactions

	data["filterTypes"] = list()
	for(var/path in GLOB.meta_gas_info)
		var/list/gas = GLOB.meta_gas_info[path]
		data["filterTypes"] += list(list("gasId" = gas[META_GAS_ID], "gasName" = gas[META_GAS_NAME], "enabled" = (path in scrubbing)))

	if(holding)
		data["holding"] = list()
		data["holding"]["name"] = holding.name
		var/datum/gas_mixture/holding_mix = holding.return_air()
		data["holding"]["pressure"] = round(holding_mix.return_pressure())
	else
		data["holding"] = null
	return data

/obj/machinery/portable_atmospherics/scrubber/replace_tank(mob/living/user, close_valve)
	. = ..()
	if(!.)
		return
	if(close_valve)
		if(on)
			on = FALSE
			update_appearance()
	else if(on && holding)
		user.investigate_log("started a transfer into [holding].", INVESTIGATE_ATMOS)

/obj/machinery/portable_atmospherics/scrubber/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("power")
			on = !on
			if(on)
				SSair.start_processing_machine(src)
			. = TRUE
		if("eject")
			if(holding)
				replace_tank(usr, FALSE)
				. = TRUE
		if("toggle_filter")
			scrubbing ^= gas_id2path(params["val"])
			. = TRUE
		if("reaction_suppression")
			if(!nob_crystal_inserted)
				message_admins("[ADMIN_LOOKUPFLW(usr)] tried to toggle reaction suppression on a scrubber without a noblium crystal inside, possible href exploit attempt.")
				return
			suppress_reactions = !suppress_reactions
			SSair.start_processing_machine(src)
			message_admins("[ADMIN_LOOKUPFLW(usr)] turned [suppress_reactions ? "on" : "off"] the [src] reaction suppression.")
			usr.investigate_log("turned [suppress_reactions ? "on" : "off"] the [src] reaction suppression.")
			. = TRUE
	update_appearance()

/obj/machinery/portable_atmospherics/scrubber/unregister_holding()
	on = FALSE
	return ..()

/obj/machinery/portable_atmospherics/scrubber/huge
	name = "huge air scrubber"
	icon_state = "hugescrubber"
	anchored = TRUE
	active_power_usage = BASE_MACHINE_ACTIVE_CONSUMPTION * 0.5

	overpressure_m = 200
	volume_rate = 1500
	volume = 50000

	var/movable = FALSE
	use_overlays = FALSE

/obj/machinery/portable_atmospherics/scrubber/huge/movable
	movable = TRUE

/obj/machinery/portable_atmospherics/scrubber/huge/movable/cargo
	anchored = FALSE

/obj/machinery/portable_atmospherics/scrubber/huge/update_icon_state()
	icon_state = "[initial(icon_state)]_[on]"
	return ..()

/obj/machinery/portable_atmospherics/scrubber/huge/process_atmos()
	if((!anchored && !movable) || !is_operational)
		on = FALSE
		update_appearance()
	update_use_power(on ? ACTIVE_POWER_USE : IDLE_POWER_USE)
	if(!on)
		return ..()

	excited = TRUE

	if(!holding)
		var/turf/T = get_turf(src)
		for(var/turf/AT in T.get_atmos_adjacent_turfs(alldir = TRUE))
			scrub(AT.return_air())

	return ..()

/obj/machinery/portable_atmospherics/scrubber/huge/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(default_unfasten_wrench(user, tool))
		if(!movable)
			on = FALSE
		return ITEM_INTERACT_SUCCESS
	return FALSE
