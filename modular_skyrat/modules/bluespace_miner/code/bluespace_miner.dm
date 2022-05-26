/obj/machinery/bluespace_miner
	name = "bluespace miner"
	desc = "Through the power of bluespace, it is capable of producing materials."
	icon = 'modular_skyrat/modules/bluespace_miner/icons/bluespace_miner.dmi'
	icon_state = "miner"

	density = TRUE
	circuit = /obj/item/circuitboard/machine/bluespace_miner
	idle_power_usage = 300

	///the temperature of the co2 produced per successful process (its really 100) KELVIN
	var/gas_temp = 100
	///the amount of seconds process_speed goes on cooldown for
	var/processing_speed = 6 SECONDS
	///the chance each ore has to be picked, weighted list
	var/list/ore_chance = list(
		/obj/item/stack/sheet/iron = 20,
		/obj/item/stack/sheet/glass = 20,
		/obj/item/stack/sheet/mineral/plasma = 14,
		/obj/item/stack/sheet/mineral/silver = 8,
		/obj/item/stack/sheet/mineral/titanium = 8,
		/obj/item/stack/sheet/mineral/uranium = 3,
		/obj/item/xenoarch/strange_rock = 3,
		/obj/item/stack/sheet/mineral/gold = 3,
		/obj/item/stack/sheet/mineral/diamond = 1,
	)
	COOLDOWN_DECLARE(process_speed)

/obj/machinery/bluespace_miner/RefreshParts()
	. = ..()
	gas_temp = 100
	//starts at 100, should go down to 60
	for(var/obj/item/stock_parts/micro_laser/laser_part in component_parts)
		gas_temp -= (laser_part.rating * 5)
	processing_speed = 6 SECONDS
	//starts at 6 seconds, should go down to 2 seconds
	for(var/obj/item/stock_parts/manipulator/manipulator_part in component_parts)
		processing_speed -= (manipulator_part.rating * (0.5 SECONDS))

/obj/machinery/bluespace_miner/update_overlays()
	. = ..()
	cut_overlays()
	if(panel_open)
		add_overlay("miner_open")
	if(machine_stat & (NOPOWER|BROKEN))
		return
	add_overlay("miner_on")

/obj/machinery/bluespace_miner/examine(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		. += span_warning("The safeties are turned off!")
	var/turf/src_turf = get_turf(src)
	var/datum/gas_mixture/environment = src_turf.return_air()
	if(environment.temperature >= T20C)
		. += span_warning("[src] is in a suboptimal environment: " + span_boldwarning("TEMPERATURE TOO HIGH!"))
	if(environment.return_pressure() <= ONE_ATMOSPHERE)
		. += span_warning("[src] is in a suboptimal environment: " + span_boldwarning("PRESSURE TOO LOW!"))
	if(environment.return_pressure() >= (ONE_ATMOSPHERE * 1.5))
		. += span_warning("[src] is in a suboptimal environment: " + span_boldwarning("PRESSURE TOO HIGH!"))
	for(var/obj/machinery/bluespace_miner/bs_miner in range(1, src))
		if(bs_miner != src)
			. += span_warning("[src] is in a suboptimal environment: TOO CLOSE TO ANOTHER BLUESPACE MINER")

//we need to make sure we can actually print the ores out
/obj/machinery/bluespace_miner/proc/check_factors()
	if(!COOLDOWN_FINISHED(src, process_speed))
		return FALSE
	COOLDOWN_START(src, process_speed, processing_speed)
	// cant be broken or unpowered
	if(machine_stat & (NOPOWER|BROKEN))
		return FALSE
	// cant be unanchored or open panel
	if(!anchored || panel_open)
		return FALSE
	for(var/obj/machinery/bluespace_miner/bs_miner in range(1, src))
		if(bs_miner != src)
			return FALSE
	var/turf/src_turf = get_turf(src)
	var/datum/gas_mixture/environment = src_turf.return_air()
	// if its hotter than (or equal to) room temp, don't work
	if(environment.temperature >= T20C)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		return FALSE
	// if its lesser than(or equal to) normal pressure, don't work
	if(environment.return_pressure() <= ONE_ATMOSPHERE)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		return FALSE
	// overpressurizing will cause nuclear particles...
	if(environment.return_pressure() >= (ONE_ATMOSPHERE * 1.5))
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE)
		return FALSE
	//add amount_produced degrees to the temperature
	var/datum/gas_mixture/merger = new
	merger.assert_gas(/datum/gas/carbon_dioxide)
	merger.gases[/datum/gas/carbon_dioxide][MOLES] = MOLES_CELLSTANDARD
	if(obj_flags & EMAGGED)
		merger.assert_gas(/datum/gas/tritium)
		merger.gases[/datum/gas/tritium][MOLES] = MOLES_CELLSTANDARD
	merger.temperature = (T20C + gas_temp)
	src_turf.assume_air(merger)
	return TRUE

//if check_factors is good, then we spawn materials
/obj/machinery/bluespace_miner/proc/spawn_mats()
	var/obj/chosen_sheet = pick_weight(ore_chance)
	new chosen_sheet(get_turf(src))

/obj/machinery/bluespace_miner/process()
	if(!check_factors())
		return
	spawn_mats()
	playsound(src, 'sound/machines/ping.ogg', 50, FALSE)

/obj/machinery/bluespace_miner/crowbar_act(mob/living/user, obj/item/tool)
	if(default_deconstruction_crowbar(tool))
		return TRUE

/obj/machinery/bluespace_miner/screwdriver_act(mob/living/user, obj/item/tool)
	. = TRUE
	if(..())
		return
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, tool))
		update_appearance()
		return
	return FALSE

/obj/machinery/bluespace_miner/emag_act(mob/user, obj/item/card/emag/emag_card)
	if(obj_flags & EMAGGED)
		balloon_alert(user, "already emagged!")
		return
	ore_chance += list(/obj/item/stack/sheet/mineral/bananium = 1)
	obj_flags |= EMAGGED
	balloon_alert_to_viewers("fizzles!")

/obj/item/circuitboard/machine/bluespace_miner
	name = "Bluespace Miner (Machine Board)"
	desc = "The bluespace miner is a machine that, when provided the correct temperature and pressure, will produce materials."
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/bluespace_miner
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/obj/item/stock_parts/matter_bin = 2,
		/obj/item/stock_parts/micro_laser = 2,
		/obj/item/stock_parts/manipulator = 2)
	needs_anchored = TRUE

/datum/supply_pack/misc/bluespace_miner
	name = "Bluespace Miner"
	desc = "Nanotrasen has revolutionized the procuring of materials with bluespace-- featuring the Bluespace Miner!"
	cost = CARGO_CRATE_VALUE * 150 // 30,000
	contains = list(/obj/item/circuitboard/machine/bluespace_miner)
	crate_name = "Bluespace Miner Circuitboard Crate"
	crate_type = /obj/structure/closet/crate

/* if we were going to go research based
/datum/design/board/bluespace_miner
	name = "Machine Design (Bluespace Miner)"
	desc = "Allows for the construction of circuit boards used to build a bluespace miner."
	id = "bluespace_miner"
	build_path = /obj/item/circuitboard/machine/bluespace_miner
	category = list("Misc. Machinery")
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/experiment/scanning/points/bluespace_miner
	name = "Bluespace Miner"
	description = "We can learn from the past technology and create a better future-- with bluespace miners."
	required_points = 5
	required_atoms = list(
		/obj/item/xenoarch/broken_item/tech = 1,
	)

/datum/techweb_node/bluespace_miner
	id = "bluespace_miner"
	display_name = "Bluespace Miner"
	description = "The future is here, where we can mine ores from the great bluespace sea."
	prereq_ids = list("anomaly_research", "bluespace_power")
	design_ids = list(
		"bluespace_miner",
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 10000)
	discount_experiments = list(/datum/experiment/scanning/points/bluespace_miner = 5000)
*/
