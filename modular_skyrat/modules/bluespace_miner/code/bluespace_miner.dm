#define BLUESPACE_MINER_TOO_HOT (1<<0)
#define BLUESPACE_MINER_LOW_PRESSURE (1<<1)
#define BLUESPACE_MINER_HIGH_PRESSURE (1<<2)
#define BLUESPACE_MINER_TOO_CLOSE (1<<3)

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
	///the current status of the enviroment. Any nonzero value means we can't work
	var/mining_stat = NONE
	///what the bs miner will have a triple chance to produce, if any
	var/probability_mod = null
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

	gas_temp = 100 //starts at 90 temp, should go down to 60
	for(var/datum/stock_part/micro_laser/laser_part in component_parts)
		gas_temp -= (laser_part.tier * 5)

	processing_speed = 6 SECONDS //starts at 5 seconds, should go down to 2
	for(var/datum/stock_part/servo/servo_part in component_parts)
		processing_speed -= (servo_part.tier * (0.5 SECONDS))
	processing_speed = CEILING(processing_speed, 1)

/obj/machinery/bluespace_miner/update_overlays()
	. = ..()
	cut_overlays()
	if(panel_open)
		add_overlay("miner_open")
	if(machine_stat & (NOPOWER|BROKEN))
		return
	if(mining_stat)
		add_overlay("miner_error")
		// This one overrides all the following overlays so we check it first
		if(mining_stat & BLUESPACE_MINER_TOO_CLOSE)
			add_overlay("miner_proximity")
			return
		if(mining_stat & BLUESPACE_MINER_TOO_HOT)
			add_overlay("miner_hot")
		if(mining_stat & BLUESPACE_MINER_LOW_PRESSURE)
			add_overlay("miner_plow")
		else if(mining_stat & BLUESPACE_MINER_HIGH_PRESSURE)
			add_overlay("miner_phigh")
	else
		add_overlay("miner_on")

/obj/machinery/bluespace_miner/examine(mob/user)
	. = ..()
	if(obj_flags & EMAGGED)
		. += span_warning("The safeties are turned off!")
	// We don't need to run any more checks if this is functioning. Genuinely the old code is terrible
	if(mining_stat)
		if(mining_stat & BLUESPACE_MINER_TOO_CLOSE)
			. += span_warning("[src] is in a suboptimal environment: TOO CLOSE TO ANOTHER BLUESPACE MINER")
			return . // This needs relocation to fix so we won't bother with the rest
		if(mining_stat & BLUESPACE_MINER_TOO_HOT)
			. += span_warning("[src] is in a suboptimal environment: " + span_boldwarning("TEMPERATURE TOO HIGH!"))
		if(mining_stat & BLUESPACE_MINER_LOW_PRESSURE)
			. += span_warning("[src] is in a suboptimal environment: " + span_boldwarning("PRESSURE TOO LOW!"))
		else if(mining_stat & BLUESPACE_MINER_HIGH_PRESSURE)
			. += span_warning("[src] is in a suboptimal environment: " + span_boldwarning("PRESSURE TOO HIGH!"))


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
	var/previous_mining_stat = mining_stat
	// Generates the mining_stat to use for overlays and checks
	update_mining_stat()
	// Updates the overlays, if it is needed
	if(mining_stat != previous_mining_stat)
		update_appearance()
	// Check if it is nonzero
	if(mining_stat)
		playsound(src, 'sound/machines/buzz-sigh.ogg', 50, FALSE, SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)
		return FALSE
	// mining_stat = 0, we are ready to go
	return TRUE

//Checking enviroment individually
/obj/machinery/bluespace_miner/proc/update_mining_stat()
	// To actually check atmos
	var/turf/src_turf = get_turf(src)
	var/datum/gas_mixture/environment = src_turf.return_air()
	// Default value
	mining_stat = NONE
	// Proximity check, needs to be more than one tile from another miners
	for(var/obj/machinery/bluespace_miner/bs_miner in range(1, src))
		if(bs_miner != src)
			mining_stat = mining_stat | BLUESPACE_MINER_TOO_CLOSE
			return // This is allmighty
	// if its hotter than (or equal to) room temp, don't work
	if(environment.temperature >= T20C)
		mining_stat = mining_stat | BLUESPACE_MINER_TOO_HOT
	// if its lesser than(or equal to) normal pressure, don't work. Same goes for over(or equal to) 150% pressure
	if(environment.return_pressure() <= ONE_ATMOSPHERE)
		mining_stat = mining_stat | BLUESPACE_MINER_LOW_PRESSURE
	else if(environment.return_pressure() >= (ONE_ATMOSPHERE * 1.5))
		mining_stat = mining_stat | BLUESPACE_MINER_HIGH_PRESSURE

//if check_factors is good, then we spawn materials
/obj/machinery/bluespace_miner/proc/spawn_mats()
	var/obj/chosen_sheet = pick_weight(ore_chance)
	if(probability_mod && (probability_mod != chosen_sheet))
		return
	new chosen_sheet(get_turf(src))

/obj/machinery/bluespace_miner/process()
	if(!check_factors())
		return
	// Generate all the waste gas
	var/datum/gas_mixture/merger = new
	merger.assert_gas(/datum/gas/carbon_dioxide)
	merger.gases[/datum/gas/carbon_dioxide][MOLES] = MOLES_CELLSTANDARD
	if(obj_flags & EMAGGED)
		merger.assert_gas(/datum/gas/tritium)
		merger.gases[/datum/gas/tritium][MOLES] = MOLES_CELLSTANDARD
	merger.temperature = (T20C + gas_temp)
	var/turf/src_turf = get_turf(src)
	src_turf.assume_air(merger)
	// Finally spawn the mats
	spawn_mats()
	// Crazy? I was crazy once. They locked me in a room, an atmos room, an atmos room with bluespace miners, and the bluespace miners made me crazy.
	// This sound no longer echoes through departments like before. Got that was an era.
	playsound(src, 'sound/machines/ping.ogg', 50, FALSE, SILENCED_SOUND_EXTRARANGE, ignore_walls = FALSE)

/obj/machinery/bluespace_miner/attack_hand(mob/living/user, list/modifiers)
	if(!change_probability(user))
		return ..()

/obj/machinery/bluespace_miner/attack_ai(mob/user)
	if(!change_probability(user))
		return ..()

/obj/machinery/bluespace_miner/attack_drone(mob/living/basic/drone/user, list/modifiers)
	if(!change_probability(user))
		return ..()

/obj/machinery/bluespace_miner/attack_robot(mob/user)
	if(!change_probability(user))
		return ..()

/**
 * Allows players to triple the chance of the ore of their choice whilst losing the other ores
 * Must be able to actually produce stuff before you can change the probabilities
 */
/obj/machinery/bluespace_miner/proc/change_probability(mob/user)
	if(probability_mod)
		ore_chance[probability_mod] /= 3
		probability_mod = null
		balloon_alert(user, "probability change disabled")
		return TRUE

	var/choice = tgui_input_list(user, "Which would you like to triple?", "Probability Change", ore_chance)
	if(!choice)
		return FALSE

	ore_chance[choice] *= 3
	probability_mod = choice
	balloon_alert(user, "probability change enabled")
	return TRUE

/obj/machinery/bluespace_miner/crowbar_act(mob/living/user, obj/item/tool)
	if(default_deconstruction_crowbar(tool))
		return TRUE

/obj/machinery/bluespace_miner/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

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
		return FALSE
	ore_chance += list(/obj/item/stack/sheet/mineral/bananium = 1)
	obj_flags |= EMAGGED
	balloon_alert_to_viewers("fizzles!")
	return TRUE

/obj/item/circuitboard/machine/bluespace_miner
	name = "Bluespace Miner"
	desc = "The bluespace miner is a machine that, when provided the correct temperature and pressure, will produce materials."
	greyscale_colors = CIRCUIT_COLOR_GENERIC
	build_path = /obj/machinery/bluespace_miner
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		/obj/item/stack/ore/bluespace_crystal/refined = 1,
		/datum/stock_part/matter_bin = 2,
		/datum/stock_part/micro_laser = 2,
		/datum/stock_part/servo = 2,
	)
	needs_anchored = TRUE

/datum/supply_pack/misc/bluespace_miner
	name = "Bluespace Miner"
	desc = "Nanotrasen has revolutionized the procuring of materials with bluespace-- featuring the Bluespace Miner!"
	cost = CARGO_CRATE_VALUE * 50 // 10,000
	contains = list(/obj/item/circuitboard/machine/bluespace_miner)
	crate_name = "Bluespace Miner Circuitboard Crate"
	crate_type = /obj/structure/closet/crate

/datum/design/board/bluespace_miner
	name = "Machine Design (Bluespace Miner)"
	desc = "Allows for the construction of circuit boards used to build a bluespace miner."
	id = "bluespace_miner"
	build_path = /obj/item/circuitboard/machine/bluespace_miner
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_ENGINEERING
	)
	departmental_flags = DEPARTMENT_BITFLAG_SCIENCE | DEPARTMENT_BITFLAG_CARGO | DEPARTMENT_BITFLAG_ENGINEERING

/datum/techweb_node/bluespace_miner
	id = "bluespace_miner"
	display_name = "Bluespace Miner"
	description = "The future is here, where we can mine ores from the great bluespace sea."
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = TECHWEB_TIER_5_POINTS)
	hidden = TRUE
	experimental = TRUE
	prereq_ids = list("applied_bluespace")
	design_ids = list(
		"bluespace_miner",
	)

#undef BLUESPACE_MINER_TOO_HOT
#undef BLUESPACE_MINER_LOW_PRESSURE
#undef BLUESPACE_MINER_HIGH_PRESSURE
#undef BLUESPACE_MINER_TOO_CLOSE
