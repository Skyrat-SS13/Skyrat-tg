#define CAPACITATOR_MAX_CHARGE 100
/*
 * Continuous puzzles work by requiring to be "fixed" every X amount of time until all other puzzles are solved
 * Continuous are usually fairly easy and exist to ensure teamwork and to keep pressure
*/

/datum/outbound_teamwork_puzzle/continuous
	name = "Generic Continuous"
	/// How much damage dealt to the system by failing
	var/fail_damage = 0

/datum/outbound_teamwork_puzzle/continuous/proc/puzzle_process()
	return

// Capacitator slowly charges, requires a button to be pressed to discharge
/datum/outbound_teamwork_puzzle/continuous/capacitator
	name = "Continuous Capacitator"
	desc = "A capacitator of some shoddy engineering, it falls loose occasionally. Press the \"Clear Charge\" button to prevent it from overcharging and damaging electronics. It fixes itself eventually."
	tgui_name = "CapacitatorPuzzle"
	fail_system = "Power"
	fail_damage = 20
	terminal_name = "capacitator bank"
	terminal_desc = "A small enclave containing a capacitator. It seems loose."
	/// Charge of the capacitator, when it hits 100, effect occurs
	var/capacitator_charge = 0
	/// How much the capacitator increases per process
	var/capacitator_increase = 20

/// Increases/Descreases the amount of charge in the capacitator by `amount`, clamped to 0-100
/datum/outbound_teamwork_puzzle/continuous/capacitator/proc/increase_charge(amount)
	capacitator_charge = clamp(capacitator_charge + amount, 0, 100)

/datum/outbound_teamwork_puzzle/continuous/capacitator/puzzle_process()
	if(!enabled)
		return
	increase_charge(capacitator_increase) //Check if this needs to use delta_time later
	if(capacitator_charge >= CAPACITATOR_MAX_CHARGE)
		addtimer(CALLBACK(src, .proc/fail), 0.5 SECONDS)

/datum/outbound_teamwork_puzzle/continuous/capacitator/fail()
	OUTBOUND_CONTROLLER
	capacitator_charge = 0
	var/datum/outbound_ship_system/selected_sys = outbound_controller.ship_systems[fail_system]
	selected_sys.adjust_health(-fail_damage)
	do_sparks(7, FALSE, terminal)
	for(var/mob/nearby_mob in range(1, terminal))
		electrocute_mob(nearby_mob, get_area(terminal), terminal, 1)
		do_sparks(5, FALSE, nearby_mob)

/datum/outbound_teamwork_puzzle/continuous/capacitator/ui_data(mob/user)
	var/list/data = list()
	data["capacitator_charge"] = capacitator_charge
	return data

/datum/outbound_teamwork_puzzle/continuous/capacitator/ui_act(action, list/params)
	. = ..()

	switch(action)
		if("capacitator_clear")
			capacitator_charge = 0
			terminal.balloon_alert_to_viewers("[terminal_name] discharged", vision_distance = 3)
			return TRUE

#undef CAPACITATOR_MAX_CHARGE
