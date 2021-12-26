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
	return ..()

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

	return LAZYLEN(submitted_applications)

/datum/controller/subsystem/opposing_force/proc/broadcast_queue_change(datum/opposing_force/updating_opposing_force)
	for(var/datum/opposing_force/opposing_force in submitted_applications)
		if(opposing_force == updating_opposing_force)
			continue
		opposing_force.broadcast_queue_change()

/datum/controller/subsystem/opposing_force/proc/approve(datum/opposing_force/opposing_force, mob/approver)
	if(!is_admin(approver.client))
		message_admins("Oppoding_force_subsystem: [ADMIN_LOOKUPFLW(approver)] attempted to approve an OPFOR application but was not an admin!")
		CRASH("Opposing_force_subsystem: Attempted to deny an opposing force but the approver was not an admin!")

	if(!(opposing_force in submitted_applications))
		to_chat(approver, "Opposing_force_subsystem: Attempted to approve an opposing force but it was not in the queue!")
		return FALSE

	approved_applications += opposing_force
	submitted_applications -= opposing_force

	opposing_force.approve(approver)

	broadcast_queue_change(opposing_force)

	return TRUE

/datum/controller/subsystem/opposing_force/proc/deny(datum/opposing_force/opposing_force, reason, mob/denier)
	if(!is_admin(denier.client))
		message_admins("Oppoding_force_subsystem: [ADMIN_LOOKUPFLW(denier)] attempted to deny an OPFOR application but was not an admin!")
		CRASH("Opposing_force_subsystem: Attempted to deny an opposing force but the denier was not an admin!")

	if(LAZYFIND(submitted_applications, opposing_force))
		submitted_applications -= opposing_force

	if(LAZYFIND(approved_applications, opposing_force))
		approved_applications -= opposing_force

	if(!LAZYFIND(unsubmitted_applications, opposing_force))
		unsubmitted_applications += opposing_force

	opposing_force.deny(denier, reason)
	opposing_force.status = OPFOR_STATUS_REJECTED

	broadcast_queue_change(opposing_force)

	return TRUE

/datum/controller/subsystem/opposing_force/proc/request_changes(datum/opposing_force/opposing_force, changes)
	if(LAZYFIND(submitted_applications, opposing_force))
		submitted_applications -= opposing_force

	if(LAZYFIND(approved_applications, opposing_force))
		approved_applications -= opposing_force

	if(!LAZYFIND(unsubmitted_applications, opposing_force))
		unsubmitted_applications += opposing_force

	broadcast_queue_change(opposing_force)

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

	broadcast_queue_change()

/datum/controller/subsystem/opposing_force/proc/view_opfor(datum/opposing_force/opposing_force, mob/viewer)
	if(!is_admin(viewer.client))
		message_admins("Oppoding_force_subsystem: [ADMIN_LOOKUPFLW(viewer)] attempted to view an OPFOR application but was not an admin!")
		CRASH("Opposing_force_subsystem: Attempted to view an opposing force but the viewer was not an admin!")

	opposing_force.ui_interact(viewer)

/datum/controller/subsystem/opposing_force/proc/open_control_panel()

/datum/controller/subsystem/opposing_force/proc/get_check_antag_listing()
	var/list/returned_html = list()

	returned_html += "<b>OPFOR Applications</b><br>"

	returned_html += "Unsubmitted<br>"
	for(var/datum/opposing_force/opposing_force in unsubmitted_applications)
		returned_html += "<b>[opposing_force.mind_reference.key]</b><br>"
		returned_html += "<a href='?priv_msg=[ckey(opposing_force.mind_reference.key)]'>PM</a>"
		if(opposing_force.mind_reference.current)
			returned_html += "<a href='?_src_=holder;[HrefToken()];adminplayerobservefollow=[REF(opposing_force.mind_reference?.current)]'>FLW</a>"
		returned
