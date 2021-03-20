GLOBAL_VAR_INIT(gamma_timer_id, null)
GLOBAL_VAR_INIT(delta_timer_id, null)

#define GAMMA_LOOP_LENGTH 1236 //2.06 minutes in deciseconds

/proc/set_security_level(level)
	level = isnum(level) ? level : seclevel2num(level)
	var modTimer = get_mod_timer(level)
	var oldModTimer = get_mod_timer(GLOB.security_level)

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_GAMMA && level != GLOB.security_level)
		if(GLOB.delta_timer_id)
			deltimer(GLOB.delta_timer_id)
			GLOB.delta_timer_id = null
		if(GLOB.gamma_timer_id)
			deltimer(GLOB.gamma_timer_id)
			GLOB.gamma_timer_id = null
		switch(level)
			if(SEC_LEVEL_GREEN)
				minor_announce(CONFIG_GET(string/alert_green), "Attention! Alert level lowered to green:")
				alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/downtoGREEN.ogg')
			if(SEC_LEVEL_BLUE)
				if(GLOB.security_level < SEC_LEVEL_BLUE)
					minor_announce(CONFIG_GET(string/alert_blue_upto), "Attention! Alert level elevated to blue:",1)
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/blue.ogg')
				else
					minor_announce(CONFIG_GET(string/alert_blue_downto), "Attention! Alert level lowered to blue:")
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/downtoGREEN.ogg')
			if(SEC_LEVEL_VIOLET)
				if(GLOB.security_level < SEC_LEVEL_VIOLET)
					minor_announce(CONFIG_GET(string/alert_violet_upto), "Attention! Alert level set to violet:",1)
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg')
				else
					minor_announce(CONFIG_GET(string/alert_violet_downto), "Attention! Alert level set to violet:")
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg')
			if(SEC_LEVEL_ORANGE)
				if(GLOB.security_level < SEC_LEVEL_ORANGE)
					minor_announce(CONFIG_GET(string/alert_orange_upto), "Attention! Alert level set to orange:",1)
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg')
				else
					minor_announce(CONFIG_GET(string/alert_orange_downto), "Attention! Alert level set to orange:")
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg')
			if(SEC_LEVEL_AMBER)
				if(GLOB.security_level < SEC_LEVEL_AMBER)
					minor_announce(CONFIG_GET(string/alert_amber_upto), "Attention! Alert level set to amber:",1)
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg')
				else
					minor_announce(CONFIG_GET(string/alert_amber_downto), "Attention! Alert level set to amber:")
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/voyalert.ogg')
			if(SEC_LEVEL_RED)
				if(GLOB.security_level < SEC_LEVEL_RED)
					minor_announce(CONFIG_GET(string/alert_red_upto), "Attention! Code red!",1)
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/red.ogg')
				else
					minor_announce(CONFIG_GET(string/alert_red_downto), "Attention! Code red!")
					alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/downtoRED.ogg')
			if(SEC_LEVEL_DELTA)
				if(GLOB.security_level < SEC_LEVEL_DELTA)
					minor_announce(CONFIG_GET(string/alert_delta_upto), "Attention! Delta Alert level reached!",1)
				else
					minor_announce(CONFIG_GET(string/alert_delta_downto), "Attention! Delta Alert level reached!",1)
				GLOB.security_level = level
				alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/delta.ogg')
				delta_alarm()
			if(SEC_LEVEL_GAMMA)
				minor_announce(CONFIG_GET(string/alert_gamma), "Attention! ZK-Class Reality Failure Scenario Detected, GAMMA Alert Level Reached!",1)
				GLOB.security_level = level
				alert_sound_to_playing('modular_skyrat/modules/alerts/sound/alarm_delta.ogg')
				gamma_loop()
		GLOB.security_level = level
		for(var/obj/machinery/firealarm/FA in GLOB.machines)
			if(is_station_level(FA.z))
				FA.update_icon()
		if(level >= SEC_LEVEL_RED)
			for(var/obj/machinery/computer/shuttle/pod/pod in GLOB.machines)
				pod.locked = FALSE
			for(var/obj/machinery/door/D in GLOB.machines)
				if(D.red_alert_access)
					D.visible_message("<span class='notice'>[D] whirrs as it automatically lifts access requirements!</span>")
					playsound(D, 'sound/machines/boltsup.ogg', 50, TRUE)
		if(SSshuttle.emergency.mode == SHUTTLE_CALL || SSshuttle.emergency.mode == SHUTTLE_RECALL)
			oldModTimer = 1/oldModTimer
			SSshuttle.emergency.modTimer(oldModTimer)
			SSshuttle.emergency.modTimer(modTimer)
		SSblackbox.record_feedback("tally", "security_level_changes", 1, get_security_level())
		SSnightshift.check_nightshift()
	else
		return

/proc/gamma_loop() //Loops gamma sound
	if(GLOB.security_level == SEC_LEVEL_GAMMA)
		alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/gamma_alert.ogg')
		GLOB.gamma_timer_id = addtimer(CALLBACK(GLOBAL_PROC, .proc/gamma_loop), GAMMA_LOOP_LENGTH, TIMER_UNIQUE | TIMER_STOPPABLE)

/proc/delta_alarm() //Delta alarm sounds every so often
	if(GLOB.security_level == SEC_LEVEL_DELTA)
		alert_sound_to_playing('modular_skyrat/modules/alerts/sound/alarm_delta.ogg')
		GLOB.delta_timer_id = addtimer(CALLBACK(GLOBAL_PROC, .proc/delta_alarm, FALSE), 8 SECONDS, TIMER_UNIQUE | TIMER_STOPPABLE)

/proc/get_mod_timer(secLevel)
	switch(secLevel)
		if(SEC_LEVEL_GREEN)
			return 2
		if(SEC_LEVEL_BLUE)
			return 1
		if(SEC_LEVEL_VIOLET)
			return 0.8
		if(SEC_LEVEL_ORANGE)
			return 0.8
		if(SEC_LEVEL_AMBER)
			return 0.8
		if(SEC_LEVEL_RED)
			return 0.5
		if(SEC_LEVEL_DELTA)
			return 0.5
		if(SEC_LEVEL_GAMMA)
			return 0.4

/proc/get_security_level()
	switch(GLOB.security_level)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_VIOLET)
			return "violet"
		if(SEC_LEVEL_ORANGE)
			return "orange"
		if(SEC_LEVEL_AMBER)
			return "amber"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"
		if(SEC_LEVEL_GAMMA)
			return "gamma"

/proc/num2seclevel(num)
	switch(num)
		if(SEC_LEVEL_GREEN)
			return "green"
		if(SEC_LEVEL_BLUE)
			return "blue"
		if(SEC_LEVEL_VIOLET)
			return "violet"
		if(SEC_LEVEL_ORANGE)
			return "orange"
		if(SEC_LEVEL_AMBER)
			return "amber"
		if(SEC_LEVEL_RED)
			return "red"
		if(SEC_LEVEL_DELTA)
			return "delta"
		if(SEC_LEVEL_GAMMA)
			return "gamma"

/proc/seclevel2num(seclevel)
	switch(lowertext(seclevel))
		if("green")
			return SEC_LEVEL_GREEN
		if("blue")
			return SEC_LEVEL_BLUE
		if("violet")
			return SEC_LEVEL_VIOLET
		if("orange")
			return SEC_LEVEL_ORANGE
		if("amber")
			return SEC_LEVEL_AMBER
		if("red")
			return SEC_LEVEL_RED
		if("delta")
			return SEC_LEVEL_DELTA
		if("gamma")
			return SEC_LEVEL_GAMMA

/proc/alert_sound_to_playing(soundin, vary = FALSE, frequency = 0, falloff = FALSE, channel = 0, pressure_affected = FALSE, sound/S)
	if(!S)
		S = sound(get_sfx(soundin))
	var/list/quiet_areas = typecacheof(typesof(/area/maintenance) + typesof(/area/space) + typesof(/area/commons/dorms))
	for(var/m in GLOB.player_list)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS && is_station_level(M.z))
				var/area/A = get_area(M)
				if(is_type_in_typecache(A, quiet_areas)) //These areas don't hear it as loudly
					M.playsound_local(get_turf(M), S, min(10, M.client.prefs.announcement_volume), FALSE)
				else
					M.playsound_local(get_turf(M), S, M.client.prefs.announcement_volume, FALSE)

#undef GAMMA_LOOP_LENGTH
