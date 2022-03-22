#define SHUTTLE_MASS_DIVISOR 10 //The shuttle mass is divided by this when calculating mass.

/datum/overmap_object/shuttle
	name = "Shuttle"
	visual_type = /obj/effect/abstract/overmap/shuttle
	overmap_process = TRUE

	var/obj/docking_port/mobile/my_shuttle
	var/datum/transit_instance/transit_instance
	var/angle = 0

	var/velocity_x = 0
	var/velocity_y = 0

	var/impulse_power = 1

	var/helm_command = HELM_IDLE
	var/destination_x = 0
	var/destination_y = 0

	/// Otherwise it's abstract and it doesnt have a physical shuttle in transit, or people in it. Maintain this for the purposes of AI raid ships
	var/is_physical = TRUE

	/// If true then it doesn't have a "shuttle" and is not alocated in transit and cannot dock anywhere, but things may dock into it
	var/is_seperate_z_level = FALSE //(This can mean it's several z levels too)

	/// For sensors lock follow
	var/follow_range = 1

	var/shuttle_ui_tab = SHUTTLE_TAB_GENERAL

	/// At which offset range the helm pad will apply at
	var/helm_pad_range = 3
	/// If true, then the applied offsets will be relative to the ship position, instead of direction position
	var/helm_pad_relative_destination = TRUE

	var/helm_pad_engage_immediately = TRUE

	var/open_comms_channel = FALSE
	var/microphone_muted = FALSE

	var/datum/overmap_lock/lock

	var/target_command = TARGET_IDLE

	var/datum/overmap_shuttle_controller/shuttle_controller
	var/uses_rotation = TRUE
	var/fixed_parallax_dir
	var/shuttle_capability = ALL_SHUTTLE_CAPABILITY

	//Extensions
	var/list/all_extensions = list()
	var/list/engine_extensions = list()
	var/list/shield_extensions = list()
	var/list/transporter_extensions = list()
	var/list/weapon_extensions = list()

	var/speed_divisor_from_mass = 1

	//Turf to which you need access range to access in order to do topics (this is done in this way so I dont need to keep track of consoles being in use)
	var/turf/control_turf

	var/last_shield_change_state = 0

	var/current_parallax_dir = 0

	/// Do we send sounds to the consoles or the entire z-level?
	var/z_alert_sounds = FALSE

/datum/overmap_object/shuttle/GetAllAliveClientMobs()
	. = list()
	if(my_shuttle)
		//About the most efficient way I could think of doing it
		var/datum/space_level/transit_level = SSmapping.transit
		for(var/i in SSmobs.clients_by_zlevel[transit_level.z_value])
			var/mob/iterated_mob = i
			var/turf/mob_turf = get_turf(iterated_mob)
			if(my_shuttle.shuttle_areas[mob_turf.loc])
				. += iterated_mob
	else
		. = ..()

/datum/overmap_object/shuttle/GetAllClientMobs()
	if(my_shuttle)
		. = list()
		//About the most efficient way I could think of doing it
		var/datum/space_level/transit_level = SSmapping.transit
		for(var/i in SSmobs.dead_players_by_zlevel[transit_level.z_value])
			var/mob/iterated_mob = i
			var/turf/mob_turf = get_turf(iterated_mob)
			if(my_shuttle.shuttle_areas[mob_turf.loc])
				. += iterated_mob
	else
		. = ..()

/datum/overmap_object/shuttle/proc/GetSensorTargets()
	var/list/targets = list()
	for(var/ov_obj in current_system.GetObjectsInRadius(x,y,SENSOR_RADIUS))
		var/datum/overmap_object/overmap_object = ov_obj
		if(overmap_object != src && overmap_object.overmap_flags & OV_SHOWS_ON_SENSORS)
			targets += overmap_object
	return targets

/datum/overmap_object/shuttle/proc/GetCapSpeed()
	var/cap_speed = 0
	var/shuttle_mass = GetShuttleMass()
	for(var/i in engine_extensions)
		var/datum/shuttle_extension/engine/ext = i
		if(!ext.CanOperate())
			continue
		cap_speed += ext.GetCapSpeed(impulse_power)
	return cap_speed / shuttle_mass

/datum/overmap_object/shuttle/proc/GetShuttleMass()
	var/shuttle_mass = 0
	if(my_shuttle)
		for(var/area/iterating_area as anything in my_shuttle.shuttle_areas)
			for(var/turf/closed/wall in iterating_area)
				shuttle_mass += 1
		return shuttle_mass / SHUTTLE_MASS_DIVISOR
	return speed_divisor_from_mass


/datum/overmap_object/shuttle/proc/DrawThrustFromAllEngines()
	var/draw_thrust = 0
	for(var/i in engine_extensions)
		var/datum/shuttle_extension/engine/ext = i
		if(!ext.CanOperate())
			continue
		draw_thrust += ext.DrawThrust(impulse_power)
	return draw_thrust / speed_divisor_from_mass

/datum/overmap_object/shuttle/proc/DisplayUI(mob/user, turf/usage_turf)
	if(usage_turf)
		control_turf = usage_turf
	var/list/dat = list()

	dat += "<center><a href='?src=[REF(src)];task=tab;tab=0' [shuttle_ui_tab == 0 ? "class='linkOn'" : ""]>General</a>"
	if(shuttle_capability & SHUTTLE_CAN_USE_ENGINES)
		dat += "<a href='?src=[REF(src)];task=tab;tab=1' [shuttle_ui_tab == 1 ? "class='linkOn'" : ""]>Engines</a>"
		dat += "<a href='?src=[REF(src)];task=tab;tab=2' [shuttle_ui_tab == 2 ? "class='linkOn'" : ""]>Helm</a>"
	if(shuttle_capability & SHUTTLE_CAN_USE_SENSORS)
		dat += "<a href='?src=[REF(src)];task=tab;tab=3' [shuttle_ui_tab == 3 ? "class='linkOn'" : ""]>Sensors</a>"
		if(shuttle_capability & SHUTTLE_CAN_USE_TARGET)
			dat += "<a href='?src=[REF(src)];task=tab;tab=4' [shuttle_ui_tab == 4 ? "class='linkOn'" : ""]>Target</a>"
	if(shuttle_capability & SHUTTLE_CAN_USE_DOCK)
		dat += "<a href='?src=[REF(src)];task=tab;tab=5' [shuttle_ui_tab == 5 ? "class='linkOn'" : ""]>Dock</a>"
	dat += " <a href='?src=[REF(src)];task=refresh'>Refresh</a></center><HR>"

	switch(shuttle_ui_tab)
		if(SHUTTLE_TAB_GENERAL)
			var/shield_engaged = IsShieldOn()
			dat += "Hull: 100% integrity"
			if(length(shield_extensions))
				dat += "<BR>Shields: [GetShieldPercent()*100]% <a href='?src=[REF(src)];task=general;general_control=shields' [shield_engaged ? "class='linkOn'" : ""]>[shield_engaged ? "Engaged" : "Disengaged"]</a>"
			else
				dat += "<BR>Shields: Not installed"
			dat += "<BR>Position: X: [x] , Y: [y]"
			dat += "<BR>Overmap View: <a href='?src=[REF(src)];task=general;general_control=overmap'>Open</a>"
			dat += "<BR>Send a Hail: <a href='?src=[REF(src)];task=general;general_control=hail'>Send...</a>"
			dat += "<BR>Communications Channel: <a href='?src=[REF(src)];task=general;general_control=comms' [open_comms_channel ? "class='linkOn'" : ""]>[open_comms_channel ? "Open" : "Closed"]</a> - Microphone: <a href='?src=[REF(src)];task=general;general_control=microphone_muted' [microphone_muted ? "" : "class='linkOn'"]>[microphone_muted ? "Muted" : "Open"]</a>"

		if(SHUTTLE_TAB_ENGINES)
			if(engine_extensions.len == 0)
				dat += "<B>No engines installed.</B>"
			else
				dat += "<a href='?src=[REF(src)];task=engines;engines_control=all_on'>All On</a><a href='?src=[REF(src)];task=engines;engines_control=all_off'>All Off</a><a href='?src=[REF(src)];task=engines;engines_control=all_efficiency'>Set All Efficiency</a><HR>"
				var/iterator = 0
				for(var/i in engine_extensions)
					iterator++
					var/datum/shuttle_extension/engine/engine_ext = i
					var/can_operate = engine_ext.CanOperate()
					var/fuel_percent = "[(engine_ext.current_fuel / engine_ext.maximum_fuel)*100]%"
					var/efficiency_percent = "[engine_ext.current_efficiency*100]%"
					dat += "<B>Engine [iterator]</B>: [engine_ext.name] - <a href='?src=[REF(src)];task=engines;engines_control=toggle_online;engine_index=[iterator]' [engine_ext.turned_on ? "class='linkOn'" : ""]>[engine_ext.turned_on ? "Online" : "Offline"]</a>"
					dat += "<BR>Efficiency: <a href='?src=[REF(src)];task=engines;engines_control=set_efficiency;engine_index=[iterator]'>[efficiency_percent]</a>"
					dat += "<BR>Fuel: [fuel_percent]"
					dat += "<BR>Status: [can_operate ? "Nominal" : "Not Functioning"]"
					dat += "<HR>"


		if(SHUTTLE_TAB_HELM)
			dat += "<B>Command: "
			switch(helm_command)
				if(HELM_IDLE)
					dat += "Idle.</B>"
				if(HELM_FULL_STOP)
					dat += "Full stop.</B>"
				if(HELM_MOVE_TO_DESTINATION)
					dat += "Move to destination.</B>"
				if(HELM_TURN_TO_DESTINATION)
					dat += "Turn to destination.</B>"
				if(HELM_FOLLOW_SENSOR_LOCK)
					dat += "Follow sensor lock.</B>"
				if(HELM_TURN_TO_SENSOR_LOCK)
					dat += "Turn to sensor lock.</B>"

			dat += "<BR>Position: X: [x] , Y: [y]"
			dat += "<BR>Destination: "
			dat += "X: <a href='?src=[REF(src)];task=helm;helm_control=change_x'>[destination_x]</a>"
			dat += " , Y: <a href='?src=[REF(src)];task=helm;helm_control=change_y'>[destination_y]</a>"
			var/cur_speed = VECTOR_LENGTH(velocity_x, velocity_y)
			dat += "<BR>Current speed: [cur_speed]"
			dat += "<BR> - Impulse Power: <a href='?src=[REF(src)];task=helm;helm_control=change_impulse_power'>[impulse_power*100]%</a>"
			dat += "<BR> - Top speed: [GetCapSpeed()]"
			if(engine_extensions.len == 0)
				dat += "<BR><B>No engines installed.</B>"
			else
				dat += "<BR>Commands:"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_stop'>Full Stop</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_move_dest'>Move to Destination</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_turn_dest'>Turn to Destination</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_follow_sensor'>Follow Sensor Lock</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_turn_sensor'>Turn to Sensor Lock</a>"
				dat += "<BR> - <a href='?src=[REF(src)];task=helm;helm_control=command_idle'>Idle</a>"
				dat += "<BR>Pad Control: <a href='?src=[REF(src)];task=helm;helm_control=pad'>Open</a>"

		if(SHUTTLE_TAB_SENSORS)
			var/list/targets = GetSensorTargets()
			dat += "<table align='center'; width='100%'; height='100%'; style='background-color:#13171C'>"
			dat += "<tr style='vertical-align:top'>"
			dat += "<td width=30%>Name:</td>"
			dat += "<td width=10%>X:</td>"
			dat += "<td width=10%>Y:</td>"
			dat += "<td width=10%>Dist:</td>"
			dat += "<td width=40%>Actions:</td>"
			dat += "</tr>"
			var/even = TRUE
			for(var/ov_obj in targets)
				even = !even
				var/datum/overmap_object/overmap_obj = ov_obj
				var/dist = FLOOR(TWO_POINT_DISTANCE(x,y,overmap_obj.x,overmap_obj.y),1)
				var/is_destination = (destination_x == overmap_obj.x && destination_y == overmap_obj.y)
				var/is_target = (lock && lock.target == overmap_obj)
				dat += "<tr style='background-color: [even ? "#17191C" : "#23273C"];'>"
				dat += "<td>[overmap_obj.name]</td>"
				dat += "<td>[overmap_obj.x]</td>"
				dat += "<td>[overmap_obj.y]</td>"
				dat += "<td>[dist]</td>"
				dat += "<td>"
				var/in_lock_range = IN_LOCK_RANGE(src,overmap_obj)
				if(shuttle_capability & SHUTTLE_CAN_USE_TARGET)
					dat += "<a href='?src=[REF(src)];task=sensor;sensor_task=target;target_id=[overmap_obj.id]'[in_lock_range ? "" : "class='linkOff'"][is_target ? "class='linkOn'" : ""]>Target</a>"
				if(shuttle_capability & SHUTTLE_CAN_USE_ENGINES)
					dat += "<a href='?src=[REF(src)];task=sensor;sensor_task=destination;target_id=[overmap_obj.id]' [is_destination ? "class='linkOn'" : ""]>As Dest.</a>"
				dat += "</td></tr>"
			dat += "</table>"

		if(SHUTTLE_TAB_TARGET)
			var/locked_thing_name = lock ? lock.target.name : "NONE"
			var/locked_status = "NOT ENGAGED"
			var/locked_and_calibrated = FALSE
			if(lock)
				if(lock.is_calibrated)
					locked_and_calibrated = TRUE
					locked_status = "LOCKED"
				else
					locked_status = "CALIBRATING"

			dat += "Target: [locked_thing_name]"
			dat	+= "<BR>Lock status: [locked_status] [lock ? "<a href='?src=[REF(src)];task=target;target_control=disengage_lock'>Disengage</a>" : ""]"
			dat	+= "<BR><B>Current Command:</B> "
			switch(target_command)
				if(TARGET_IDLE)
					dat	+= "Idle."
				if(TARGET_FIRE_ONCE)
					dat	+= "Fire Once!"
				if(TARGET_KEEP_FIRING)
					dat	+= "Keep Firing!"
				if(TARGET_SCAN)
					dat	+= "Scan."
				if(TARGET_BEAM_ON_BOARD)
					dat	+= "Beam on board."
			dat += "<BR>Commands:"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_idle' [locked_and_calibrated ? "" : "class='linkOff'"]>Idle</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_fire_once' [locked_and_calibrated ? "" : "class='linkOff'"]>Fire Once!</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_keep_firing' [locked_and_calibrated ? "" : "class='linkOff'"]>Keep Firing!</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_scan' [locked_and_calibrated ? "" : "class='linkOff'"]>Scan</a>"
			dat += "<BR> - <a href='?src=[REF(src)];task=target;target_control=command_beam_on_board' [locked_and_calibrated ? "" : "class='linkOff'"]>Beam on Board</a>"

		if(SHUTTLE_TAB_DOCKING)
			if(!my_shuttle || is_seperate_z_level)
				return
			if(VECTOR_LENGTH(velocity_x, velocity_y) > SHUTTLE_MAXIMUM_DOCKING_SPEED)
				dat += "<B>Cannot safely dock in high velocities!</B>"
			else
				var/list/z_levels = list()
				var/list/nearby_objects = current_system.GetObjectsOnCoords(x,y)
				var/list/freeform_z_levels = list()
				for(var/i in nearby_objects)
					var/datum/overmap_object/IO = i
					for(var/level in IO.related_levels)
						var/datum/space_level/iterated_space_level = level
						z_levels["[iterated_space_level.z_value]"] = TRUE
						if(IO.allow_freeform_docking)
							freeform_z_levels["[iterated_space_level.name] - Freeform"] = iterated_space_level.z_value

				var/list/obj/docking_port/stationary/docks = list()
				var/list/obj/docking_port/stationary/gateway/gateways = list()
				var/list/options = params2list(my_shuttle.possible_destinations)
				for(var/i in SSshuttle.stationary_docking_ports)
					var/obj/docking_port/stationary/iterated_dock = i
					if(!z_levels["[iterated_dock.z]"])
						continue
					if(!options.Find(iterated_dock.port_destinations))
						continue
					if(!my_shuttle.check_dock(iterated_dock, silent = TRUE))
						continue
					if(istype(iterated_dock, /obj/docking_port/stationary/gateway))
						gateways[iterated_dock.name] = iterated_dock
						continue
					docks[iterated_dock.name] = iterated_dock

				dat += "<B>Designated docks:</B>"
				for(var/key in docks)
					dat += "<BR> - [key] - <a href='?src=[REF(src)];task=dock;dock_control=normal_dock;dock_id=[docks[key].id]'>Dock</a>"

				if(gateways.len)
					dat += "<BR><BR><B>Wormhole Entries:</B>"
					for(var/key in gateways)
						dat += "<BR> - [key] - <a href='?src=[REF(src)];task=dock;dock_control=gateway_dock;dock_id=[gateways[key].id]'>Enter Wormhole</a>"

				if(freeform_z_levels.len)
					dat += "<BR><BR><B>Freeform docking spaces:</B>"
					for(var/key in freeform_z_levels)
						dat += "<BR> - [key] - <a href='?src=[REF(src)];task=dock;dock_control=freeform_dock;z_value=[freeform_z_levels[key]]'>Designate Location</a>"


	var/datum/browser/popup = new(user, "overmap_shuttle_control", "Shuttle Control", 400, 440)
	popup.set_content(dat.Join())
	popup.open()

/datum/overmap_object/shuttle/proc/DisplayHelmPad(mob/user)
	var/list/dat = list("<center>")
	dat += "<a href='?src=[REF(src)];pad_topic=nw'>O</a><a href='?src=[REF(src)];pad_topic=n'>O</a><a href='?src=[REF(src)];pad_topic=ne'>O</a>"
	dat += "<BR><a href='?src=[REF(src)];pad_topic=w'>O</a><a href='?src=[REF(src)];pad_topic=stop'>O</a><a href='?src=[REF(src)];pad_topic=e'>O</a>"
	dat += "<BR><a href='?src=[REF(src)];pad_topic=sw'>O</a><a href='?src=[REF(src)];pad_topic=s'>O</a><a href='?src=[REF(src)];pad_topic=se'>O</a></center>"
	dat += "<BR>Pad Range: <a href='?src=[REF(src)];pad_topic=range'>[helm_pad_range]</a>"
	dat += "<BR>Relative Destination: <a href='?src=[REF(src)];pad_topic=relative_dir'>[helm_pad_relative_destination ? "Yes" : "No"]</a>"
	dat += "<BR>Engage Immediately: <a href='?src=[REF(src)];pad_topic=engage_immediately'>[helm_pad_engage_immediately ? "Yes" : "No"]</a>"
	dat += "<BR>Pos.: X: [x] , Y: [y]"
	dat += " | Dest.: X: [destination_x] , Y: [destination_y]"
	dat += "<BR><center><a href='?src=[REF(src)];pad_topic=engage'>Engage</a></center>"
	var/datum/browser/popup = new(user, "overmap_helm_pad", "Helm Pad Control", 250, 250)
	popup.set_content(dat.Join())
	popup.open()

/datum/overmap_object/shuttle/proc/InputHelmPadDirection(input_x = 0, input_y = 0)
	if(!input_x && !input_y)
		StopMove()
		return
	if(helm_pad_relative_destination)
		destination_x = x
		destination_y = y
	if(input_x)
		destination_x += input_x * helm_pad_range
		destination_x = clamp(destination_x, 1, current_system.maxx)
	if(input_y)
		destination_y += input_y * helm_pad_range
		destination_y = clamp(destination_y, 1, current_system.maxy)
	if(helm_pad_engage_immediately)
		helm_command = HELM_MOVE_TO_DESTINATION
	return

/datum/overmap_object/shuttle/proc/LockLost()
	target_command = TARGET_IDLE

/datum/overmap_object/shuttle/proc/SetLockTo(datum/overmap_object/ov_obj)
	if(lock)
		if(ov_obj == lock.target)
			return
		else
			QDEL_NULL(lock)
	if(ov_obj && IN_LOCK_RANGE(src,ov_obj))
		lock = new(src, ov_obj)

/datum/overmap_object/shuttle/Topic(href, href_list)
	if(!control_turf)
		return
	var/mob/user = usr
	if(!isliving(user) || !user.canUseTopic(control_turf, BE_CLOSE, FALSE, NO_TK))
		return
	if(href_list["pad_topic"])
		if(!(shuttle_capability & SHUTTLE_CAN_USE_ENGINES))
			return
		switch(href_list["pad_topic"])
			if("nw")
				InputHelmPadDirection(-1, 1)
			if("n")
				InputHelmPadDirection(0, 1)
			if("ne")
				InputHelmPadDirection(1, 1)
			if("w")
				InputHelmPadDirection(-1, 0)
			if("e")
				InputHelmPadDirection(1, 0)
			if("sw")
				InputHelmPadDirection(-1, -1)
			if("s")
				InputHelmPadDirection(0, -1)
			if("se")
				InputHelmPadDirection(1, -1)
			if("stop")
				InputHelmPadDirection()
			if("engage")
				helm_command = HELM_MOVE_TO_DESTINATION
			if("range")
				var/new_range = input(usr, "Choose new pad range", "Helm Pad Control", helm_pad_range) as num|null
				if(new_range)
					helm_pad_range = new_range
			if("relative_dir")
				helm_pad_relative_destination = !helm_pad_relative_destination
			if("engage_immediately")
				helm_pad_engage_immediately = !helm_pad_engage_immediately
		DisplayHelmPad(usr)
		return
	switch(href_list["task"])
		if("tab")
			shuttle_ui_tab = text2num(href_list["tab"])
		if("engines")
			switch(href_list["engines_control"])
				if("all_on")
					for(var/i in engine_extensions)
						var/datum/shuttle_extension/engine/ext = i
						ext.turned_on = TRUE
				if("all_off")
					for(var/i in engine_extensions)
						var/datum/shuttle_extension/engine/ext = i
						ext.turned_on = FALSE
				if("all_efficiency")
					var/new_eff = input(usr, "Choose new efficiency", "Engine Control") as num|null
					if(new_eff)
						var/new_value = clamp((new_eff/100),0,1)
						for(var/i in engine_extensions)
							var/datum/shuttle_extension/engine/ext = i
							ext.current_efficiency = new_value
				if("toggle_online")
					var/index = text2num(href_list["engine_index"])
					if(length(engine_extensions) < index)
						return
					var/datum/shuttle_extension/engine/ext = engine_extensions[index]
					ext.turned_on = !ext.turned_on
				if("set_efficiency")
					var/new_eff = input(usr, "Choose new efficiency", "Engine Control") as num|null
					if(new_eff)
						var/index = text2num(href_list["engine_index"])
						if(length(engine_extensions) < index)
							return
						var/datum/shuttle_extension/engine/ext = engine_extensions[index]
						ext.current_efficiency = clamp((new_eff/100),0,1)
		if("dock")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_DOCK))
				return
			if(VECTOR_LENGTH(velocity_x, velocity_y) > SHUTTLE_MAXIMUM_DOCKING_SPEED)
				return
			switch(href_list["dock_control"])
				if("normal_dock")
					if(shuttle_controller.busy)
						return
					var/dock_id = href_list["dock_id"]
					var/obj/docking_port/stationary/target_dock = SSshuttle.getDock(dock_id)
					if(!target_dock)
						return
					var/datum/space_level/level_of_dock = SSmapping.z_list[target_dock.z]
					var/datum/overmap_object/dock_overmap_object = level_of_dock.related_overmap_object
					if(!dock_overmap_object)
						return
					if(!current_system.ObjectsAdjacent(src, dock_overmap_object))
						return
					switch(SSshuttle.moveShuttle(my_shuttle.id, dock_id, 1))
						if(0)
							shuttle_controller.busy = TRUE
							shuttle_controller.RemoveCurrentControl()
							playsound(control_turf, 'modular_skyrat/modules/overmap/sound/shuttle_voice/landing.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)
				if("freeform_dock")
					if(shuttle_controller.busy)
						return
					if(shuttle_controller.freeform_docker)
						return
					var/z_level = text2num(href_list["z_value"])
					if(!z_level)
						return
					var/datum/space_level/level_to_freeform = SSmapping.z_list[z_level]
					if(!level_to_freeform)
						return
					var/datum/overmap_object/level_overmap_object = level_to_freeform.related_overmap_object
					if(!level_overmap_object)
						return
					if(!current_system.ObjectsAdjacent(src, level_overmap_object))
						return
					if(!level_overmap_object.allow_freeform_docking)
						return
					shuttle_controller.SetController(usr)
					shuttle_controller.freeform_docker = new /datum/shuttle_freeform_docker(shuttle_controller, usr, z_level)
					playsound(control_turf, 'modular_skyrat/modules/overmap/sound/shuttle_voice/landing.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)
				if("gateway_dock")
					if(shuttle_controller.busy)
						return
					var/dock_id = href_list["dock_id"]
					var/obj/docking_port/stationary/target_dock = SSshuttle.getDock(dock_id)
					if(!target_dock)
						return
					var/datum/space_level/level_of_dock = SSmapping.z_list[target_dock.z]
					var/datum/overmap_object/dock_overmap_object = level_of_dock.related_overmap_object
					if(!dock_overmap_object)
						return
					if(!current_system.ObjectsAdjacent(src, dock_overmap_object))
						return
					switch(SSshuttle.moveShuttle(my_shuttle.id, dock_id, 1))
						if(0)
							shuttle_controller.busy = TRUE
							shuttle_controller.RemoveCurrentControl()
							my_shuttle.gateway_stranded = TRUE
							playsound(control_turf, 'modular_skyrat/modules/overmap/sound/shuttle_voice/error_navigation.ogg', OVERMAP_SHUTTLE_ALERT_VOLUME)

		if("target")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_TARGET))
				return
			if(!lock)
				return
			switch(href_list["target_control"])
				if("disengage_lock")
					SetLockTo(null)
				if("command_idle")
					target_command = TARGET_IDLE
				if("command_fire_once")
					target_command = TARGET_FIRE_ONCE
				if("command_keep_firing")
					target_command = TARGET_KEEP_FIRING
				if("command_scan")
					target_command = TARGET_SCAN
				if("command_beam_on_board")
					target_command = TARGET_BEAM_ON_BOARD
		if("sensor")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_SENSORS))
				return
			var/id = text2num(href_list["target_id"])
			if(!id)
				return
			var/datum/overmap_object/ov_obj = SSovermap.GetObjectByID(id)
			if(!ov_obj)
				return
			switch(href_list["sensor_task"])
				if("target")
					SetLockTo(ov_obj)
				if("destination")
					destination_x = ov_obj.x
					destination_y = ov_obj.y
		if("general")
			switch(href_list["general_control"])
				if("shields")
					var/shields_engaged = IsShieldOn()
					if(shields_engaged)
						TurnShieldsOff()
					else
						TurnShieldsOn()
				if("overmap")
					GrantOvermapView(usr)
				if("microphone_muted")
					microphone_muted = !microphone_muted
				if("comms")
					open_comms_channel = !open_comms_channel
					my_visual.update_appearance()
				if("hail")
					var/hail_msg = input(usr, "Compose a hail message:", "Hail Message")  as text|null
					if(hail_msg)
						hail_msg = STRIP_HTML_SIMPLE(hail_msg, MAX_BROADCAST_LEN)
		if("helm")
			if(!(shuttle_capability & SHUTTLE_CAN_USE_ENGINES))
				return
			switch(href_list["helm_control"])
				if("pad")
					DisplayHelmPad(usr)
					return
				if("command_stop")
					helm_command = HELM_FULL_STOP
				if("command_move_dest")
					helm_command = HELM_MOVE_TO_DESTINATION
				if("command_turn_dest")
					helm_command = HELM_TURN_TO_DESTINATION
				if("command_follow_sensor")
					helm_command = HELM_FOLLOW_SENSOR_LOCK
				if("command_turn_sensor")
					helm_command = HELM_TURN_TO_SENSOR_LOCK
				if("command_idle")
					helm_command = HELM_IDLE
				if("change_x")
					var/new_x = input(usr, "Choose new X destination", "Helm Control", destination_x) as num|null
					if(new_x)
						destination_x = clamp(new_x, 1, current_system.maxx)
				if("change_y")
					var/new_y = input(usr, "Choose new Y destination", "Helm Control", destination_y) as num|null
					if(new_y)
						destination_y = clamp(new_y, 1, current_system.maxy)
				if("change_impulse_power")
					var/new_speed = input(usr, "Choose new impulse power (0% - 100%)", "Helm Control", (impulse_power*100)) as num|null
					if(new_speed)
						impulse_power = clamp((new_speed/100), 0, 1)
	DisplayUI(usr)

/datum/overmap_object/shuttle/New()
	. = ..()
	destination_x = x
	destination_y = y
	shuttle_controller = new(src)

/datum/overmap_object/shuttle/proc/RegisterToShuttle(obj/docking_port/mobile/register_shuttle)
	my_shuttle = register_shuttle
	my_shuttle.my_overmap_object = src
	for(var/i in my_shuttle.all_extensions)
		var/datum/shuttle_extension/extension = i
		extension.AddToOvermapObject(src)

	var/obj/docking_port/stationary/transit/my_transit = my_shuttle.assigned_transit
	transit_instance = my_transit.transit_instance
	transit_instance.overmap_shuttle = src

	update_perceived_parallax()

/datum/overmap_object/shuttle/Destroy()
	if(transit_instance)
		transit_instance.overmap_shuttle = null
		transit_instance = null
	control_turf = null
	QDEL_NULL(shuttle_controller)
	if(my_shuttle)
		for(var/i in my_shuttle.all_extensions)
			var/datum/shuttle_extension/extension = i
			extension.RemoveFromOvermapObject()
		my_shuttle.my_overmap_object = null
		my_shuttle = null
	engine_extensions = null
	shield_extensions = null
	transporter_extensions = null
	weapon_extensions = null
	all_extensions = null
	return ..()

/datum/overmap_object/shuttle/UpdateVisualOffsets()
	. = ..()
	if(shuttle_controller)
		shuttle_controller.NewVisualOffset(FLOOR(partial_x,1),FLOOR(partial_y,1))

/datum/overmap_object/shuttle/proc/update_perceived_parallax()
	var/established_direction = FALSE
	if(velocity_y || velocity_x)
		var/absx = abs(velocity_x)
		var/absy = abs(velocity_y)
		if(absy > absx)
			if(velocity_y > 0)
				established_direction = NORTH
			else
				established_direction = SOUTH
		else
			if(velocity_x > 0)
				established_direction = EAST
			else
				established_direction = WEST

	var/changed = FALSE
	if(my_shuttle)
		current_parallax_dir = established_direction ? (my_shuttle.preferred_direction ? my_shuttle.preferred_direction : established_direction) : FALSE
		if(current_parallax_dir != my_shuttle.overmap_parallax_dir)
			my_shuttle.overmap_parallax_dir = current_parallax_dir
			changed = TRUE
			var/area/hyperspace_area = transit_instance.dock.assigned_area
			hyperspace_area.parallax_movedir = current_parallax_dir
	else if (is_seperate_z_level && length(related_levels))
		for(var/i in related_levels)
			var/datum/space_level/level = i
			current_parallax_dir = (established_direction && fixed_parallax_dir) ? fixed_parallax_dir : established_direction
			if(current_parallax_dir != level.parallax_direction_override)
				level.parallax_direction_override = current_parallax_dir
				changed = TRUE

	if(changed)
		for(var/i in GetAllClientMobs())
			var/mob/mob = i
			mob.hud_used.update_parallax()

/datum/overmap_object/shuttle/proc/GrantOvermapView(mob/user, turf/passed_turf)
	//Camera control
	if(!shuttle_controller)
		return
	if(user.client && !shuttle_controller.busy)
		shuttle_controller.SetController(user)
		if(passed_turf)
			shuttle_controller.control_turf = passed_turf
		return TRUE

/datum/overmap_object/shuttle/proc/CommandMove(dest_x, dest_y)
	destination_y = dest_y
	destination_x = dest_x
	helm_command = HELM_MOVE_TO_DESTINATION

/datum/overmap_object/shuttle/proc/StopMove()
	helm_command = HELM_FULL_STOP

/datum/overmap_object/shuttle/relaymove(mob/living/user, direction)
	return

/datum/overmap_object/shuttle/station
	name = "Space Station"
	visual_type = /obj/effect/abstract/overmap/shuttle/station
	is_seperate_z_level = TRUE
	uses_rotation = FALSE
	shuttle_capability = STATION_SHUTTLE_CAPABILITY
	speed_divisor_from_mass = 40
	clears_hazards_on_spawn = TRUE

/datum/overmap_object/shuttle/ship
	name = "Ship"
	visual_type = /obj/effect/abstract/overmap/shuttle/ship
	is_seperate_z_level = TRUE
	shuttle_capability = STATION_SHUTTLE_CAPABILITY
	speed_divisor_from_mass = 20
	clears_hazards_on_spawn = TRUE

/datum/overmap_object/shuttle/planet
	name = "Planet"
	visual_type = /obj/effect/abstract/overmap/shuttle/planet
	is_seperate_z_level = TRUE
	uses_rotation = FALSE
	shuttle_capability = PLANET_SHUTTLE_CAPABILITY
	speed_divisor_from_mass = 1000 //1000 times as harder as a shuttle to move
	clears_hazards_on_spawn = TRUE
	var/planet_color = COLOR_WHITE

/datum/overmap_object/shuttle/planet/New()
	. = ..()
	my_visual.color = planet_color

/datum/overmap_object/shuttle/planet/lavaland
	name = "Lavaland"
	planet_color = LIGHT_COLOR_BLOOD_MAGIC

/datum/overmap_object/shuttle/planet/icebox
	name = "Ice Planet"
	planet_color = COLOR_TEAL

/datum/overmap_object/shuttle/planet/gateway
	name = "Wormhole"
	visual_type = /obj/effect/abstract/overmap/shuttle/gateway
	planet_color = COLOR_CYAN
	allow_freeform_docking = FALSE

/datum/overmap_object/shuttle/planet/gateway/New()
	. = ..()
	my_visual.color = planet_color

/datum/overmap_object/shuttle/ship/blueshift
	name = "NSV Blueshift"
	fixed_parallax_dir = NORTH
	speed_divisor_from_mass = 300
	z_alert_sounds = TRUE

#undef SHUTTLE_MASS_DIVISOR
