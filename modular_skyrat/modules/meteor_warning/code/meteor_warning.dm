#define METEOR_WAVE_DURATION 37

/datum/round_event/meteor_wave/New()
	..()
	start_when = rand(210, 240)
	end_when = start_when + METEOR_WAVE_DURATION

/datum/round_event/meteor_wave/announce(fake)
	priority_announce("Meteors have been detected on collision course with the station. The early warning system estimates first collision in approximately [start_when * 2] seconds. Ensure all sensitive areas and equipment are shielded.", "Meteor Alert", ANNOUNCER_METEORS)
	var/level = SSsecurity_level.get_current_level_as_number()
	addtimer(CALLBACK(src, PROC_REF(orange_alert)), 4 MINUTES, level)

/datum/round_event/meteor_wave/proc/orange_alert(datum/round_event/mv)
	var/level = SSsecurity_level.get_current_level_as_number()
	switch(level)
		if(SEC_LEVEL_GREEN)
			SSsecurity_level.set_level(SEC_LEVEL_ORANGE)
		if(SEC_LEVEL_BLUE)
			SSsecurity_level.set_level(SEC_LEVEL_ORANGE)
		if(SEC_LEVEL_VIOLET)
			SSsecurity_level.set_level(SEC_LEVEL_ORANGE)
		if(SEC_LEVEL_AMBER)
			GLOB.force_eng_override = TRUE
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, TRUE)
		if(SEC_LEVEL_RED)
			GLOB.force_eng_override = TRUE
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, TRUE)
		if(SEC_LEVEL_DELTA)
			GLOB.force_eng_override = TRUE
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, TRUE)
		if(SEC_LEVEL_GAMMA)
			GLOB.force_eng_override = TRUE
			SEND_GLOBAL_SIGNAL(COMSIG_GLOB_FORCE_ENG_OVERRIDE, TRUE)

#undef METEOR_WAVE_DURATION
