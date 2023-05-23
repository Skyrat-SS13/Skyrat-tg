/// A datum that's mainly used to get exploitables for antagonists.
/datum/record_manifest

/// Proc that returns a list of all the exploitables there is currently.
/datum/manifest/proc/get_exploitable_manifest()
	var/list/exp_manifest_out = list()
	for(var/datum/job_department/department as anything in SSjob.joinable_departments)
		exp_manifest_out[department.department_name] = list()

	exp_manifest_out[DEPARTMENT_UNASSIGNED] = list()

	var/list/departments_by_type = SSjob.joinable_departments_by_type

	for(var/datum/record/crew/crew_record in GLOB.manifest.general)
		var/exploitables = crew_record.exploitable_information

		var/exploitables_empty = ((length(exploitables) < 1) || ((exploitables) == EXPLOITABLE_DEFAULT_TEXT))

		if (exploitables_empty)
			continue

		var/name = crew_record.name
		var/rank = crew_record.rank
//		var/truerank = crew_record.truerank
		var/datum/job/job = SSjob.GetJob(rank)

		if(!job || !(job.job_flags & JOB_CREW_MANIFEST) || !LAZYLEN(job.departments_list) && (!exploitables_empty)) // In case an unlawful custom rank is added.
			var/list/exp_misc_list = exp_manifest_out[DEPARTMENT_UNASSIGNED]
			exp_misc_list[++exp_misc_list.len] = list(
				"name" = name,
				"rank" = rank,
//				"truerank" = truerank,
				"exploitable_information" = exploitables,
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
				"exploitable_information" = exploitables,
			)

			var/list/exp_department_list = exp_manifest_out[department.department_name]

			if(istype(job, department.department_head))
				exp_department_list.Insert(1, exp_entry) // add the dept head's entry to front of dept section
			else
				exp_department_list.Add(exp_entry) // add the rest after

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
		var/datum/record/crew/target_record = find_record(exploitable_id)
		if(!isnull(target_record)) // this can be null
			to_chat(usr, "<b>Exploitable information:</b> [target_record.exploitable_information]")

	else if(action == "show_background")
		var/background_id = params["background_id"]
		var/datum/record/crew/target_record = find_record(background_id)
		if(!isnull(target_record))
			to_chat(usr, "<b>Background information:</b> [target_record.background_information]")


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
		"manifest" = GLOB.manifest.get_exploitable_manifest(),
		"positions" = positions
	)
