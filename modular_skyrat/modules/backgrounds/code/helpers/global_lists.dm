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
	for(var/datum/background_feature/background_feature as anything in subtypesof(/datum/background_feature))
		background_feature = new background_feature()
		GLOB.background_features += list("[background_feature.name]" = list(
			"name" = background_feature.name,
			"description" = background_feature.description,
			"icon" = sanitize_css_class_name(background_feature.name),
		))
	for(var/obj/item/passport/passport as anything in typesof(/obj/item/passport))
		if(ispath(passport, /obj/item/passport/chameleon))
			continue
		GLOB.valid_passport_disguises.Add(list("[initial(passport.passport_name)]" = passport))
