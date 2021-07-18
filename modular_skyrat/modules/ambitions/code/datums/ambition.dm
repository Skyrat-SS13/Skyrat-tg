/client/var/datum/ambitions/ambitions

GLOBAL_LIST_EMPTY(ambitions)
GLOBAL_PROTECT(ambitions)

/client/Destroy()
	if(ambitions)
		ambitions._log("DISCONNECTED")
		ambitions.owner = null
		ambitions = null
	return ..()

/client/New()
	if(GLOB.ambitions[ckey])
		ambitions = GLOB.ambitions[ckey]
		ambitions.owner = src
	return ..()

/datum/ambitions
	// OWNER INFO //
	var/client/owner
	var/owner_ckey

	// STORY MAKING //
	var/name
	var/employer
	var/backstory
	var/intensity
	var/list/datum/ambition_objective/objectives

	// RECORD KEEPING //
	var/list/amb_history
	var/list/amb_touches

	// ADMINISTRATION //
	var/submitted
	var/list/changes_requested
	var/approved
	var/handling

	// AUTO APPROVAL //
	var/aa_timerid
	var/aa_active
	var/aa_honked

/datum/ambitions/proc/_touched()
	amb_touches += "\[[time_stamp()]\]\[[usr.ckey]\]"

/datum/ambitions/proc/_log(log)
	amb_history += "\[[time_stamp()]\] [log]"

/datum/ambitions/New(client/owner)
	_log("Created")
	if(!owner)
		CRASH("No owner for new ambitions")
	owner_ckey = owner.ckey
	src.owner = owner
	objectives = list()
	amb_history = list()
	amb_touches = list()

/datum/ambitions/Destroy()
	QDEL_LIST(objectives)
	QDEL_LIST(amb_history)
	QDEL_LIST(amb_touches)
	GLOB.ambitions -= src
	GLOB.ambitions -= owner_ckey
	owner = null
	return ..()

/datum/ambitions/ui_status(mob/user)
	if(user.client == parent || check_rights_for(user.client, R_ADMIN))
		return UI_INTERACTIVE
	return UI_CLOSE

/datum/ambitions/ui_interact(mob/user, datum/tgui/ui)
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
	.["objective_keys"] = list()
	for(var/datum/ambition_objective/objective as anything in objectives)
		.["obj_keys"] += objective.key

/datum/ambitions/ui_act(action, list/params)
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
	return FALSE

/datum/ambitions/proc/greet()
	//TODO
	return

/datum/ambitions/proc/apply_template(template_ref)
	//TODO
	return

/datum/ambitions/proc/autoapprove_start()
	//TODO
	return

/datum/ambitions/proc/autoapprove_stop()
	//TODO
	return

/datum/ambitions/proc/autoapprove_approve()
	//TODO
	return
