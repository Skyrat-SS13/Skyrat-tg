SUBSYSTEM_DEF(machines)
	name = "Machines"
	init_order = INIT_ORDER_MACHINES
	flags = SS_KEEP_TIMING
	wait = 2 SECONDS

	/// Assosciative list of all machines that exist.
	VAR_PRIVATE/list/machines_by_type = list()

	/// All machines, not just those that are processing.
	VAR_PRIVATE/list/all_machines = list()

	var/list/processing = list()
<<<<<<< HEAD
	var/list/currentrun = list()
	var/list/apc_early_processing = list()
	var/list/apc_late_processing = list()
	var/current_part = SSMACHINES_APCS_EARLY
=======
	var/list/processing_early = list()
	var/list/processing_late = list()
	var/list/processing_apcs = list()

	var/list/currentrun = list()
	var/current_part = SSMACHINES_MACHINES_EARLY
	var/list/apc_steps = list(
		SSMACHINES_APCS_EARLY,
		SSMACHINES_APCS_ENVIRONMENT,
		SSMACHINES_APCS_LIGHTS,
		SSMACHINES_APCS_EQUIPMENT,
		SSMACHINES_APCS_LATE
		)
>>>>>>> 5aa4604bce05 (APC and SSmachines hotfixes [NO GBP] (#85043))
	///List of all powernets on the server.
	var/list/datum/powernet/powernets = list()

/datum/controller/subsystem/machines/Initialize()
	makepowernets()
	fire()
	return SS_INIT_SUCCESS

/// Registers a machine with the machine subsystem; should only be called by the machine itself during its creation.
/datum/controller/subsystem/machines/proc/register_machine(obj/machinery/machine)
	LAZYADD(machines_by_type[machine.type], machine)
	all_machines |= machine

/// Removes a machine from the machine subsystem; should only be called by the machine itself inside Destroy.
/datum/controller/subsystem/machines/proc/unregister_machine(obj/machinery/machine)
	var/list/existing = machines_by_type[machine.type]
	existing -= machine
	if(!length(existing))
		machines_by_type -= machine.type
	all_machines -= machine

/// Gets a list of all machines that are either the passed type or a subtype.
/datum/controller/subsystem/machines/proc/get_machines_by_type_and_subtypes(obj/machinery/machine_type)
	if(!ispath(machine_type))
		machine_type = machine_type.type
	if(!ispath(machine_type, /obj/machinery))
		CRASH("called get_machines_by_type_and_subtypes with a non-machine type [machine_type]")
	var/list/machines = list()
	for(var/next_type in typesof(machine_type))
		var/list/found_machines = machines_by_type[next_type]
		if(found_machines)
			machines += found_machines
	return machines


/// Gets a list of all machines that are the exact passed type.
/datum/controller/subsystem/machines/proc/get_machines_by_type(obj/machinery/machine_type)
	if(!ispath(machine_type))
		machine_type = machine_type.type
	if(!ispath(machine_type, /obj/machinery))
		CRASH("called get_machines_by_type with a non-machine type [machine_type]")

	var/list/machines = machines_by_type[machine_type]
	return machines?.Copy() || list()

/datum/controller/subsystem/machines/proc/get_all_machines()
	return all_machines.Copy()

/datum/controller/subsystem/machines/proc/makepowernets()
	for(var/datum/powernet/power_network as anything in powernets)
		qdel(power_network)
	powernets.Cut()

	for(var/obj/structure/cable/power_cable as anything in GLOB.cable_list)
		if(!power_cable.powernet)
			var/datum/powernet/new_powernet = new()
			new_powernet.add_cable(power_cable)
			propagate_network(power_cable, power_cable.powernet)

/datum/controller/subsystem/machines/stat_entry(msg)
	msg = "M:[length(all_machines)]|MT:[length(machines_by_type)]|PM:[length(processing)]|PN:[length(powernets)]"
	return ..()

/datum/controller/subsystem/machines/fire(resumed = FALSE)
	if (!resumed)
		for(var/datum/powernet/powernet as anything in powernets)
			powernet.reset() //reset the power state.
<<<<<<< HEAD
		current_part = SSMACHINES_APCS_EARLY
		src.currentrun = apc_early_processing.Copy()

	//APC early processing. Draws static power usages from their grids.
	if(current_part == SSMACHINES_APCS_EARLY)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		while(currentrun.len)
			var/obj/machinery/power/apc/apc = currentrun[currentrun.len]
			currentrun.len--
			if(QDELETED(apc) || apc.early_process(wait * 0.1) == PROCESS_KILL)
				apc_early_processing -= apc
				apc.datum_flags &= ~DF_ISPROCESSING
			if(MC_TICK_CHECK)
				return
		current_part = SSMACHINES_MACHINES
		src.currentrun = processing.Copy()

	//General machine processing. Their power usage can be dynamic and based on surplus power, so they come after static power usage have been applied.
	if(current_part == SSMACHINES_MACHINES)
=======
		current_part = SSMACHINES_MACHINES_EARLY
		src.currentrun = processing_early.Copy()

	//Processing machines that get the priority power draw
	if(current_part == SSMACHINES_MACHINES_EARLY)
>>>>>>> 5aa4604bce05 (APC and SSmachines hotfixes [NO GBP] (#85043))
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		while(currentrun.len)
			var/obj/machinery/thing = currentrun[currentrun.len]
			currentrun.len--
			if(QDELETED(thing) || thing.process_early(wait * 0.1) == PROCESS_KILL)
				processing_early -= thing
				thing.datum_flags &= ~DF_ISPROCESSING
			if (MC_TICK_CHECK)
				return
		current_part = SSMACHINES_APCS_LATE
		src.currentrun = apc_late_processing.Copy()

	//APC late processing. APCs will use the remaining power on the grid to charge their cells if needed.
	//This is applied at the end so charging APCs don't cause others to discharge by taking all the power from the grid before machines use power.
	if(current_part == SSMACHINES_APCS_LATE)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		while(currentrun.len)
			var/obj/machinery/power/apc/apc = currentrun[currentrun.len]
			currentrun.len--
			if(QDELETED(apc) || apc.late_process(wait * 0.1) == PROCESS_KILL)
				apc_late_processing -= apc
				apc.datum_flags &= ~DF_ISPROCESSING
			if(MC_TICK_CHECK)
				return
<<<<<<< HEAD
=======
		var/next_index = apc_steps.Find(current_part) + 1
		if (next_index > apc_steps.len)
			current_part = SSMACHINES_MACHINES
			src.currentrun = processing.Copy()
			break
		current_part = apc_steps[next_index]
		src.currentrun = processing_apcs.Copy()
>>>>>>> 5aa4604bce05 (APC and SSmachines hotfixes [NO GBP] (#85043))

	//Processing all machines
	if(current_part == SSMACHINES_MACHINES)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		while(currentrun.len)
			var/obj/machinery/thing = currentrun[currentrun.len]
			currentrun.len--
			if(QDELETED(thing) || thing.process(wait * 0.1) == PROCESS_KILL)
				processing -= thing
				thing.datum_flags &= ~DF_ISPROCESSING
			if (MC_TICK_CHECK)
				return
		current_part = SSMACHINES_MACHINES_LATE
		src.currentrun = processing_late.Copy()

	//Processing machines that record the power usage statistics
	if(current_part == SSMACHINES_MACHINES_LATE)
		//cache for sanic speed (lists are references anyways)
		var/list/currentrun = src.currentrun
		while(currentrun.len)
			var/obj/machinery/thing = currentrun[currentrun.len]
			currentrun.len--
			if(QDELETED(thing) || thing.process_late(wait * 0.1) == PROCESS_KILL)
				processing_late -= thing
				thing.datum_flags &= ~DF_ISPROCESSING
			if (MC_TICK_CHECK)
				return

/datum/controller/subsystem/machines/proc/setup_template_powernets(list/cables)
	var/obj/structure/cable/PC
	for(var/A in 1 to cables.len)
		PC = cables[A]
		if(!PC.powernet)
			var/datum/powernet/NewPN = new()
			NewPN.add_cable(PC)
			propagate_network(PC,PC.powernet)

/datum/controller/subsystem/machines/Recover()
	if(islist(SSmachines.processing))
		processing = SSmachines.processing
	if(islist(SSmachines.powernets))
		powernets = SSmachines.powernets
	if(islist(SSmachines.all_machines))
		all_machines = SSmachines.all_machines
	if(islist(SSmachines.machines_by_type))
		machines_by_type = SSmachines.machines_by_type
