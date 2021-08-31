/datum/controller/subsystem/shuttle/
	var/hostileEnvironmentTypes = list()

/datum/controller/subsystem/shuttle/proc/registerHostileEnvironment(datum/bad, reason)
	hostileEnvironments[bad] = TRUE
	hostileEnvironmentTypes += reason
	checkHostileEnvironment()

/datum/controller/subsystem/shuttle/proc/checkHostileEnvironment()
	for(var/datum/environment in hostileEnvironments)
		if(!istype(environment) || QDELETED(environment))
			hostileEnvironments -= environment
	emergencyNoEscape = hostileEnvironments.len

	if(emergencyNoEscape && (emergency.mode == SHUTTLE_IGNITING))
		emergency.mode = SHUTTLE_STRANDED
		emergency.timer = null
		emergency.sound_played = FALSE
		switch(hostileEnvironmentTypes[1])
			if(NOSHUTTLE_BIOHAZARD)
				priority_announce("Severe Biohazard detected. \
					[GLOB.station_name] is under indefinite quarantine \
					pending biohazard cleanse.", "Station Quarantine", 'sound/misc/notice1.ogg', "Priority")
			if(NOSHUTTLE_DELTA)
				priority_announce("Station destruction imminent. \
					All hands of [GLOB.station_name] are expected to prevent \
					station destruction before leaving.", "Destruction Imminent", 'sound/misc/notice1.ogg', "Priority")
			if(NOSHUTTLE_REVS)
				priority_announce("Armed 'revolution' detected. \
					All hands of [GLOB.station_name] are expected to suppress \
					violent terrorists before leaving.", "NT Anti-Terror Announcement", 'sound/misc/notice1.ogg', "Priority")
			if(NOSHUTTLE_GANG)
				priority_announce("Emergency shuttle under lockdown \
					on order of Sol Federal Police. Please comply with \
					orders and resolution will be easy.", "Sol Federal Police Lockdown", 'sound/misc/notice1.ogg', "Priority")
			if(NOSHUTTLE_NARSIE)
				priority_announce("YOU CANNOT ESCAPE INEVITABILITY. \
					I HUNGER. \
					YOUR SHUTTLE WILL NOT HELP YOU.", "Message from Nar'Sie", 'sound/creatures/narsie_rises.ogg', "Priority")
	if(!emergencyNoEscape && (emergency.mode == SHUTTLE_STRANDED))
		emergency.mode = SHUTTLE_DOCKED
		emergency.setTimer(emergencyDockTime)
		priority_announce("Shuttle Lockdown Lifted. \
			You have 3 minutes to board the Emergency Shuttle.",
			null, ANNOUNCER_SHUTTLEDOCK, "Priority")
