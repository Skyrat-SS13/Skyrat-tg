///Proc which lets an admin activate the delam suppression system
/client/proc/try_stop_delam()
	set name = "Delam Emergency Stop"
	set category = "Admin.Events"
	var/obj/machinery/atmospherics/components/unary/delam_scram/suppression_system = null

	if(!holder || !check_rights(R_FUN))
		return

	for(var/obj/machinery/atmospherics/components/unary/delam_scram/system in GLOB.machines)
		if(!suppression_system)
			suppression_system = system
		else
			message_admins("Delam SCRAM failed: Multiple Delam SCRAM units found on map! Someone should fix that.")
			stack_trace("Multiple Delam SCRAM units found on map! They should be unique, yell at a mapper!") // We could fire anyways, but who knows where the mystery extra machine(s) are.
			return

	if(!suppression_system)
		message_admins("Delam SCRAM failed: No active delam SCRAM units found on map! Either it's not mapped or it's already been used!")
		return

	if(suppression_system.on)
		message_admins("Delam SCRAM failed: It's already been triggered!")
		return

	if(world.time - SSticker.round_start_time < 30 MINUTES)
		var/go_early = tgui_alert(usr, "The [suppression_system.name] is set to automatically start at the programmed time. \
			Are you sure you want to override this and fire it early? It's less scary that way.", "Suffering premature delamination?", list("No", "Yes"))
		if(!go_early || go_early == "No")
			return FALSE

	var/double_check = tgui_alert(usr, "You really sure that you want to push this?", "Reticulating Splines", list("No", "Yes"))
	if(!double_check || double_check == "No")
		return FALSE

	log_admin("[key_name_admin(usr)] started a supermatter emergency stop!")
	message_admins("[ADMIN_LOOKUPFLW(usr)] started a supermatter emergency stop! [ADMIN_COORDJMP(suppression_system)]")
	suppression_system.investigate_log("[key_name_admin(usr)] started a supermatter emergency stop!", INVESTIGATE_ATMOS)
	SEND_GLOBAL_SIGNAL(COMSIG_MAIN_SM_DELAMINATING, DIVINE_INTERVENTION)
	for(var/obj/machinery/door/airlock/escape_route in range(14, suppression_system)) // a little more space here due to positioning
		if(istype(escape_route, /obj/machinery/door/airlock/command))
			continue
		INVOKE_ASYNC(escape_route, TYPE_PROC_REF(/obj/machinery/door/airlock, temp_emergency_exit), 45 SECONDS)

	notify_ghosts(
		"The [suppression_system] has been activated!",
		source = suppression_system,
		header = "Divine Intervention",
		action = NOTIFY_ORBIT,
		ghost_sound = 'sound/machines/warning-buzzer.ogg',
		notify_volume = 75
	)
