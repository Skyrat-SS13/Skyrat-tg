SUBSYSTEM_DEF(opposing_force)
	name = "Opposing Force"
	flags = SS_NO_FIRE

	/// A list of all currently active objectives
	var/list/unsubmitted_applications = list()
	/// A list of all currently submitted objectives
	var/list/submitted_applications = list()
	/// A list of all approved applications
	var/list/approved_applications = list()
	/// The max amount of objectives that can be tracked
	var/max_objectives = 5
	/// Are we allowing players to make objectives?
	var/accepting_objectives = TRUE
	/// The status of the subsystem
	var/status = OPFOR_SUBSYSTEM_READY

/datum/controller/subsystem/opposing_force/stat_entry(msg)
	msg = "UNSUB: [LAZYLEN(unsubmitted_applications)] | SUB: [LAZYLEN(submitted_applications)] | APPR: [LAZYLEN(approved_applications)]"

/datum/controller/subsystem/opposing_force/proc/check_availability()
	if(get_current_applications() >= max_objectives)
		status = OPFOR_SUBSYSTEM_REJECT_CAP
	if(!accepting_objectives)
		status = OPFOR_SUBSYSTEM_REJECT_CLOSED
	status = OPFOR_SUBSYSTEM_READY
	return status

/datum/controller/subsystem/opposing_force/proc/close_objectives()
	accepting_objectives = FALSE

/datum/controller/subsystem/opposing_force/proc/get_queue_position(datum/opposing_force/opposing_force)
	if(!(opposing_force in submitted_applications))
		return "ERROR"
	return LAZYFIND(submitted_applications, opposing_force)

/datum/controller/subsystem/opposing_force/proc/add_to_queue(datum/opposing_force/opposing_force)
	if(!LAZYFIND(unsubmitted_applications, opposing_force))
		CRASH("Opposing_force_subsystem: Attempted to add an opposing force to the queue but it was not registered to the subsystem!")

	submitted_applications += opposing_force
	unsubmitted_applications -= opposing_force

	opposing_force.status = OPFOR_STATUS_AWAITING_APPROVAL

	return LAZYLEN(submitted_applications)

/datum/controller/subsystem/opposing_force/proc/approve(datum/opposing_force/opposing_force, mob/approver)
	if(!(opposing_force in submitted_applications))
		return FALSE

	approved_applications += opposing_force
	submitted_applications -= opposing_force

	opposing_force.approve(approver)

	return TRUE

/datum/controller/subsystem/opposing_force/proc/deny(datum/opposing_force/opposing_force, reason, mob/denier)
	if(LAZYFIND(submitted_applications, opposing_force))
		submitted_applications -= opposing_force

	if(LAZYFIND(approved_applications, opposing_force))
		approved_applications -= opposing_force

	if(!LAZYFIND(unsubmitted_applications, opposing_force))
		unsubmitted_applications += opposing_force

	opposing_force.deny(denier, reason)
	opposing_force.status = OPFOR_STATUS_REJECTED

	return TRUE

/datum/controller/subsystem/opposing_force/proc/request_changes(datum/opposing_force/opposing_force, changes)
	if(LAZYFIND(submitted_applications, opposing_force))
		submitted_applications -= opposing_force

	if(LAZYFIND(approved_applications, opposing_force))
		approved_applications -= opposing_force

	if(!LAZYFIND(unsubmitted_applications, opposing_force))
		unsubmitted_applications += opposing_force

/datum/controller/subsystem/opposing_force/proc/get_current_applications()
	return LAZYLEN(submitted_applications) + LAZYLEN(approved_applications)

/datum/controller/subsystem/opposing_force/proc/new_opfor(datum/opposing_force/opposing_force)
	unsubmitted_applications += opposing_force

/datum/controller/subsystem/opposing_force/proc/remove_opfor(datum/opposing_force/opposing_force)
	if(LAZYFIND(unsubmitted_applications, opposing_force))
		unsubmitted_applications -= opposing_force
	if(LAZYFIND(submitted_applications, opposing_force))
		submitted_applications -= opposing_force
	if(LAZYFIND(approved_applications, opposing_force))
		approved_applications -= opposing_force

