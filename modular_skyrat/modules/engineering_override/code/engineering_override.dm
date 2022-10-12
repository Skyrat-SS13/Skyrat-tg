
/area
	var/engineering_override_eligible = FALSE // Is this area eligible for engineer override?

// Set the areas that will receive expanded access
/area/station/ai_monitored/command/storage/eva
	engineering_override_eligible = TRUE
/area/station/cargo
	engineering_override_eligible = TRUE
/area/station/command/bridge
	engineering_override_eligible = TRUE
/area/station/command/teleporter
	engineering_override_eligible = TRUE
/area/station/command/gateway
	engineering_override_eligible = TRUE
/area/station/construction/storage_wing
	engineering_override_eligible = TRUE
/area/station/engineering/storage/tcomms
	engineering_override_eligible = TRUE
/area/station/hallway/secondary/service
	engineering_override_eligible = TRUE
/area/station/maintenance
	engineering_override_eligible = TRUE
/area/station/medical
	engineering_override_eligible = TRUE
/area/station/service
	engineering_override_eligible = TRUE
/area/station/science
	engineering_override_eligible = TRUE

/obj/machinery/door
	var/engineering_override = FALSE // Can engineers get in on orange alert

// Check for the three states of open access. Emergency, Unrestricted, and Engineering Override
/obj/machinery/door/allowed(mob/M)
	if(emergency)
		return TRUE
	if(unrestricted_side(M))
		return TRUE
	if(engineering_override)
		var/mob/living/carbon/human/user = M
		var/obj/item/card/id/card = user.get_idcard(TRUE)
		if(istype(user))
			if(ACCESS_ENGINEERING in card.access)
				return TRUE
	return ..()

// Activate the airlock overrides, called by the change of alert level
/proc/enable_engineering_access()
	for(var/area/station_area in get_areas(/area/station))
		if(station_area.engineering_override_eligible)
			for(var/obj/machinery/door/airlock/airlock in station_area)
				airlock.engineering_override = TRUE
				airlock.normalspeed = FALSE
				airlock.update_icon(ALL, 0)
	message_admins("Engineering override has been turned ON for station airlocks.")

// Disable the airlock overrides, called by the change of the alert level
/proc/revoke_engineering_access()
	for(var/area/station_area in get_areas(/area/station))
		if(station_area.engineering_override_eligible)
			for(var/obj/machinery/door/airlock/airlock in station_area)
				airlock.engineering_override = FALSE
				airlock.normalspeed = TRUE
				airlock.update_icon(ALL, 0)
	message_admins("Engineering override has been turned OFF for station airlocks.")

// Someone or the AI or silicons tries to change the access on the airlock
/obj/machinery/door/airlock/proc/toggle_engineering(mob/user)
	if(!user_allowed(user))
		return
	engineering_override = !engineering_override
	update_appearance()

// If you try to change it from the UI, verify like anything else
/obj/machinery/door/airlock/ui_act(action, params)
	. = ..()
	if(.)
		return

	if(!user_allowed(usr))
		return
	switch(action)
		if("engineering-toggle")
			toggle_engineering(usr)
			. = TRUE

// Pulse to disable emergency access/engineering override and flash the red lights.
/datum/wires/airlock/on_pulse(wire)
	. = ..()
	var/obj/machinery/door/airlock/A = holder
	switch(wire)
		if(WIRE_IDSCAN)
			if(A.hasPower() && A.density)
				A.do_animate("deny")
				if(A.emergency)
					A.emergency = FALSE
					A.update_appearance()
				if(A.engineering_override)
					A.engineering_override = FALSE
					A.update_appearance()
