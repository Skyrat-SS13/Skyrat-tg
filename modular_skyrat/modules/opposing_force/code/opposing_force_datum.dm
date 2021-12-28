/datum/opposing_force_selected_equipment
	/// Reference to the selected equipment datum.
	var/datum/opposing_force_equipment/opposing_force_equipment
	/// Why does the user need this?
	var/reason = ""
	/// What is the status of this item?
	var/status = OPFOR_EQUIPMENT_STATUS_NOT_REVIEWED
	/// If rejected, why?
	var/rejected_reason = ""
	/// How many does the user want?
	var/count = 1

/datum/opposing_force_selected_equipment/New(datum/opposing_force_equipment/opfor_equipment)
	if(opfor_equipment)
		opposing_force_equipment = opfor_equipment


/datum/opposing_force_selected_equipment/Destroy(force, ...)
	opposing_force_equipment = null
	return ..()

/datum/opposing_force_objective
	/// The name of the objective
	var/title = ""
	/// The actual objective.
	var/description = ""
	/// The reason for the objective.
	var/justification = ""
	/// Was this specific objective approved by the admins?
	var/status = OPFOR_OBJECTIVE_STATUS_NOT_REVIEWED
	/// Why was this objective denied? If a reason was specified.
	var/denial_reason = ""
	/// How intense is this goal?
	var/intensity = 1
	/// The text intensity of this goal
	var/text_intensity = OPFOR_OBJECTIVE_INTENSITY_1

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
	/// For logging stuffs
	var/list/modification_log = list()
	/// Can we edit things?
	var/can_edit = TRUE
	/// The reason we were denied.
	var/denied_reason
	/// Any changes required
	var/requested_changes
	/// Have we been request update muted by an admin?
	var/request_updates_muted = FALSE
	/// A text list of the admin chat.
	var/list/admin_chat = list()
	/// Have we issued the player their equipment?
	var/equipment_issued = FALSE
	/// A list of equipment that the user has requested.
	var/list/selected_equipment = list()
	/// Are we blocked from submitting a new request?
	var/blocked = FALSE

	COOLDOWN_DECLARE(static/request_update_cooldown)

/datum/opposing_force/New(mind_reference)//user can either be a client or a mob due to byondcode(tm)
	src.mind_reference = mind_reference

/datum/opposing_force/Destroy(force)
	mind_reference.opposing_force = null
	mind_reference = null
	SSopposing_force.remove_opfor(src)
	QDEL_LIST(objectives)
	QDEL_LIST(admin_chat)
	QDEL_LIST(modification_log)
	return ..()

/datum/opposing_force/Topic(href, list/href_list)
	if(href_list["admin_pref"])
		switch(href_list["admin_pref"])
			if("show_panel")
				if(!check_rights(R_ADMIN))
					send_admins_opfor_message("Detected possible HREF exploit!")
					CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
				ui_interact(usr)
				return TRUE

/datum/opposing_force/proc/build_html_panel_entry()
	var/list/opfor_entry = list("<b>[mind_reference.key]</b> - ")
	opfor_entry += "<a href='?priv_msg=[ckey(mind_reference.key)]'>PM</a> "
	if(mind_reference.current)
		opfor_entry += "<a href='?_src_=holder;[HrefToken()];adminplayerobservefollow=[REF(mind_reference?.current)]'>FLW</a> "
	opfor_entry += "<a href='?src=[REF(src)];admin_pref=show_panel'>Show OPFOR Panel</a>"
	return opfor_entry.Join()

/datum/opposing_force/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "OpposingForcePanel")
		ui.open()

/datum/opposing_force/ui_state(mob/user)
	return GLOB.always_state

/datum/opposing_force/ui_data(mob/user)
	var/list/data = list()

	data["admin_mode"] = check_rights_for(user.client, R_ADMIN)

	data["creator_ckey"] = mind_reference.key ? mind_reference.key : ""

	data["backstory"] = set_backstory

	data["status"] = get_status_string()

	data["can_submit"] = SSopposing_force.accepting_objectives && (status == OPFOR_STATUS_NOT_SUBMITTED || status == OPFOR_STATUS_CHANGES_REQUESTED)

	data["can_request_update"] = status == OPFOR_STATUS_AWAITING_APPROVAL && COOLDOWN_FINISHED(src, request_update_cooldown) ? TRUE : FALSE && !request_updates_muted

	data["request_updates_muted"] = request_updates_muted

	data["can_edit"] = can_edit

	data["approved"] = status == OPFOR_STATUS_APPROVED ? TRUE : FALSE

	var/list/messages = list()
	for(var/message in admin_chat)
		messages.Add(list(list(
			"msg" = message
		)))
	data["messages"] = messages

	data["objectives"] = list()
	var/objective_num = 1
	for(var/datum/opposing_force_objective/opfor as anything in objectives)
		var/list/objective_data = list(
			id = objective_num,
			ref = REF(opfor),
			title = opfor.title,
			description = opfor.description,
			intensity = opfor.intensity,
			text_intensity = opfor.text_intensity,
			justification = opfor.justification,
			approved = opfor.status == OPFOR_OBJECTIVE_STATUS_APPROVED ? TRUE : FALSE,
			status_text = opfor.status,
			denied_text = opfor.denial_reason,
			)
		objective_num++
		data["objectives"] += list(objective_data)

	data["equipment_issued"] = equipment_issued

	data["equipment_list"] = list()
	for(var/equipment_category in SSopposing_force.equipment_list)
		var/category_items = list()
		for(var/datum/opposing_force_equipment/opfor_equipment as anything in SSopposing_force.equipment_list[equipment_category])
			category_items += list(list(
				ref = REF(opfor_equipment),
				name = opfor_equipment.name,
				description = opfor_equipment.description,
				equipment_category = opfor_equipment.category,
			))
		data["equipment_list"] += list(list(
			category = equipment_category,
			items = category_items,
		))

	data["selected_equipment"] = list()
	for(var/datum/opposing_force_selected_equipment/equipment as anything in selected_equipment)
		var/list/equipment_data = list(
			ref = REF(equipment),
			name = equipment.opposing_force_equipment.name,
			description = equipment.opposing_force_equipment.description,
			item = equipment.opposing_force_equipment.item_type,
			status = equipment.status,
			approved = equipment.status == OPFOR_EQUIPMENT_STATUS_APPROVED ? TRUE : FALSE,
			)
		data["selected_equipment"] += list(equipment_data)

	return data

/datum/opposing_force/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/datum/opposing_force_objective/edited_objective
	if(params["objective_ref"])
		edited_objective = locate(params["objective_ref"]) in objectives
		if(!edited_objective)
			CRASH("Opposing_force passed a reference parameter to an objective that it could not locate!")

	switch(action)
		// General control
		if("set_backstory")
			set_backstory(usr, params["backstory"])
		if("request_update")
			request_update(usr)
		if("request_changes")
			user_request_changes(usr)
		if("close_application")
			close_application(usr)
		if("submit")
			submit_to_subsystem(usr)
		if("send_message")
			send_message(usr, params["message"])
		// Objective control
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
		// Equipment control
		if("select_equipment")
			var/datum/opposing_force_equipment/equipment
			for(var/category in SSopposing_force.equipment_list)
				equipment = locate(params["equipment_ref"]) in SSopposing_force.equipment_list[category]
				if(equipment)
					break
			if(!equipment)
				CRASH("Opposing_force passed a reference parameter to an equipment that it could not locate!")
			select_equipment(usr, equipment)
		if("remove_equipment")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				CRASH("Opposing_force passed a reference parameter to an equipment that it could not locate!")
			remove_equipment(usr, equipment)
		if("set_equipment_reason")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				CRASH("Opposing_force passed a reference parameter to an equipment that it could not locate!")
			set_equipment_reason(usr, equipment, params["new_equipment_reason"])

		//Admin protected procs
		if("approve")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			SSopposing_force.approve(src, usr)
		if("approve_all")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			approve_all(usr)
		if("issue_gear")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			issue_gear(usr)
		if("deny")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			SSopposing_force.deny(src, params["denied_reason"], usr)
		if("mute_request_updates")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			mute_request_updates(usr)
		if("toggle_block")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			toggle_block(usr)
		if("approve_objective")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			approve_objective(usr, edited_objective)
		if("deny_objective")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			var/denial_reason = tgui_input_text(usr, "Denial Reason", "Enter a reason for denying this objective:")
			deny_objective(usr, edited_objective, denial_reason)
		if("approve_equipment")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				CRASH("Opposing_force passed a reference parameter to an equipment that it could not locate!")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			approve_equipment(usr, equipment)
		if("deny_equipment")
			var/datum/opposing_force_selected_equipment/equipment = locate(params["selected_equipment_ref"]) in selected_equipment
			if(!equipment)
				CRASH("Opposing_force passed a reference parameter to an equipment that it could not locate!")
			if(!check_rights(R_ADMIN))
				send_admins_opfor_message("Detected possible HREF exploit!")
				CRASH("Opposing_force TOPIC: Detected possible HREF exploit!")
			var/denial_reason = tgui_input_text(usr, "Denial Reason", "Enter a reason for denying this objective:")
			deny_objective(usr, equipment, denial_reason)

/datum/opposing_force/proc/mute_request_updates(mob/user, override = "none")
	if(override != "none")
		request_updates_muted = override
	else
		request_updates_muted = !request_updates_muted
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] [request_updates_muted ? "muted" : "unmuted"] the help requests function")
	add_log(user.ckey, "[request_updates_muted ? "Muted" : "Unmuted"] user from opposing force help requests.")

/datum/opposing_force/proc/toggle_block(mob/user, override = "none")
	if(override != "none")
		blocked = override
	else
		blocked = !blocked
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] blocked you from submitting new requests")
	add_log(user.ckey, "Blocked user from opposing force requests.")

/datum/opposing_force/proc/approve_all(mob/user)
	for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
		iterating_equipment.status = OPFOR_EQUIPMENT_STATUS_APPROVED
	for(var/datum/opposing_force_objective/opfor as anything in objectives)
		opfor.status = OPFOR_OBJECTIVE_STATUS_APPROVED
	SSopposing_force.approve(src, user)

/datum/opposing_force/proc/issue_gear(mob/user)

/**
 * Equipment procs
 */

/datum/opposing_force/proc/deny_equipment(mob/user, datum/opposing_force_selected_equipment/incoming_equipment, denial_reason = "")
	incoming_equipment.status = OPFOR_EQUIPMENT_STATUS_DENIED
	incoming_equipment.denial_reason = denial_reason
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has rejected equipment '[incoming_equipment.opposing_force_equipment.name]'[denial_reason ? " with the reason '[denial_reason]'" : ""]")
	add_log(user.ckey, "Rejected equipment: [incoming_equipment.opposing_force_equipment.name] with reason: [denial_reason]")

/datum/opposing_force/proc/approve_equipment(mob/user, datum/opposing_force_selected_equipment/incoming_equipment)
	incoming_equipment.status = OPFOR_EQUIPMENT_STATUS_APPROVED
	incoming_equipment.approved = TRUE
	opposing_force_objective.denial_reason = ""
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has approved equipment '[incoming_equipment.opposing_force_equipment.name]'")
	add_log(user.ckey, "Approved equipment: [incoming_equipment.opposing_force_equipment.name]")

/datum/opposing_force/proc/set_equipment_reason(mob/user, datum/opposing_force_selected_equipment/incoming_equipment, new_reason)
	if(!can_edit)
		return
	if(!incoming_equipment)
		CRASH("[user] tried to update a non existent opfor equipment datum!")
	var/sanitized_reason = STRIP_HTML_SIMPLE(new_reason, OPFOR_TEXT_LIMIT_DESCRIPTION)
	add_log(user.ckey, "Updated equipment([incoming_equipment.opposing_force_equipment.name]) REASON from: [incoming_equipment.reason] to: [sanitized_reason]")
	incoming_equipment.reason = sanitized_reason
	return TRUE

/datum/opposing_force/proc/remove_equipment(mob/user, datum/opposing_force_selected_equipment/incoming_equipment)
	if(!can_edit)
		return
	add_log(user.ckey, "Removed equipment: [incoming_equipment.opposing_force_equipment.name]")
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has removed equipment '[incoming_equipment.opposing_force_equipment.name]'")
	selected_equipment -= incoming_equipment
	qdel(selected_equipment)

/datum/opposing_force/proc/select_equipment(mob/user, datum/opposing_force_equipment/opposing_force_equipment, reason)
	if(!can_edit)
		return
	if(LAZYLEN(selected_equipment) >= OPFOR_EQUIPMENT_LIMIT)
		return
	var/datum/opposing_force_selected_equipment/new_selected = new(opposing_force_equipment)
	selected_equipment += new_selected
	add_log(user.ckey, "Selected equipment: [opposing_force_equipment.name]")
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has selected equipment '[opposing_force_equipment.name]'")

/**
 * Control procs
 */

/datum/opposing_force/proc/request_update(mob/user)
	if(!COOLDOWN_FINISHED(src, request_update_cooldown))
		return

	if(status != OPFOR_STATUS_AWAITING_APPROVAL)
		return

	if(request_updates_muted)
		return

	send_admins_opfor_message(span_command_headset("UPDATE REQUEST: [ADMIN_LOOKUPFLW(user)] has requested an update on their OPFOR application!"))
	add_log(user.ckey, "Requested an update")

	for(var/client/staff as anything in GLOB.admins)
		if(staff.prefs.toggles & SOUND_ADMINHELP)
			SEND_SOUND(staff, sound('sound/effects/hygienebot_happy.ogg'))
		window_flash(staff, ignorepref = TRUE)

	COOLDOWN_START(src, request_update_cooldown, OPFOR_REQUEST_UPDATE_COOLDOWN)

/datum/opposing_force/proc/submit_to_subsystem(mob/user)
	if(blocked)
		return FALSE
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
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has submitted the application for review")
	send_admins_opfor_message("SUBMISSION: [ADMIN_LOOKUPFLW(user)] has submitted their opposing force to the OPFOR subsystem. They are number [queue_position] in the queue.")
	to_chat(usr, examine_block(span_greentext(("You have been added to the queue for the OPFOR subsystem. You are number <b>[queue_position]</b> in line."))))

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
		opfor.status = OPFOR_OBJECTIVE_STATUS_NOT_REVIEWED
	status = OPFOR_STATUS_CHANGES_REQUESTED
	SSopposing_force.request_changes(src)
	can_edit = TRUE

	add_log(user.ckey, "Requested changes")
	send_admins_opfor_message("CHANGES REQUESTED: [ADMIN_LOOKUPFLW(user)] has requested changes to their opposing force. Please review the opposing force and approve or deny the changes when submitted.")

/datum/opposing_force/proc/deny(mob/denier, reason = "")
	status = OPFOR_STATUS_DENIED
	can_edit = FALSE
	denied_reason = reason

	for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
		iterating_equipment.status = OPFOR_EQUIPMENT_STATUS_DENIED
	for(var/datum/opposing_force_objective/opfor in objectives)
		opfor.status = OPFOR_OBJECTIVE_STATUS_DENIED

	add_log(denier.ckey, "Denied application")
	to_chat(mind_reference.current, examine_block(span_redtext("Your OPFOR application has been denied by [denier ? get_admin_ckey(denier) : "the OPFOR subsystem"]!")))
	send_system_message(get_admin_ckey(denier) + " has denied the application with the following reason: [reason]")


/datum/opposing_force/proc/approve(mob/approver)
	status = OPFOR_STATUS_APPROVED
	can_edit = FALSE

	add_log(approver.ckey, "Approved application")
	to_chat(mind_reference.current, examine_block(span_greentext("Your OPFOR application has been approved by [approver ? get_admin_ckey(approver) : "the OPFOR subsystem"]!")))
	send_system_message("[approver ? get_admin_ckey(approver) : "The OPFOR subsystem"] has approved the application")

/datum/opposing_force/proc/close_application(mob/user)
	var/choice = tgui_alert(user, "Are you sure you want withdraw your application?", "Confirm", list("Yes", "No"))
	if(choice != "Yes")
		return
	SSopposing_force.remove_opfor(src)
	status = OPFOR_STATUS_NOT_SUBMITTED
	can_edit = TRUE

	for(var/datum/opposing_force_selected_equipment/iterating_equipment as anything in selected_equipment)
		iterating_equipment.status = OPFOR_EQUIPMENT_STATUS_NOT_REVIEWED
	for(var/datum/opposing_force_objective/opfor as anything in objectives)
		opfor.status = OPFOR_OBJECTIVE_STATUS_NOT_REVIEWED

	add_log(user.ckey, "Withdrew application")
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has closed the application")

/datum/opposing_force/proc/set_backstory(mob/user, incoming_backstory)
	if(!can_edit)
		return
	var/sanitized_backstory = STRIP_HTML_SIMPLE(incoming_backstory, OPFOR_TEXT_LIMIT_BACKSTORY)
	add_log(user.ckey, "Updated BACKSTORY from: [set_backstory] to: [sanitized_backstory]")
	set_backstory = sanitized_backstory
	return TRUE


/**
 * Objective procs
 */

/datum/opposing_force/proc/set_objective_intensity(mob/user, datum/opposing_force_objective/opposing_force_objective, new_intensity)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	var/sanitized_intensity = sanitize_integer(new_intensity, 1, 500)
	switch(sanitized_intensity)
		if(0 to 100)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_1
		if(101 to 200)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_2
		if(201 to 300)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_3
		if(301 to 400)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_4
		if(401 to 501)
			opposing_force_objective.text_intensity = OPFOR_OBJECTIVE_INTENSITY_5
	add_log(user.ckey, "Set updated an objective intensity from [opposing_force_objective.intensity] to [sanitized_intensity]")
	opposing_force_objective.intensity = sanitized_intensity
	return TRUE

/datum/opposing_force/proc/set_objective_description(mob/user, datum/opposing_force_objective/opposing_force_objective, new_description)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	var/sanitized_description = STRIP_HTML_SIMPLE(new_description, OPFOR_TEXT_LIMIT_DESCRIPTION)
	add_log(user.ckey, "Updated objective([opposing_force_objective.title]) DESCRIPTION from: [opposing_force_objective.description] to: [sanitized_description]")
	opposing_force_objective.description = sanitized_description
	return TRUE

/datum/opposing_force/proc/set_objective_justification(mob/user, datum/opposing_force_objective/opposing_force_objective, new_justification)
	if(!can_edit)
		return
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	var/sanitize_justification = STRIP_HTML_SIMPLE(new_justification, OPFOR_TEXT_LIMIT_JUSTIFICATION)
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
	var/sanitized_title = STRIP_HTML_SIMPLE(new_title, OPFOR_TEXT_LIMIT_TITLE)
	if(!opposing_force_objective)
		CRASH("[user] tried to update a non existent opfor objective!")
	add_log(user.ckey, "Updated objective([opposing_force_objective.title]) TITLE from: [opposing_force_objective.title] to: [sanitized_title]")
	opposing_force_objective.title = sanitized_title
	return TRUE

/datum/opposing_force/proc/deny_objective(mob/user, datum/opposing_force_objective/opposing_force_objective, deny_reason)
	opposing_force_objective.status = OPFOR_OBJECTIVE_STATUS_DENIED
	opposing_force_objective.denial_reason = deny_reason
	add_log(user.ckey, "Denied objective([opposing_force_objective.title]) WITH REASON: [deny_reason]")
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has rejected objective '[opposing_force_objective.title]' with the reason '[deny_reason]'")

/datum/opposing_force/proc/approve_objective(mob/user, datum/opposing_force_objective/opposing_force_objective)
	opposing_force_objective.status = OPFOR_OBJECTIVE_STATUS_APPROVED
	add_log(user.ckey, "Approved objective([opposing_force_objective.title])")
	send_system_message("[user ? get_admin_ckey(user) : "The OPFOR subsystem"] has approved objective '[opposing_force_objective.title]'")

/**
 * System procs
 */

/datum/opposing_force/proc/add_log(ckey, new_log)
	var/msg = "[ckey ? ckey : "SYSTEM"] - [new_log]"
	modification_log += msg
	log_admin(msg)

/datum/opposing_force/proc/send_admins_opfor_message(message)
	message = "[span_pink("OPFOR:")] [span_admin(message)]"
	to_chat(GLOB.admins,
		type = MESSAGE_TYPE_ADMINLOG,
		html = message,
		confidential = TRUE)

/datum/opposing_force/proc/get_status_string()
	var/subsystem_status = SSopposing_force.check_availability()
	if(subsystem_status != OPFOR_SUBSYSTEM_READY)
		return subsystem_status
	switch(status)
		if(OPFOR_STATUS_AWAITING_APPROVAL)
			return "Awaiting approval, [status], you are number [SSopposing_force.get_queue_position(src)] in the queue"
		if(OPFOR_STATUS_APPROVED)
			return "Approved, please check your objectives for specific approval"
		if(OPFOR_STATUS_DENIED)
			return "Rejected, do not attempt any of your objectives"
		if(OPFOR_STATUS_CHANGES_REQUESTED)
			return "Changes requested, please review your application"
		if(OPFOR_STATUS_NOT_SUBMITTED)
			return OPFOR_STATUS_NOT_SUBMITTED
		else
			return "ERROR"

/datum/opposing_force/proc/get_admin_ckey(mob/user)
	if(user.client?.holder?.fakekey)
		return user.client.holder.fakekey
	return user.ckey

/datum/opposing_force/proc/broadcast_queue_change()
	var/queue_number = SSopposing_force.get_queue_position(src)
	to_chat(mind_reference.current, examine_block(span_nicegreen("Your OPFOR application is now number [queue_number] in the queue.")))
	send_system_message("Application is now number [queue_number] in the queue")

/datum/opposing_force/proc/send_message(mob/user, message)
	message = STRIP_HTML_SIMPLE(message, OPFOR_TEXT_LIMIT_MESSAGE)
	var/message_string
	var/real_round_time = world.timeofday - SSticker.real_round_start_time
	if(check_rights_for(user.client, R_ADMIN) && user != mind_reference)
		message_string = "[time2text(real_round_time, "hh:mm:ss", 0)] (ADMIN) [get_admin_ckey(user)]: " + message
	else
		message_string = "[time2text(real_round_time, "hh:mm:ss", 0)] (USER) [user.ckey]: " + message
	admin_chat += message_string
	add_log(user.ckey, "Sent message: [message]")

/datum/opposing_force/proc/send_system_message(message)
	var/real_round_time = world.timeofday - SSticker.real_round_start_time
	var/message_string = "[time2text(real_round_time, "hh:mm:ss", 0)] SYSTEM: " + message
	admin_chat += message_string
