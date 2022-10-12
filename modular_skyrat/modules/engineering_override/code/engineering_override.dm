/**
 * This module sets airlocks in certain areas to be able to have an Engineer Override on orange alert.
 * Crew with ID cars with the engineering flag will be able to access these areas during those times.
 */

// Is this area eligible for engineer override?
/area
	var/engineering_override_eligible = FALSE

/**
 * Set the areas that will receive expanded access for the engineers on an orange alert
 * Maintenance, bridge, departmental lobbies and inner rooms. No access to security.
 * Sensitive areas like the vault, command quarters, heads' offices, etc. are not applicable.
 */
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

// Var to determine if engineers get in on orange alert
/obj/machinery/door
	var/engineering_override = FALSE

// Check for the three states of open access. Emergency, Unrestricted, and Engineering Override
/obj/machinery/door/allowed(mob/Mob)
	if(emergency)
		return TRUE
	if(unrestricted_side(Mob))
		return TRUE
	if(engineering_override)
		var/mob/living/carbon/human/user = Mob
		var/obj/item/card/id/card = user.get_idcard(TRUE)
		if(istype(user))
			if(ACCESS_ENGINEERING in card.access)
				return TRUE
	return ..()

// Activate the airlock overrides, called by the change of alert level
/proc/enable_engineering_access()
	for(var/area/station_area in get_areas(/area/station))
		if(!station_area.engineering_override_eligible)
			continue
		for(var/obj/machinery/door/airlock/airlock in station_area)
			airlock.engineering_override = TRUE
			airlock.normalspeed = FALSE
			airlock.update_icon(ALL, 0)
	message_admins("Engineering override has been turned ON for station airlocks.")

// Disable the airlock overrides, called by the change of the alert level
/proc/revoke_engineering_access()
	for(var/area/station_area in get_areas(/area/station))
		if(!station_area.engineering_override_eligible)
			continue
		for(var/obj/machinery/door/airlock/airlock in station_area)
			airlock.engineering_override = FALSE
			airlock.normalspeed = TRUE
			airlock.update_icon(ALL, 0)
	message_admins("Engineering override has been turned ON for station airlocks.")

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
			return .

// Pulse to disable emergency access/engineering override and flash the red lights.
/datum/wires/airlock/on_pulse(wire)
	. = ..()
	var/obj/machinery/door/airlock/airlock = holder
	switch(wire)
		if(WIRE_IDSCAN)
			if(airlock.hasPower() && airlock.density)
				airlock.do_animate("deny")
				if(airlock.emergency)
					airlock.emergency = FALSE
					airlock.update_appearance()
				if(airlock.engineering_override)
					airlock.engineering_override = FALSE
					airlock.update_appearance()
