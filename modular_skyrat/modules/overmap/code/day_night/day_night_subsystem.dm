SUBSYSTEM_DEF(day_night)
	name = "Day and Night Cycle"
	flags = SS_BACKGROUND
	wait = 1 MINUTES
	runlevels = RUNLEVEL_GAME
	var/list/day_night_controllers = list()

/datum/controller/subsystem/day_night/fire()
	// process all day night controllers
	for(var/i in day_night_controllers)
		var/datum/day_night_controller/iterated_controller = i
		iterated_controller.process()
