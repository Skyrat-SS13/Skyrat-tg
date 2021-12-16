SUBSYSTEM_DEF(opposing_force)
	name = "Opposing Force"
	flags = SS_NO_FIRE

	/// A list of all currently active objectives
	var/list/tracked_opfor = list()
	/// The max amount of objectives that can be tracked
	var/max_objectives = 5
	/// Are we allowing players to make objectives?
	var/accepting_objectives = TRUE

/datum/controller/subsystem/opposing_force/proc/check_availability()
	if(LAZYLEN(tracked_opfor) >= max_objectives)
		return "out of slots"
	if(!accepting_objectives)
		return "not accepting objectives"
	return "success"

/datum/controller/subsystem/opposing_force/proc/add_opfor(datum/opposing_force/opposing_force)
	tracked_opfor += opposing_force

/datum/controller/subsystem/opposing_force/proc/remove_opfor(datum/opposing_force/opposing_force)
	tracked_opfor -= opposing_force
