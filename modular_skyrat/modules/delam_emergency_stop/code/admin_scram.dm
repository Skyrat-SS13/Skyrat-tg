/// Lets an admin activate the delam suppression system
ADMIN_VERB(try_stop_delam, R_ADMIN, "Delam Emergency Stop", "Activate the delam suppression system.", ADMIN_CATEGORY_EVENTS)
	var/obj/machinery/atmospherics/components/unary/delam_scram/suppression_system = null

	suppression_system = validate_suppression_status()

	if(!suppression_system)
		return

	// Warn them if they're intervening in the work of God
	if(world.time - SSticker.round_start_time < 30 MINUTES)
		var/go_early = tgui_alert(user, "The [suppression_system.name] is set to automatically start at the programmed time. \
			Are you sure you want to override this and fire it early? It's less scary that way.", "Suffering premature delamination?", list("No", "Yes"))
		if(go_early != "Yes")
			return FALSE

	var/double_check = tgui_alert(user, "You really sure that you want to push this?", "Reticulating Splines", list("No", "Yes"))
	if(double_check != "Yes")
		return FALSE

	// Send the signal to start, unlock the temp emergency exits
	log_admin("[key_name_admin(user)] started a supermatter emergency stop!")
	message_admins("[ADMIN_LOOKUPFLW(user)] started a supermatter emergency stop! [ADMIN_COORDJMP(suppression_system)]")
	suppression_system.investigate_log("[key_name_admin(user)] started a supermatter emergency stop!", INVESTIGATE_ATMOS)
	SEND_GLOBAL_SIGNAL(COMSIG_MAIN_SM_DELAMINATING, DIVINE_INTERVENTION)
	for(var/obj/machinery/door/airlock/escape_route in range(14, suppression_system)) // a little more space here due to positioning
		if(istype(escape_route, /obj/machinery/door/airlock/command))
			continue
		INVOKE_ASYNC(escape_route, TYPE_PROC_REF(/obj/machinery/door/airlock, temp_emergency_exit), 45 SECONDS)

/// Lets admins disable/enable the delam suppression system
ADMIN_VERB(toggle_delam_suppression, R_FUN, "Delam Suppression Toggle", "Disable/enable the delam suppression system.", ADMIN_CATEGORY_EVENTS)
	user.mob.client?.toggle_delam_suppression()

/client/proc/toggle_delam_suppression()
	var/obj/machinery/atmospherics/components/unary/delam_scram/suppression_system = validate_suppression_status()

	if(!suppression_system)
		return

	suppression_system.admin_disabled = !suppression_system.admin_disabled

	log_admin("[key_name_admin(usr)] toggled Delam suppression [suppression_system.admin_disabled ? "OFF" : "ON"].")
	message_admins("[key_name_admin(usr)] toggled Delam suppression [suppression_system.admin_disabled ? "OFF" : "ON"].")

/// Check if the delam suppression setup is valid on the map
/proc/validate_suppression_status()
	var/obj/machinery/atmospherics/components/unary/delam_scram/my_one_and_only = null
	for(var/obj/machinery/atmospherics/components/unary/delam_scram/system as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/atmospherics/components/unary/delam_scram))
		if(!my_one_and_only)
			my_one_and_only = system
		else
			message_admins("Delam suppression request FAILED: Multiple Delam SCRAM units found on map! Delete the extra unit at [ADMIN_COORDJMP(system)] if applicable and try again.")
			stack_trace("Multiple Delam SCRAM units found on map at [system.loc]. Either someone spawned in a duplicate or you need to yell at a mapper!") // We could fire anyways, but who knows where the mystery extra machine(s) are.
			return FALSE

	if(!my_one_and_only)
		message_admins("No active delam SCRAM units found on map! Either it's not mapped or it's already been used!")
		return FALSE

	if(my_one_and_only.on)
		message_admins("[my_one_and_only] can't fire, it's already been triggered!")
		return FALSE

	return my_one_and_only
