/datum/background_info
	/// Name of the background entry, be it origin, social background, or employment
	var/name
	/// A brief summary of what the background entry is about. 1000 characters at **absolute maximum**.
	var/description
	/// Economic power, this impacts the initial paychecks by a bit. Averaged between the three background entries when applied to gameplay.
	var/economic_power = 1
	/// It'll force people to know this language if they've picked this background entry. They will get these cheaper.
	var/datum/language/required_lang
	/// This will allow people to pick certain languages cheaper.
	var/list/additional_langs = list()
	/// The gameplay features of this background.
	var/list/features = list()
	/// Groups the background belongs to. Restricts what kind of other background entries can be picked.
	var/groups = BACKGROUNDS_ALL
	/// If the background should be veteran only or not.
	var/veteran = FALSE
	/// The roles allowed to be played as by this background. Uses job datums and ghost_role spawners. If null, it doesn't impose restrictions.
	var/list/allowed_roles

/datum/background_info/proc/is_job_valid(datum/job/job)
	if(!allowed_roles)
		return TRUE

	if(job.type in allowed_roles)
		return TRUE

	return FALSE

/datum/background_info/proc/is_ghost_role_valid(obj/effect/mob_spawn/ghost_role/human/ghost_role)
	if(!allowed_roles)
		return TRUE

	if(ghost_role.type in allowed_roles)
		return TRUE

	return FALSE

/datum/background_info/proc/get_non_command_jobs()
	RETURN_TYPE(/list)
	var/list/roles = subtypesof(/datum/job)
	for(var/datum/job/job in roles)
		// This should be a reliable way to check if a job is command.
		if(job.paycheck >= PAYCHECK_COMMAND)
			roles -= job
	return roles
