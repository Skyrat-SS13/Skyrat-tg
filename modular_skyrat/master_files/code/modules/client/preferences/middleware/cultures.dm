/datum/asset/spritesheet/cultures
	name = "cultures"
	early = TRUE
	cross_round_cachable = TRUE

/datum/asset/spritesheet/cultures/create_spritesheets()
	for(var/datum/cultural_feature/cultural_feature as anything in subtypesof(/datum/cultural_feature))
		var/icon/language_icon = icon(initial(cultural_feature.icon_path), icon_state = initial(cultural_feature.icon_state))
		Insert(sanitize_css_class_name(initial(cultural_feature.name)), language_icon)

/datum/preference_middleware/cultures

/datum/preference_middleware/get_ui_assets()
	return list(
		get_asset_datum(/datum/asset/spritesheet/cultures)
	)


/datum/preference_middleware/cultures/get_ui_data(mob/user)
	var/list/cultures = list()
	var/list/locations = list()
	var/list/factions = list()
	var/list/features = list()

	for(var/datum/cultural_feature/cultural_feature as anything in subtypesof(/datum/cultural_feature))
		cultural_feature = new cultural_feature()
		features += list("[cultural_feature.name]" = list(
			"name" = cultural_feature.name,
			"description" = cultural_feature.description,
			"icon" = sanitize_css_class_name(cultural_feature.name),
			"css_class" = cultural_feature.css_class,
		))

	for(var/datum/cultural_info/cultural_info as anything in subtypesof(/datum/cultural_info/culture))
		cultural_info = new cultural_info()
		var/datum/language/required_lang = cultural_info.required_lang
		var/required_lang_name = initial(required_lang.name)
		world.log << required_lang
		var/list/additional_langs = list()
		for(var/datum/language/language as anything in cultural_info.additional_langs)
			language = GLOB.language_datum_instances[language]
			additional_langs += list(initial(language.name))
		var/list/feature_names = list()
		for(var/datum/cultural_feature/feature as anything in cultural_info.features)
			feature_names += list(initial(feature.name))
		cultures += list(list(
			"name" = cultural_info.name,
			"description" = cultural_info.description,
			"economic_power" = cultural_info.economic_power,
			"required_lang" = required_lang_name,
			"additional_langs" = additional_langs,
			"features" = feature_names,
			"css_class" = sanitize_css_class_name(cultural_info.name),
		))

	for(var/datum/cultural_info/cultural_info as anything in subtypesof(/datum/cultural_info/faction))
		cultural_info = new cultural_info()
		var/datum/language/required_lang = cultural_info.required_lang
		var/required_lang_name = initial(required_lang.name)
		var/list/additional_langs = list()
		for(var/datum/language/language as anything in cultural_info.additional_langs)
			language = GLOB.language_datum_instances[language]
			additional_langs += list(initial(language.name))
		var/list/feature_names = list()
		for(var/datum/cultural_feature/feature as anything in cultural_info.features)
			feature_names += list(initial(feature.name))
		factions += list(list(
			"name" = cultural_info.name,
			"description" = cultural_info.description,
			"economic_power" = cultural_info.economic_power,
			"required_lang" = required_lang_name,
			"additional_langs" = additional_langs,
			"features" = feature_names,
		))

	for(var/datum/cultural_info/location/cultural_info as anything in subtypesof(/datum/cultural_info/location))
		cultural_info = new cultural_info()
		var/datum/language/required_lang = cultural_info.required_lang
		var/required_lang_name = initial(required_lang.name)
		var/list/additional_langs = list()
		for(var/datum/language/language as anything in cultural_info.additional_langs)
			language = GLOB.language_datum_instances[language]
			additional_langs += list(initial(language.name))
		var/list/feature_names = list()
		for(var/datum/cultural_feature/feature as anything in cultural_info.features)
			feature_names += list(initial(feature.name))
		locations += list(list(
			"name" = cultural_info.name,
			"description" = cultural_info.description,
			"economic_power" = cultural_info.economic_power,
			"required_lang" = required_lang_name,
			"additional_langs" = additional_langs,
			"features" = feature_names,
			"ruler" = cultural_info.ruling_body,
			"distance" = cultural_info.distance,
			"capital" = cultural_info.capital,
		))

	return list(
		"cultures" = cultures,
		"locations" = locations,
		"factions" = factions,
		"features" = features,
	)
