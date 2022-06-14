/datum/record_manifest

/datum/datacore/proc/get_exploitable_manifest()
	var/list/exp_manifest_out = list()
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		exp_manifest_out[department.department_name] = list()
	exp_manifest_out[DEPARTMENT_UNASSIGNED] = list()

	var/list/departments_by_type = SSjob.joinable_departments_by_type
	for(var/datum/data/record/general_record in GLOB.data_core.general)
		var/exploitables = general_record.fields["exploitable_records"]
		var/exploitables_empty = ((length(exploitables) < 1) || ((exploitables) == EXPLOITABLE_DEFAULT_TEXT))
		if (exploitables_empty)
			continue
		var/name = general_record.fields["name"]
		var/rank = general_record.fields["rank"]
//		var/truerank = general_record.fields["truerank"]
		var/datum/job/job = SSjob.GetJob(rank)
		if(!job || !(job.job_flags & JOB_CREW_MANIFEST) || !LAZYLEN(job.departments_list) && (!exploitables_empty)) // In case an unlawful custom rank is added.
			var/list/exp_misc_list = exp_manifest_out[DEPARTMENT_UNASSIGNED]
			exp_misc_list[++exp_misc_list.len] = list(
				"name" = name,
				"rank" = rank,
//				"truerank" = truerank,
				"exploitable_records" = exploitables,
				)
			continue
		for(var/department_type as anything in job.departments_list)
			var/datum/job_department/department = departments_by_type[department_type]
			if(!department)
				stack_trace("get_exploitable_manifest() failed to get job department for [department_type] of [job.type]")
				continue
			var/list/exp_entry = list(
				"name" = name,
				"rank" = rank,
//				"truerank" = truerank,
				"exploitable_records" = exploitables,
				)
			var/list/exp_department_list = exp_manifest_out[department.department_name]
			if(istype(job, department.department_head))
				exp_department_list.Insert(1, null)
				exp_department_list[1] = exp_entry
			else
				exp_department_list[++exp_department_list.len] = exp_entry

	// Trim the empty categories.
	for (var/department in exp_manifest_out)
		if(!length(exp_manifest_out[department]))
			exp_manifest_out -= department

	return exp_manifest_out

/datum/record_manifest/ui_state(mob/user)
	return GLOB.always_state

/datum/record_manifest/ui_status(mob/user, datum/ui_state/state)
	return ((user.mind.can_see_exploitables) || (user.mind.has_exploitables_override)) ? UI_INTERACTIVE : UI_CLOSE

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
		var/datum/data/record/general_record = find_record("name", exploitable_id, GLOB.data_core.general)
		to_chat(usr, "<b>Exploitable information:</b> [general_record.fields["exploitable_records"]]")

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
		"manifest" = GLOB.data_core.get_exploitable_manifest(),
		"positions" = positions
	)
