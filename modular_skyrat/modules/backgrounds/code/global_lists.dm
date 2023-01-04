/// Sets up caches for background datum instances.
/proc/make_background_references()
	for(var/path in subtypesof(/datum/background_info/employment))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.employments[path] = culture
		GLOB.employment_name_to_instance[culture.name] = culture
		GLOB.employment_names += culture.name
		if(culture.hidden_from_characters)
			continue
		// GLOB.passport_editor_tabs["Employment"] += list(list("name" = culture.name, "path" = "[path]")) // To be uncommented in a later PR.

	for(var/path in subtypesof(/datum/background_info/origin))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.origins[path] = culture
		GLOB.origin_name_to_instance[culture.name] = culture
		GLOB.origin_names += culture.name

	for(var/path in subtypesof(/datum/background_info/social_background))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.social_backgrounds[path] = culture
		GLOB.social_background_name_to_instance[culture.name] = culture
		GLOB.social_background_names += culture.name
		if(culture.hidden_from_characters)
			continue
		// GLOB.passport_editor_tabs["Faction"] += list(list("name" = culture.name, "path" = "[path]")) // To be uncommented in a later PR.

	for(var/datum/background_feature/background_feature as anything in subtypesof(/datum/background_feature))
		background_feature = new background_feature()
		GLOB.background_features += list("[background_feature.name]" = list(
			"name" = background_feature.name,
			"description" = background_feature.description,
			"icon" = sanitize_css_class_name(background_feature.name),
		))

	for(var/datum/job/job in subtypesof(/datum/job))
		// This should be a reliable way to check if a job is command.
		if(initial(job.departments_bitflags) & DEPARTMENT_BITFLAG_COMMAND)
			GLOB.sensitive_jobs += job
