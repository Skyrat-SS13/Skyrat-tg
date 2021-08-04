#define AMBITION_AUTOAPPROVE_TIMER 20 MINUTES

/// Does this antagonist use ambitions
/datum/antagonist/var/ambitions_uses = FALSE

/// This var simply stores whether or not this ambition was approved already.
/// This ensures we dont equip traitors twice for example.
/datum/antagonist/var/ambitions_approved = FALSE

/// This is a verb which allows a mob to view their mind's ambitions.
/mob/verb/cmd_view_ambitions()
	set name = "View Ambitions"
	set category = "IC"

	if(!mind || !length(mind.antag_datums))
		if(!check_rights_for(client, R_ADMIN))
			to_chat(src, span_adminhelp("You cannot have ambitions."))
			return
		to_chat(src, span_adminhelp("You cannot have ambitions however you are bypassing this with admin powers."))
		if(!mind.ambitions)
			var/datum/antagonist/custom/amb = new
			amb.name = "Setup Your Ambitions"
			amb.ambitions_uses = TRUE
			mind.add_antag_datum(amb)

	mind.ambitions.ui_interact(usr)

/datum/ambitions
	// OWNER INFO //
	var/datum/mind/owner
	var/owner_ckey
	var/list/datum/antagonist/owner_antags = list()

	// STORY MAKING //
	var/name
	var/employer
	var/backstory
	var/intensity
	var/list/datum/ambition_objective/objectives = list()

	// RECORD KEEPING //
	var/list/amb_history = list()
	var/list/amb_touches = list()

	// ADMINISTRATION //
	var/submitted
	var/list/changes_requested = list()
	var/approved
	var/handling
	var/rejected

	// UI DATA //
	var/ui_page = 0
	var/filter

	// AUTO APPROVAL //
	var/aa_timerid
	var/aa_active
	var/aa_honked

/datum/ambitions/proc/connect(datum/mind/owner)
	if(rejected) // Do not allow them to connect to a rejected ambition
		return
	src.owner = owner
	update_owner()
	// add_verb(owner.current, /mob/proc/cmd_view_ambitions)
	_log("CONNECTED [owner_ckey]")
	greet()

/datum/ambitions/proc/update_owner()
	if(!owner)
		CRASH("no owner")
	owner_ckey = owner.key
	owner.ambitions = src
	verify_objectives()

/datum/ambitions/proc/disconnect()
	if(owner)
		// remove_verb(owner.current, /mob/proc/cmd_view_ambitions)
		owner.ambitions = null
		owner = null
	_log("DISCONNECTED [owner_ckey]")

/datum/ambitions/proc/_touched()
	amb_touches += "\[[time_stamp()]\]\[[usr.ckey]\]"

/datum/ambitions/proc/_log(log)
	amb_history += "\[[time_stamp()]\] [log]"

/datum/ambitions/New(datum/mind/owner)
	if(!owner)
		CRASH("No owner for new ambitions")
	_log("Created")
	connect(owner)

/datum/ambitions/Destroy()
	objectives = null
	amb_history = null
	amb_touches = null
	GLOB.ambitions -= src
	GLOB.ambitions -= owner_ckey
	owner = null
	return ..()

/datum/ambitions/ui_status(mob/user)
	if(user.mind == owner || check_rights_for(user.client, R_ADMIN))
		return UI_INTERACTIVE
	return UI_CLOSE

/datum/ambitions/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Ambitions")
		ui.open()

/datum/ambitions/ui_data(mob/user)
	. = list()
	.["intensities"] = INTENSITY_ALL
	.["antags"] = list()
	.["is_malf"] = !!owner.has_antag_datum(/datum/antagonist/malf_ai)
	.["filter"] = filter
	.["objectives_avail"] = get_available_objectives(.["filter"])
	.["name"] = name
	.["backstory"] = backstory
	.["employer"] = employer
	.["objectives"] = objectives
	.["intensity"] = intensity
	.["obj_refs"] = list()
	.["antag_types"] = list()
	.["page"] = ui_page
	.["is_antag"] = LAZYLEN(owner_antags)

	for(var/datum/antagonist/antag as anything in owner_antags)
		.["antags"] += antag.name

	for(var/datum/ambition_objective/objective as anything in objectives)
		.["obj_refs"] += REF(objective)

	.["admin"] = list()
	.["admin"]["auth"] = check_rights_for(user.client, R_ADMIN)
	.["admin"]["handling"] = handling
	.["admin"]["submitted"] = submitted
	.["admin"]["approved"] = approved
	.["admin"]["changes_requested"] = changes_requested

/datum/ambitions/proc/get_available_objectives(filter)
	. = list()
	for(var/datum/ambition_objective/amb_obj as anything in GLOB.ambition_objectives)
		if(filter && !findtext(amb_obj.name, filter))
			continue
		if(amb_obj.allow_select(src, objectives))
			. += amb_obj

/datum/ambitions/ui_act(action, list/params)
	. = ..()
	if(.)
		return

	if(check_rights_for(usr.client, R_ADMIN)) //ui_act is called via a Topic, so this is safe
		autoapprove_stop() // An admin has done literally anything to us = cancel autoapproval
		switch(action)
			if("handle")
				handle(usr.client)
				return TRUE

			if("approve")
				approve()
				return TRUE

			if("changes")
				if(!length(params["changes"]))
					to_chat(usr, span_notice("You did not specify any changes to be done."))
					return FALSE
				request_changes(params["changes"])
				return TRUE

			if("reject")
				reject(params["reason"])
				return TRUE
	else
		if(usr.ckey != owner_ckey) // We arent an admin and our ckey is wrong = Spoofed.
			message_admins(span_adminhelp(span_boldwarning("[usr.ckey] attempted to Topic spoof the ambitions of [owner_ckey].")))
			SStgui.close_user_uis(usr, src)
			return FALSE
		if(rejected)
			SStgui.close_user_uis(usr, src)
			return FALSE

	switch(action)
		if("name")
			var/_new = params["name"]
			_log("Name change: '[name]' => '[_new]'")
			name = _new
			return TRUE

		if("backstory")
			var/_new = params["backstory"]
			_log("Backstory change: '[backstory]' => '[_new]'")
			backstory = _new
			return TRUE

		if("employer")
			var/_new = params["employer"]
			_log("Employer change: '[employer]' => '[_new]'")
			employer = _new
			return TRUE

		if("intensity")
			var/_new = params["intensity"]
			_log("Intensity change: '[intensity]' => '[_new]'")
			intensity = _new
			return TRUE

		if("filter")
			filter = params["filter"]
			return TRUE

		if("objective-add")
			if(!objective_select(params["objective_ref"]))
				to_chat(usr, span_boldwarning("Unable to register with objective. If this continues ahelp."))
				return FALSE
			return TRUE

		if("objective-rem")
			objective_remove(params["objective_ref"])
			return TRUE

		else
			stack_trace("Unhandled Ambition Act [action]")
			return TRUE

/datum/ambitions/proc/greet()
	_log("GREETED")
	//TODO
	return

/datum/ambitions/proc/apply_template(datum/ambition_template/template_ref)
	_log("TEMPLATE=[template_ref.name]")
	//TODO
	return

/datum/ambitions/proc/autoapprove_start()
	_log("AUTOAPPROVE=START")
	if(handling)
		CRASH("Call to autoapprove_start despite having a handler")

	if(!aa_honked)
		aa_honked = TRUE
		for(var/client/admin as anything in GLOB.admins)
			window_flash(admin, TRUE)
			if(!(admin.prefs.toggles & SOUND_ADMINHELP))
				continue
			SEND_SOUND(admin, sound('sound/effects/hygienebot_happy.ogg'))

	aa_timerid = addtimer(CALLBACK(src, .proc/autoapprove_approve), AMBITION_AUTOAPPROVE_TIMER, TIMER_STOPPABLE|TIMER_CLIENT_TIME|TIMER_UNIQUE)
	aa_active = TRUE
	message_admins(span_adminhelp("Ambition Auto-Approval for [owner_ckey] has begun and will finish in [DisplayTimeText(AMBITION_AUTOAPPROVE_TIMER)]. Cancel it by opening the AmbitionUI and <b>Handling</b> it."))
	return

/datum/ambitions/proc/autoapprove_stop()
	_log("APP: STOP")
	message_admins(span_adminhelp("Ambition Auto-Approval for [owner_ckey] has been stopped."))
	deltimer(aa_timerid)
	aa_timerid = 0
	aa_active = FALSE
	return

/datum/ambitions/proc/autoapprove_approve()
	_log("APP: START")
	handling = "Auto-Approve"
	approve()
	return

/datum/ambitions/proc/approve()
	_log("APP: APPROVE")
	approved = TRUE
	to_chat(owner.current, span_adminhelp("Your ambitions have been approved and you have receieved any applicable gear. Check your Memory."))
	message_admins(span_adminhelp("[owner_ckey]'s ambitions have been approved by [handling]."))
	for(var/datum/antagonist/antag as anything in owner_antags)
		antag.objectives.Cut()
		for(var/datum/ambition_objective/ambition as anything in objectives)
			ambition.on_approved(src) // This might end up being called twice, or more times, depending on what happens with the client; this might need to be changed later
			var/datum/objective/_obj = new /datum/objective(ambition.desc)
			_obj.name = ambition.name
			antag.objectives += _obj
		if(!antag.ambitions_approved)
			antag.silent = TRUE
			antag.on_gain()
			antag.ambitions_approved = TRUE

/datum/ambitions/proc/verify_objectives()
	var/tmp/rem = 0
	for(var/datum/ambition_objective/amb_obj as anything in objectives)
		if(!length(owner_antags & amb_obj.allowed_antag_types))
			rem++
			objectives -= amb_obj
	if(rem)
		to_chat(owner, "[rem] objective[ rem == 1 ? "" : "s" ] were automatically removed due to different antag requirements.")

/datum/ambitions/proc/handle(client/handler)
	_log("HANDLED")
	handling = handler.ckey
	if(aa_active)
		autoapprove_stop()
	message_admins("[owner_ckey]'s ambitions are being handled by [handling]")
	to_chat(owner.current, span_adminhelp("Your ambitions are now being handled by an admin."))

/datum/ambitions/proc/objective_select(obj_ref)
	var/datum/ambition_objective/amb_obj = locate(obj_ref)
	if(!istype(amb_obj))
		stack_trace("illegal ambition objective reference")
		return FALSE

	if(!amb_obj.on_select(src))
		return FALSE

	_log("OBJ++ '[amb_obj.name]'")
	objectives |= amb_obj
	return TRUE

/datum/ambitions/proc/objective_remove(obj_ref)
	var/datum/ambition_objective/amb_obj = locate(obj_ref)
	if(!istype(amb_obj))
		stack_trace("illegal ambition objective reference")
		return FALSE

	if(!(amb_obj in objectives))
		return TRUE

	_log("OBJ-- '[amb_obj.name]'")
	amb_obj.on_deselect(src)
	objectives -= amb_obj

/datum/ambitions/proc/reject(reason)
	if(tgui_alert(usr, "Are you sure you want to reject these ambitions?", "Reject", list("Yes", "No")) != "Yes")
		return
	if(!reason)
		reason = input(usr, "Reason") as message|null
		if(!reason)
			return
		reason = sanitize(reason)
	_log("Rejected: [reason]")
	SStgui.close_user_uis(owner.current, src)
	to_chat(owner, span_adminhelp("Your ambitions have been rejected: '[reason]'. You are no longer an antag."))
	message_admins(span_adminhelp("[owner_ckey]'s ambitions have been rejected."))
	for(var/datum/ambition_objective/amb_obj as anything in objectives)
		amb_obj.on_deselect(src)
	rejected = TRUE
	owner.remove_all_antag_datums()
	disconnect()

/datum/ambitions/proc/request_changes(changes)
	_log("ChangeRequest: [changes]")
	changes_requested += changes
	to_chat(owner.current, span_adminhelp("Ambition changes requested: [changes]"))
