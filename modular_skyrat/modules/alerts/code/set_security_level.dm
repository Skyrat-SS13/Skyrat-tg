GLOBAL_VAR_INIT(gamma_timer_id, null)
GLOBAL_VAR_INIT(delta_timer_id, null)
GLOBAL_VAR_INIT(sec_level_cooldown, FALSE)

#define GAMMA_LOOP_LENGTH 1236 //2.06 minutes in deciseconds
#define DELTA_LOOP_LENGTH 8 SECONDS
#define SET_SEC_LEVEL_COOLDOWN 5 SECONDS

/proc/set_security_level(level)
	level = isnum(level) ? level : seclevel2num(level)
	var modTimer = get_mod_timer(level)
	var oldModTimer = get_mod_timer(SSsecurity_level.current_level)

	//Will not be announced if you try to set to the same level as it already is
	if(level >= SEC_LEVEL_GREEN && level <= SEC_LEVEL_GAMMA && level != SSsecurity_level.current_level)
		if(GLOB.sec_level_cooldown)
			message_admins("Attempt made to change security level while in cooldown!")
			return "COOLDOWN"
		if(GLOB.delta_timer_id)
			deltimer(GLOB.delta_timer_id)
			GLOB.delta_timer_id = null
		if(GLOB.gamma_timer_id)
			deltimer(GLOB.gamma_timer_id)
			GLOB.gamma_timer_id = null
		announce_security_level(level) //IF YOU ARE ADDING A NEW SECURITY LEVEL, UPDATE THIS PROC
		SSsecurity_level.set_level(level)
		if(SSshuttle.emergency.mode == SHUTTLE_CALL || SSshuttle.emergency.mode == SHUTTLE_RECALL)
			oldModTimer = 1/oldModTimer
			SSshuttle.emergency.modTimer(oldModTimer)
			SSshuttle.emergency.modTimer(modTimer)
		GLOB.sec_level_cooldown = TRUE
		addtimer(CALLBACK(GLOBAL_PROC, .proc/reset_sec_level_cooldown), SET_SEC_LEVEL_COOLDOWN)

/proc/reset_sec_level_cooldown()
	GLOB.sec_level_cooldown = FALSE

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
	switch(SSsecurity_level.current_level)
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

/proc/announce_security_level(level)
	switch(level)
		if(SEC_LEVEL_GREEN)
			minor_announce(CONFIG_GET(string/alert_green), "Attention! Alert level lowered to green:", sound = 'modular_skyrat/modules/alerts/sound/security_levels/green.ogg')
		if(SEC_LEVEL_BLUE)
			if(SSsecurity_level.current_level < SEC_LEVEL_BLUE)
				minor_announce(CONFIG_GET(string/alert_blue_upto), "Attention! Alert level elevated to blue:", sound = 'modular_skyrat/modules/alerts/sound/security_levels/blue.ogg')
			else
				minor_announce(CONFIG_GET(string/alert_blue_downto), "Attention! Alert level lowered to blue:", sound = 'modular_skyrat/modules/alerts/sound/security_levels/blue.ogg')
		if(SEC_LEVEL_VIOLET)
			if(SSsecurity_level.current_level < SEC_LEVEL_VIOLET)
				minor_announce(CONFIG_GET(string/alert_violet_upto), "Attention! Alert level set to violet:", TRUE, sound = 'modular_skyrat/modules/alerts/sound/security_levels/violet.ogg', override_volume = TRUE)
			else
				minor_announce(CONFIG_GET(string/alert_violet_downto), "Attention! Alert level set to violet:", sound = 'modular_skyrat/modules/alerts/sound/security_levels/violet.ogg', override_volume = TRUE)
		if(SEC_LEVEL_ORANGE)
			if(SSsecurity_level.current_level < SEC_LEVEL_ORANGE)
				minor_announce(CONFIG_GET(string/alert_orange_upto), "Attention! Alert level set to orange:", TRUE, sound = 'modular_skyrat/modules/alerts/sound/security_levels/orange.ogg', override_volume = TRUE)
			else
				minor_announce(CONFIG_GET(string/alert_orange_downto), "Attention! Alert level set to orange:", sound = 'modular_skyrat/modules/alerts/sound/security_levels/orange.ogg', override_volume = TRUE)
		if(SEC_LEVEL_AMBER)
			if(SSsecurity_level.current_level < SEC_LEVEL_AMBER)
				minor_announce(CONFIG_GET(string/alert_amber_upto), "Attention! Alert level set to amber:", TRUE, sound = 'modular_skyrat/modules/alerts/sound/security_levels/amber.ogg', override_volume = TRUE)
			else
				minor_announce(CONFIG_GET(string/alert_amber_downto), "Attention! Alert level set to amber:", sound = 'modular_skyrat/modules/alerts/sound/security_levels/amber.ogg', override_volume = TRUE)
		if(SEC_LEVEL_RED)
			if(SSsecurity_level.current_level < SEC_LEVEL_RED)
				minor_announce(CONFIG_GET(string/alert_red_upto), "Attention! Code red!", TRUE, sound = 'modular_skyrat/modules/alerts/sound/security_levels/red.ogg')
			else
				minor_announce(CONFIG_GET(string/alert_red_downto), "Attention! Code red!", sound = 'modular_skyrat/modules/alerts/sound/security_levels/red.ogg')
		if(SEC_LEVEL_DELTA)
			if(SSsecurity_level.current_level < SEC_LEVEL_DELTA)
				minor_announce(CONFIG_GET(string/alert_delta_upto), "Attention! Delta Alert level reached!", TRUE, sound = 'modular_skyrat/modules/alerts/sound/security_levels/delta.ogg', override_volume = TRUE)
			else
				minor_announce(CONFIG_GET(string/alert_delta_downto), "Attention! Delta Alert level reached!", TRUE, sound = 'modular_skyrat/modules/alerts/sound/security_levels/delta.ogg', override_volume = TRUE)
			SSsecurity_level.current_level = level //Snowflake shit to make sue they actually loop.
			delta_alarm()
		if(SEC_LEVEL_GAMMA)
			minor_announce(CONFIG_GET(string/alert_gamma), "Attention! ZK-Class Reality Failure Scenario Detected, GAMMA Alert Level Reached!", TRUE, sound = 'modular_skyrat/modules/alerts/sound/security_levels/gamma_alert.ogg')
			SSsecurity_level.current_level = level
			gamma_loop()

/proc/delta_alarm() //Delta alarm sounds every so often
	if(SSsecurity_level.current_level == SEC_LEVEL_DELTA)
		alert_sound_to_playing('modular_skyrat/modules/alerts/sound/misc/alarm_delta.ogg', override_volume = TRUE)
		GLOB.delta_timer_id = addtimer(CALLBACK(GLOBAL_PROC, .proc/delta_alarm), DELTA_LOOP_LENGTH, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_CLIENT_TIME)

/proc/gamma_loop() //Loops gamma sound
	if(SSsecurity_level.current_level == SEC_LEVEL_GAMMA)
		alert_sound_to_playing('modular_skyrat/modules/alerts/sound/security_levels/gamma_alert.ogg', override_volume = TRUE)
		GLOB.gamma_timer_id = addtimer(CALLBACK(GLOBAL_PROC, .proc/gamma_loop), GAMMA_LOOP_LENGTH, TIMER_UNIQUE | TIMER_STOPPABLE | TIMER_CLIENT_TIME)

///This is quite franlky the most important proc relating to global sounds, it uses area definition to play sounds depending on your location, and respects the players announcement volume. Generally if you're sending an announcement you want to use priority_announce.
/proc/alert_sound_to_playing(soundin, vary = FALSE, frequency = 0, falloff = FALSE, channel = 0, pressure_affected = FALSE, sound/S, override_volume = FALSE, list/players)
	if(!S)
		S = sound(get_sfx(soundin))
	var/static/list/quiet_areas = typecacheof(typesof(/area/station/maintenance) + typesof(/area/space) + typesof(/area/station/commons/dorms))
	if(!players)
		players = GLOB.player_list
	for(var/m in players)
		if(ismob(m) && !isnewplayer(m))
			var/mob/M = m
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS && M.can_hear())
				if(override_volume)
					M.playsound_local(get_turf(M), S, 80, FALSE)
				else
					var/area/A = get_area(M)
					if(is_type_in_typecache(A, quiet_areas)) //These areas don't hear it as loudly
						M.playsound_local(get_turf(M), S, 10, FALSE)
					else
						M.playsound_local(get_turf(M), S, 70, FALSE)

#undef GAMMA_LOOP_LENGTH
#undef SET_SEC_LEVEL_COOLDOWN
#undef DELTA_LOOP_LENGTH
