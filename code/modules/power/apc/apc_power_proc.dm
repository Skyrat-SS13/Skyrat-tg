/obj/machinery/power/apc/get_cell()
	return cell

/obj/machinery/power/apc/connect_to_network()
	//Override because the APC does not directly connect to the network; it goes through a terminal.
	//The terminal is what the power computer looks for anyway.
	if(terminal)
		terminal.connect_to_network()

/obj/machinery/power/apc/proc/make_terminal(terminal_cable_layer = cable_layer)
	// create a terminal object at the same position as original turf loc
	// wires will attach to this
	terminal = new/obj/machinery/power/terminal(loc)
	terminal.cable_layer = terminal_cable_layer
	terminal.setDir(dir)
	terminal.master = src

/obj/machinery/power/apc/proc/toggle_nightshift_lights(mob/user)
	if(low_power_nightshift_lights)
		balloon_alert(user, "power is too low!")
		return
	if(last_nightshift_switch > world.time - 10 SECONDS) //~10 seconds between each toggle to prevent spamming
		balloon_alert(user, "night breaker is cycling!")
		return
	last_nightshift_switch = world.time
	set_nightshift(!nightshift_lights)

/obj/machinery/power/apc/proc/update()
	if(operating && !shorted && !failure_timer)
		area.power_light = (lighting > APC_CHANNEL_AUTO_OFF)
		area.power_equip = (equipment > APC_CHANNEL_AUTO_OFF)
		area.power_environ = (environ > APC_CHANNEL_AUTO_OFF)
		playsound(src.loc, 'sound/machines/terminal_on.ogg', 50, FALSE)
	else
		area.power_light = FALSE
		area.power_equip = FALSE
		area.power_environ = FALSE
		playsound(src.loc, 'sound/machines/terminal_off.ogg', 50, FALSE)
	area.power_change()

/obj/machinery/power/apc/proc/toggle_breaker(mob/user)
	if(!is_operational || failure_timer)
		return
	operating = !operating
	if (user)
		var/enabled_or_disabled = operating ? "enabled" : "disabled"
		balloon_alert(user, "power [enabled_or_disabled]")
		user.log_message("turned [enabled_or_disabled] the [src]", LOG_GAME)
		add_hiddenprint(user)
	update()
	update_appearance()

/// Returns the surplus energy from the terminal's grid.
/obj/machinery/power/apc/surplus()
	if(terminal)
		return terminal.surplus()
	return 0

/// Adds load (energy) to the terminal's grid.
/obj/machinery/power/apc/add_load(amount)
	if(terminal?.powernet)
		terminal.add_load(amount)

/// Returns the amount of energy the terminal's grid has.
/obj/machinery/power/apc/avail(amount)
	if(terminal)
		return terminal.avail(amount)
	return 0

/// Returns the surplus energy from the terminal's grid and the cell.
/obj/machinery/power/apc/available_energy()
	return charge() + surplus()

/**
 * Returns the new status value for an APC channel.
 *
 * // val 0=off, 1=off(auto) 2=on 3=on(auto)
 * // on 0=off, 1=on, 2=autooff
 * TODO: Make this use bitflags instead. It should take at most three lines, but it's out of scope for now.
 *
 * Arguments:
 * - val: The current status of the power channel.
 *   - [APC_CHANNEL_OFF]: The APCs channel has been manually set to off. This channel will not automatically change.
 *   - [APC_CHANNEL_AUTO_OFF]: The APCs channel is running on automatic and is currently off. Can be automatically set to [APC_CHANNEL_AUTO_ON].
 *   - [APC_CHANNEL_ON]: The APCs channel has been manually set to on. This will be automatically changed only if the APC runs completely out of power or is disabled.
 *   - [APC_CHANNEL_AUTO_ON]: The APCs channel is running on automatic and is currently on. Can be automatically set to [APC_CHANNEL_AUTO_OFF].
 * - on: An enum dictating how to change the channel's status.
 *   - [AUTOSET_FORCE_OFF]: The APC forces the channel to turn off. This includes manually set channels.
 *   - [AUTOSET_ON]: The APC allows automatic channels to turn back on.
 *   - [AUTOSET_OFF]: The APC turns automatic channels off.
 */
/obj/machinery/power/apc/proc/autoset(val, on)
	switch(on)
		if(AUTOSET_FORCE_OFF)
			if(val == APC_CHANNEL_ON) // if on, return off
				return APC_CHANNEL_OFF
			else if(val == APC_CHANNEL_AUTO_ON) // if auto-on, return auto-off
				return APC_CHANNEL_AUTO_OFF
		if(AUTOSET_ON)
			if(val == APC_CHANNEL_AUTO_OFF) // if auto-off, return auto-on
				return APC_CHANNEL_AUTO_ON
		if(AUTOSET_OFF)
			if(val == APC_CHANNEL_AUTO_ON) // if auto-on, return auto-off
				return APC_CHANNEL_AUTO_OFF
	return val

/**
 * Used by external forces to set the APCs channel status's.
 *
 * Arguments:
 * - val: The desired value of the subsystem:
 *   - 1: Manually sets the APCs channel to be [APC_CHANNEL_OFF].
 *   - 2: Manually sets the APCs channel to be [APC_CHANNEL_AUTO_ON]. If the APC doesn't have any power this defaults to [APC_CHANNEL_OFF] instead.
 *   - 3: Sets the APCs channel to be [APC_CHANNEL_AUTO_ON]. If the APC doesn't have enough power this defaults to [APC_CHANNEL_AUTO_OFF] instead.
 */
/obj/machinery/power/apc/proc/setsubsystem(val)
	if(cell && cell.charge > 0)
		return (val == 1) ? APC_CHANNEL_OFF : val
	if(val == 3)
		return APC_CHANNEL_AUTO_OFF
	return APC_CHANNEL_OFF

/obj/machinery/power/apc/disconnect_terminal()
	if(terminal)
		terminal.master = null
		terminal = null

/obj/machinery/power/apc/proc/energy_fail(duration)
	for(var/obj/machinery/failing_machine in area.contents)
		if(failing_machine.critical_machine)
			return

	for(var/mob/living/silicon/ai as anything in GLOB.ai_list)
		if(get_area(ai) == area)
			return

	failure_timer = max(failure_timer, round(duration))
	update()
	queue_icon_update()

/obj/machinery/power/apc/proc/set_nightshift(on)
	set waitfor = FALSE
	if(low_power_nightshift_lights && !on)
		return
	if(nightshift_lights == on)
		return //no change
	nightshift_lights = on
	for (var/list/zlevel_turfs as anything in area.get_zlevel_turf_lists())
		for(var/turf/area_turf as anything in zlevel_turfs)
			for(var/obj/machinery/light/night_light in area_turf)
				if(night_light.nightshift_allowed)
					night_light.nightshift_enabled = nightshift_lights
					night_light.update(FALSE)
				CHECK_TICK
