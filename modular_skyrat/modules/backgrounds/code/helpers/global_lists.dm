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
	for(var/datum/background_feature/background_feature as anything in subtypesof(/datum/background_feature))
		background_feature = new background_feature()
		GLOB.culture_features += list("[background_feature.name]" = list(
			"name" = background_feature.name,
			"description" = background_feature.description,
			"icon" = sanitize_css_class_name(background_feature.name),
		))
