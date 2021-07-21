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
		to_chat(src, span_adminhelp("You cannot have ambitions."))
		return

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

	// AUTO APPROVAL //
	var/aa_timerid
	var/aa_active
	var/aa_honked

/datum/ambitions/proc/connect(datum/mind/owner)
	src.owner = owner
	owner_ckey = owner.key
	owner.ambitions = src
	// add_verb(owner.current, /mob/proc/cmd_view_ambitions)
	_log("CONNECTED [owner_ckey]")
	greet()

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
	QDEL_LIST(objectives)
	QDEL_LIST(amb_history)
	QDEL_LIST(amb_touches)
	GLOB.ambitions -= src
	GLOB.ambitions -= owner_ckey
	owner = null
	return ..()

/datum/ambitions/ui_status(mob/user)
	if(user.mind == owner || check_rights_for(user.client, R_ADMIN))
		return UI_INTERACTIVE
	return UI_CLOSE

/datum/ambitions/ui_interact(mob/user, datum/tgui/ui)
	_log("UI INTERACT")
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "Ambitions")
		ui.open()

/datum/ambitions/ui_data(mob/user)
	. = list()
	.["name"] = name
	.["backstory"] = backstory
	.["employer"] = employer
	.["objectives"] = objectives
	.["intensity"] = intensity
	.["intensities"] = INTENSITY_ALL

	.["obj_keys"] = list()
	.["antag_types"] = list()
	for(var/antag in objectives)
		.["antag_types"] += antag
		for(var/datum/ambition_objective/objective as anything in objectives[antag])
			.["obj_keys"] += objective.key

	.["is_antag"] = LAZYLEN(owner_antags)
	.["antags"] = list()
	for(var/datum/antagonist/antag as anything in owner_antags)
		.["antags"] += antag.name

	.["admin"] = list(
		"is_admin" = check_rights_for(user.client, R_ADMIN),
		"handling" = handling,
		"submitted" = submitted,
		"approved" = approved,
		"changes_requested" = changes_requested,
	)

/datum/ambitions/ui_act(action, list/params)
	_log("UIACT=[action]")
	. = ..()
	if(.)
		return

	switch(action)
		if("name")
			name = params["name"]
			return TRUE

		if("backstory")
			backstory = params["backstory"]
			return TRUE

		if("employer")
			employer = params["employer"]
			return TRUE

		if("intensity")
			intensity = params["intensity"]
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
	_log("AUTOAPPROVE=STOP")
	message_admins(span_adminhelp("Ambition Auto-Approval for [owner_ckey] has been stopped."))
	deltimer(aa_timerid)
	aa_timerid = 0
	aa_active = FALSE
	return

/datum/ambitions/proc/autoapprove_approve()
	_log("AUTOAPPROVE=APPROVE")
	handling = "Auto-Approve"
	approve()
	return

/datum/ambitions/proc/approve()
	_log("APPROVED")
	approved = TRUE
	to_chat(owner.current, span_adminhelp("Your ambitions have been approved and you have receieved any applicable gear. Check your Memory."))
	message_admins(span_adminhelp("[owner_ckey]'s ambitions have been approved by [handling]."))
	for(var/datum/antagonist/antag as anything in owner_antags)
		antag.objectives.Cut()
		for(var/datum/ambition_objective/ambition as anything in (objectives[antag]))
			var/datum/objective/_obj = new /datum/objective(ambition.desc)
			_obj.name = ambition.name
			antag.objectives += _obj
		if(!antag.ambitions_approved)
			antag.silent = TRUE
			antag.on_gain()
			antag.ambitions_approved = TRUE

/datum/ambitions/proc/handle(client/handler)
	_log("HANDLED")
	handling = handler.ckey
	if(aa_active)
		autoapprove_stop()
	message_admins("[owner_ckey]'s ambitions are being handled by [handling]")
	to_chat(owner.current, span_adminhelp("Your ambitions are now being handled by an admin."))
