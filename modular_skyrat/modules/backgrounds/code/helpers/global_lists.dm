/// Sets up caches for background datum instances.
/proc/make_background_references()
	for(var/path in subtypesof(/datum/background_info/employment))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.employment[path] = culture
	for(var/path in subtypesof(/datum/background_info/origin))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.origins[path] = culture
	for(var/path in subtypesof(/datum/background_info/social_background))
		var/datum/background_info/culture = path
		if(!initial(culture.name))
			continue
		culture = new path()
		GLOB.social_backgrounds[path] = culture
	for(var/datum/cultural_feature/cultural_feature as anything in subtypesof(/datum/cultural_feature))
		cultural_feature = new cultural_feature()
		GLOB.culture_features += list("[cultural_feature.name]" = list(
			"name" = cultural_feature.name,
			"description" = cultural_feature.description,
			"icon" = sanitize_css_class_name(cultural_feature.name),
		))
