/obj/machinery/electrolyzer/co2_cracker
	icon = 'modular_skyrat/modules/colony_fabricator/icons/co2_cracker.dmi'
	name = "portable carbon dioxide cracker"
	desc = "A portable appliance responsible for the air you breathe on most early frontier colonies. Using an energy intensive process, \
		it can harvest carbon dioxide from the air around it and crack it into its constituent parts. The useful part of this is that the \
		oxygen is reclaimed while the carbon is re-used within the machine to facilitate further operation."
	circuit = null
	working_power = 2
	efficiency = 1
	/// Soundloop for while the cracker is turned on
	var/datum/looping_sound/conditioner_running/soundloop
	/// What type of reaction do we check and run for turf gasses?
	var/datum/electrolyzer_reaction/reaction_to_run = /datum/electrolyzer_reaction/co2_cracking

/obj/machinery/electrolyzer/co2_cracker/Initialize(mapload)
	. = ..()
	soundloop = new(src, FALSE)
	reaction_to_run = new
	AddElement(/datum/element/manufacturer_examine, COMPANY_FRONTIER)

/obj/machinery/electrolyzer/co2_cracker/call_reactions(datum/gas_mixture/env)
	if(!reaction_to_run.reaction_check(env))
		return

	reaction_to_run.react(loc, env, working_power)

	env.garbage_collect()

/obj/machinery/electrolyzer/co2_cracker/default_deconstruction_crowbar()
	return

/obj/machinery/electrolyzer/co2_cracker/RefreshParts()
	. = ..()
	working_power = 2
	efficiency = 1

/obj/machinery/electrolyzer/co2_cracker/process_atmos()
	if(on && !soundloop.loop_started)
		soundloop.start()
	else if(soundloop.loop_started)
		soundloop.stop()
	. = ..()

// Gas reaction for splitting co2 into oxygen

/datum/electrolyzer_reaction/co2_cracking
	name = "CO2 Cracking"
	id = "co2_cracking"
	desc = "Cracking of CO2 into breathable oxygen"
	requirements = list(
		/datum/gas/carbon_dioxide = MINIMUM_MOLE_COUNT
	)
	factor = list(
		/datum/gas/carbon_dioxide = "1 mole CO2 is consumed",
		/datum/gas/oxygen = "1 mole of O2 gets produced",
		"Location" = "Can only happen on turfs with an active CO2 cracker.",
	)

/datum/electrolyzer_reaction/co2_cracking/react(turf/location, datum/gas_mixture/air_mixture, working_power)
	var/old_heat_capacity = air_mixture.heat_capacity()
	air_mixture.assert_gases(/datum/gas/carbon_dioxide, /datum/gas/oxygen)
	var/proportion = min(air_mixture.gases[/datum/gas/carbon_dioxide][MOLES] * INVERSE(2), (2.5 * (working_power ** 2)))
	air_mixture.gases[/datum/gas/water_vapor][MOLES] -= proportion
	air_mixture.gases[/datum/gas/oxygen][MOLES] += proportion
	var/new_heat_capacity = air_mixture.heat_capacity()
	if(new_heat_capacity > MINIMUM_HEAT_CAPACITY)
		air_mixture.temperature = max(air_mixture.temperature * old_heat_capacity / new_heat_capacity, TCMB)

// Cracker type that spawns with a cell pre-installed

/obj/machinery/electrolyzer/co2_cracker/spawns_with_cell
	cell = /obj/item/stock_parts/cell/super
