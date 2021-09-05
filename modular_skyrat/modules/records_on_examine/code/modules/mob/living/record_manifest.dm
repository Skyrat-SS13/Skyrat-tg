/datum/record_manifest

/datum/record_manifest/ui_state(mob/user)
	return GLOB.always_state

/datum/record_manifest/ui_status(mob/user, datum/ui_state/state)
	return (is_special_character(user)) ? UI_INTERACTIVE : UI_CLOSE

/datum/record_manifest/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "RecordManifest")
		ui.open()

/datum/record_manifest/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return
	if(action == "show_exploitables")
		var/exploitable_id = params["exploitable_id"]
		var/datum/data/record/exploitable_record = find_record("name", exploitable_id, GLOB.data_core.locked)
		to_chat(usr, "<b>Exploitable information:</b> [exploitable_record.fields["exp_records"]]")

/datum/record_manifest/ui_data(mob/user)
	var/list/positions = list()
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		var/list/exceptions = list()
		for(var/datum/job/job as anything in department.department_jobs)
			if(job.total_positions == -1)
				exceptions += job.title
				continue
		positions[department.department_name] = list("exceptions" = exceptions)

	return list(
		"manifest" = GLOB.data_core.get_manifest(),
		"positions" = positions
	)
