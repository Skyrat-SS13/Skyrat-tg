/datum/opposing_force_objective
	/// The name of the objective
	var/title = ""
	/// The actual objective.
	var/description = ""
	/// The reason for the objective.
	var/justification = ""
	/// Was this specific objective approved by the admins?
	var/approved = FALSE
	/// How intense is this goal?
	var/intensity = 1
	/// The text intensity of this goal
	var/text_intensity = OPFOR_GOAL_INTENSITY_1

/datum/opposing_force
	/// A list of objectives.
	var/list/objectives = list()
	/// A list of items they want spawned.
	var/list/requested_items = list()
	/// Justification for wanting to do bad things.
	var/set_backstory = ""
	/// Has this been approved?
	var/status = OPFOR_STATUS_NOT_SUBMITTED
	/// Hard ref to our mind.
	var/datum/mind/mind_reference
	/// Hard ref to our holder.
	var/client/holder
	/// For logging stuffs
	var/list/modification_log = list()
	/// Can we edit things?
	var/can_edit = TRUE
	/// The reason we were denied.
	var/denied_reason
	/// Any changes required
	var/requested_changes

	COOLDOWN_DECLARE(static/request_update_cooldown)

/datum/opposing_force/New(user, mind_reference)//user can either be a client or a mob due to byondcode(tm)
	if (istype(user, /client))
		var/client/user_client = user
		holder = user_client //if its a client, assign it to holder
	else
		var/mob/user_mob = user
		holder = user_mob.client //if its a mob, assign the mob's client to holder
	src.mind_reference = mind_reference

/datum/opposing_force/Destroy(force)
	mind_reference.memory_panel = null
	mind_reference = null
	holder = null
	SSopposing_force.remove_opfor(src)
	QDEL_LIST(objectives)
	return ..()

/datum/opposing_force/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OpposingForcePanel")
		ui.open()

/datum/opposing_force/ui_state(mob/user)
	return GLOB.always_state

/datum/opposing_force/ui_data(mob/user)
	var/list/data = list()

	data["backstory"] = set_backstory

	data["status"] = get_status_string()

	data["ss_status"] = SSopposing_force.check_availability()

	data["can_submit"] = SSopposing_force.accepting_objectives && (status == OPFOR_STATUS_NOT_SUBMITTED || status == OPFOR_STATUS_CHANGES_REQUESTED)

	data["can_request_update"] = status == OPFOR_STATUS_AWAITING_APPROVAL && COOLDOWN_FINISHED(src, request_update_cooldown) ? TRUE : FALSE

	data["can_edit"] = can_edit

	data["objectives"] = list()
	var/objective_num = 1
	for(var/datum/opposing_force_objective/opfor in objectives)
		var/list/objective_data = list(
			id = objective_num,
			ref = REF(opfor),
			title = opfor.title,
			description = opfor.description,
			intensity = opfor.intensity,
			text_intensity = opfor.text_intensity,
			justification = opfor.justification,
			approved = opfor.approved
			)
		objective_num++
		data["objectives"] += list(objective_data)

	return data

/datum/opposing_force/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/datum/opposing_force_objective/edited_objective
	if(params["objective_ref"])
		edited_objective = locate(params["objective_ref"]) in objectives
		if(!edited_objective)
			CRASH("Opposing_force passed a reference parameter to a goal that it could not locate!")

	switch(action)
		if("set_backstory")
			set_backstory(usr, params["backstory"])
		if("add_objective")
			add_objective(usr)
		if("remove_objective")
			remove_objective(usr, edited_objective)
		if("set_objective_title")
			set_objective_title(usr, edited_objective, params["title"])
		if("set_objective_description")
			set_objective_description(usr, edited_objective, params["new_desciprtion"])
		if("set_objective_justification")
			set_objective_justification(usr, edited_objective, params["new_justification"])
		if("set_objective_intensity")
			set_objective_intensity(usr, edited_objective, params["new_intensity_level"])
		if("request_update")
			request_update(usr)
		if("request_changes")
			user_request_changes(usr)
		if("close_application")
			close_application(usr)
		if("submit")
			submit_to_subsystem(usr)

/datum/opposing_force/proc/broadcast_queue_change()
	to_chat(holder, span_nicegreen("Your OPFOR application is now number [get_queue_position(src)] in the queue."))

/datum/opposing_force/proc/close_application(mob/user)
	var/choice = tgui_alert(user, "Are you sure you want close your application? All changes will be lost.", "Confirm", list("Yes", "No"))
	if(choice != "Yes")
		return
	qdel(src)

/datum/opposing_force/proc/approve(mob/approver)
	status = OPFOR_STATUS_APPROVED
	can_edit = FALSE

	to_chat(holder, examine_block(span_greentext("Your OPFOR application has been approved by [approver ? approver : "the OPFOR subsystem"]!")))

/datum/opposing_force/proc/deny(mob/denier, reason)
	status = OPFOR_STATUS_REJECTED
	can_edit = FALSE

	to_chat(holder, examine_block(span_redtext("Your OPFOR application has been denied by [denier ? denier : "the OPFOR subsystem"]!")))

/datum/opposing_force/proc/user_request_changes(mob/user)
	if(status == OPFOR_STATUS_CHANGES_REQUESTED)
		return
	if(can_edit)
		return
	var/choice = tgui_alert(user, "Are you sure you want to request changes? This will unapprove all objectives.", "Confirm", list("Yes", "No"))
	if(choice != "Yes")
		return
	if(status == OPFOR_STATUS_CHANGES_REQUESTED)
		return
	for(var/datum/opposing_force_objective/opfor in objectives)
		opfor.approved = FALSE
	status = OPFOR_STATUS_CHANGES_REQUESTED
	SSopposing_force.request_changes(src)
	can_edit = TRUE

	add_log(user.ckey, "Requested changes")
	message_admins("[span_pink("OPFOR:")] CHANGES REQUESTED: [ADMIN_LOOKUPFLW(user)] has requested changes to their opposing force. Please review the opposing force and approve or deny the changes when submitted.")

/datum/opposing_force/proc/get_status_string()
	return "[status == OPFOR_STATUS_AWAITING_APPROVAL ? "[status], you are number [SSopposing_force.get_queue_position(src)] in the queue" : status]"

/datum/opposing_force/proc/request_update(mob/user)
	if(!COOLDOWN_FINISHED(src, request_update_cooldown))
		return

	if(status != OPFOR_STATUS_AWAITING_APPROVAL)
		return

	message_admins(span_command_headset("[span_pink("OPFOR:")] UPDATE REQUEST: [ADMIN_LOOKUPFLW(user)] has requested an update on their OPFOR application!"))
	add_log(user.ckey, "Requested an update")

	for(var/client/staff as anything in GLOB.admins)
		if(staff.prefs.toggles & SOUND_ADMINHELP)
			SEND_SOUND(staff, sound('sound/effects/hygienebot_happy.ogg'))
		window_flash(staff, ignorepref = TRUE)

	COOLDOWN_START(src, request_update_cooldown, OPFOR_REQUEST_UPDATE_COOLDOWN)

/datum/opposing_force/proc/submit_to_subsystem(mob/user)
	if(status != OPFOR_STATUS_NOT_SUBMITTED && status != OPFOR_STATUS_CHANGES_REQUESTED)
		return FALSE
	// Subsystem checks, no point in bloating the system if it's not accepting more.
	var/availability = SSopposing_force.check_availability()
	if(availability != OPFOR_SUBSYSTEM_READY)
		to_chat(usr, examine_block(span_warning("Error, the OPFOR subsystem rejected your request. Reason: <b>[availability]</b>")))
		return FALSE

	var/queue_position = SSopposing_force.add_to_queue(src)

	status = OPFOR_STATUS_AWAITING_APPROVAL
	can_edit = FALSE
	add_log(user.ckey, "Submitted to the OPFOR subsystem")
	message_admins("[span_pink("OPFOR:")] SUBMISSION: [ADMIN_LOOKUPFLW(user)] has submitted their opposing force to the OPFOR subsystem. They are number [queue_position] in the queue.")
	to_chat(usr, examine_block(span_greentext(("You have been added to the queue for the OPFOR subsystem. You are number <b>[queue_position]</b> in line."))))

/datum/opposing_force/proc/set_objective_intensity(mob/user, datum/opposing_force_objective/opposing_force_objective, new_intensity)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	var/sanitized_intensity = sanitize_integer(new_intensity)
	switch(sanitized_intensity)
		if(1)
			opposing_force_objective.text_intensity = OPFOR_GOAL_INTENSITY_1
		if(2)
			opposing_force_objective.text_intensity = OPFOR_GOAL_INTENSITY_2
		if(3)
			opposing_force_objective.text_intensity = OPFOR_GOAL_INTENSITY_3
		if(4)
			opposing_force_objective.text_intensity = OPFOR_GOAL_INTENSITY_4
		if(5)
			opposing_force_objective.text_intensity = OPFOR_GOAL_INTENSITY_5
	add_log(user.ckey, "Set updated an objective intensity from [opposing_force_objective.intensity] to [sanitized_intensity]")
	opposing_force_objective.intensity = sanitized_intensity
	return TRUE

/datum/opposing_force/proc/set_objective_description(mob/user, datum/opposing_force_objective/opposing_force_objective, new_description)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	var/sanitized_description = sanitize_text(new_description)
	add_log(user.ckey, "Updated objective([opposing_force_objective.title]) DESCRIPTION from: [opposing_force_objective.description] to: [sanitized_description]")
	opposing_force_objective.description = sanitized_description
	return TRUE

/datum/opposing_force/proc/set_objective_justification(mob/user, datum/opposing_force_objective/opposing_force_objective, new_justification)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	var/sanitize_justification = sanitize_text(new_justification)
	add_log(user.ckey, "Updated objective([opposing_force_objective.title]) JUSTIFICATION from: [opposing_force_objective.justification] to: [sanitize_justification]")
	opposing_force_objective.justification = sanitize_justification
	return TRUE

/datum/opposing_force/proc/remove_objective(mob/user, datum/opposing_force_objective/opposing_force_objective)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("[user] tried to remove a non existent opfor objective!")
	objectives -= opposing_force_objective
	add_log(user.ckey, "Removed an objective: [opposing_force_objective.title]")
	qdel(opposing_force_objective)
	return TRUE

/datum/opposing_force/proc/add_objective(mob/user)
	if(!can_edit)
		return
	if(LAZYLEN(objectives) >= OPFOR_MAX_OBJECTIVES)
		to_chat(user, span_warning("You have too many objectives, please remove one!"))
	objectives += new /datum/opposing_force_objective
	add_log(user.ckey, "Added a new blank objective")
	return TRUE

/datum/opposing_force/proc/set_objective_title(mob/user, datum/opposing_force_objective/opposing_force_objective, new_title)
	if(!can_edit)
		return
	var/sanitized_title = sanitize_text(new_title)
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	add_log(user.ckey, "Updated objective([opposing_force_objective.title]) TITLE from: [opposing_force_objective.title] to: [sanitized_title]")
	opposing_force_objective.title = sanitized_title
	return TRUE

/datum/opposing_force/proc/set_backstory(mob/user, incoming_backstory)
	if(!can_edit)
		return
	var/sanitized_backstory = sanitize_text(incoming_backstory)
	add_log(user.ckey, "Updated BACKSTORY from: [set_backstory] to: [sanitized_backstory]")
	set_backstory = sanitized_backstory
	return TRUE

/datum/opposing_force/proc/add_log(ckey, new_log)
	var/msg = "[ckey ? ckey : "SYSTEM"] - [new_log]"
	modification_log += msg
	log_admin(msg)

/mob/verb/opposing_force()
	set name = "Opposing Force"
	set category = "OOC"
	set desc = "View your opposing force panel, or request one."
	// Mind checks
	if(!mind)
		var/fail_message = "You have no mind!"
		if(isobserver(src))
			fail_message += " You have to be in the current round at some point to have one."
		to_chat(src, span_warning(fail_message))
		return

	if(!mind.opposing_force)
		var/datum/opposing_force/opposing_force = new(usr, mind)
		mind.opposing_force = opposing_force
		SSopposing_force.new_opfor(opposing_force)
	mind.opposing_force.ui_interact(usr)

