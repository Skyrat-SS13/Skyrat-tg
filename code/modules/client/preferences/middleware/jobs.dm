/datum/preference_middleware/jobs
	action_delegations = list(
		"set_job_preference" = PROC_REF(set_job_preference),
		// SKYRAT EDIT
		"set_job_title" = PROC_REF(set_job_title),
		// SKYRAT EDIT END
	)

/datum/preference_middleware/jobs/proc/set_job_preference(list/params, mob/user)
	var/job_title = params["job"]
	var/level = params["level"]

	if (level != null && level != JP_LOW && level != JP_MEDIUM && level != JP_HIGH)
		return FALSE

	var/datum/job/job = SSjob.GetJob(job_title)

	if (isnull(job))
		return FALSE

	if (job.faction != FACTION_STATION)
		return FALSE

	if (!preferences.set_job_preference_level(job, level))
		return FALSE

	preferences.character_preview_view?.update_body()

	return TRUE

// SKYRAT EDIT
/datum/preference_middleware/jobs/proc/set_job_title(list/params, mob/user)
	var/job_title = params["job"]
	var/new_job_title = params["new_title"]

	var/datum/job/job = SSjob.GetJob(job_title)

	if (isnull(job))
		return FALSE

	if (!(new_job_title in job.alt_titles))
		return FALSE

	preferences.alt_job_titles[job_title] = new_job_title

	return TRUE
// SKYRAT EDIT END

/datum/preference_middleware/jobs/get_constant_data()
	var/list/data = list()

	var/list/departments = list()
	var/list/jobs = list()

	for (var/datum/job/job as anything in SSjob.joinable_occupations)
		if (job.job_flags & JOB_LATEJOIN_ONLY)
			continue
		var/datum/job_department/department_type = job.department_for_prefs || job.departments_list?[1]
		if (isnull(department_type))
			stack_trace("[job] does not have a department set, yet is a joinable occupation!")
			continue

		if (isnull(job.description))
			stack_trace("[job] does not have a description set, yet is a joinable occupation!")
			continue

		var/department_name = initial(department_type.department_name)
		if (isnull(departments[department_name]))
			var/datum/job/department_head_type = initial(department_type.department_head)

			departments[department_name] = list(
				"head" = department_head_type && initial(department_head_type.title),
			)

		jobs[job.title] = list(
			"description" = job.description,
			"department" = department_name,
			"veteran" = job.veteran_only, // SKYRAT EDIT
			"alt_titles" = job.alt_titles, // SKYRAT EDIT
		)

	data["departments"] = departments
	data["jobs"] = jobs

	return data

/datum/preference_middleware/jobs/get_ui_data(mob/user)
	var/list/data = list()
	// SKYRAT EDIT
	if(isnull(preferences.alt_job_titles))
		preferences.alt_job_titles = list()
	// SKYRAT EDIT END
	data["job_preferences"] = preferences.job_preferences
	// SKYRAT EDIT
	data["job_alt_titles"] = preferences.alt_job_titles
	data["species_restricted_jobs"] = get_unavailable_jobs_for_species()
	// SKYRAT EDIT END

	return data

/datum/preference_middleware/jobs/get_ui_static_data(mob/user)
	var/list/data = list()

	// SKYRAT EDIT
	if(CONFIG_GET(flag/bypass_veteran_system) || SSplayer_ranks.is_veteran(user.client))
		data["is_veteran"] = TRUE
	// SKYRAT EDIT END

	var/list/required_job_playtime = get_required_job_playtime(user)
	if (!isnull(required_job_playtime))
		data += required_job_playtime

	var/list/job_bans = get_job_bans(user)
	if (job_bans.len)
		data["job_bans"] = job_bans

	return data.len > 0 ? data : null

/datum/preference_middleware/jobs/proc/get_required_job_playtime(mob/user)
	var/list/data = list()

	var/list/job_days_left = list()
	var/list/job_required_experience = list()

	for (var/datum/job/job as anything in SSjob.all_occupations)
		if (job.job_flags & JOB_LATEJOIN_ONLY)
			continue
		var/required_playtime_remaining = job.required_playtime_remaining(user.client)
		if (required_playtime_remaining)
			job_required_experience[job.title] = list(
				"experience_type" = job.get_exp_req_type(),
				"required_playtime" = required_playtime_remaining,
			)

			continue

		if (!job.player_old_enough(user.client))
			job_days_left[job.title] = job.available_in_days(user.client)

	if (job_days_left.len)
		data["job_days_left"] = job_days_left

	if (job_required_experience)
		data["job_required_experience"] = job_required_experience

	return data

/datum/preference_middleware/jobs/proc/get_job_bans(mob/user)
	var/list/data = list()

	for (var/datum/job/job as anything in SSjob.all_occupations)
		if (is_banned_from(user.client?.ckey, job.title))
			data += job.title

	return data
//SKYRAT EDIT ADDITION BEGIN - CHECKING FOR INCOMPATIBLE SPECIES
//This returns a list of jobs that are unavailable for the player's current species
/datum/preference_middleware/jobs/proc/get_unavailable_jobs_for_species()
	var/list/data = list()

	for (var/datum/job/job as anything in SSjob.all_occupations)
		if (job.has_banned_species(preferences))
			data += job.title

	return data

//SKYRAT EDIT ADDITION END

