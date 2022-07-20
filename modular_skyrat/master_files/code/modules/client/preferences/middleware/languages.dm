/datum/asset/spritesheet/languages
	name = "languages"
	early = TRUE
	cross_round_cachable = TRUE

/datum/asset/spritesheet/languages/create_spritesheets()
	var/list/to_insert = list()

	if(!GLOB.all_languages.len)
		for(var/iterated_language in subtypesof(/datum/language))
			var/datum/language/language = iterated_language
			if(!initial(language.key))
				continue

			GLOB.all_languages += language

			var/datum/language/instance = new language

			GLOB.language_datum_instances[language] = instance

	for (var/language_name in GLOB.all_languages)
		var/datum/language/language = GLOB.language_datum_instances[language_name]
		var/icon/language_icon = icon(language.icon, icon_state = language.icon_state)
		to_insert[sanitize_css_class_name(language.name)] = language_icon

	for (var/spritesheet_key in to_insert)
		Insert(spritesheet_key, to_insert[spritesheet_key])

/// Middleware to handle languages
/datum/preference_middleware/languages
	var/tainted = FALSE

	action_delegations = list(
		"give_language" = .proc/give_language,
		"remove_language" = .proc/remove_language,
	)
	var/list/name_to_language

/datum/preference_middleware/languages/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences) // SKYRAT EDIT CHANGE
	target.language_holder.understood_languages.Cut()
	target.language_holder.spoken_languages.Cut()
	target.language_holder.omnitongue = TRUE // a crappy hack but it works
	for(var/lang_path in preferences.core_languages)
		target.grant_language(lang_path)
	for(var/lang_path in preferences.race_languages)
		target.grant_language(lang_path)

/datum/preference_middleware/languages/get_ui_assets()
	return list(
		get_asset_datum(/datum/asset/spritesheet/languages),
	)

/datum/preference_middleware/languages/post_set_preference(mob/user, preference, value)
	if(preference == "species")
		var/species_type = preferences.read_preference(/datum/preference/choiced/species)
		preferences.core_languages = list()
		preferences.race_languages = list()
		var/datum/species/species = new species_type()
		for(var/datum/language/language as anything in species.learnable_languages)
			if(language.category == CORE_LANGUAGE)
				preferences.core_languages[language] = LANGUAGE_SPOKEN
			else if (language.category == RACE_LANGUAGE)
				preferences.race_languages[language] = LANGUAGE_SPOKEN
		qdel(species)

	. = ..()

/datum/preference_middleware/languages/get_ui_data(mob/user)
	if(!name_to_language)
		name_to_language = list()
		for(var/language_name in GLOB.all_languages)
			var/datum/language/language = GLOB.language_datum_instances[language_name]
			name_to_language[language.name] = language_name

	var/list/data = list()

	var/max_core_languages = preferences.all_quirks.Find(QUIRK_LINGUIST) ? 2 : 1
	var/max_race_languages = preferences.all_quirks.Find(QUIRK_LINGUIST) ? 2 : 1
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type()
	sanity_check_languages(preferences.core_languages, max_core_languages, list(pick(/datum/language/sol, /datum/language/yangyu, /datum/language/panslavic)), CORE_LANGUAGE)
	sanity_check_languages(preferences.race_languages, max_race_languages, species.learnable_languages, RACE_LANGUAGE)
	var/list/selected_core_languages = list()
	var/list/selected_race_languages = list()
	var/list/unselected_core_languages = list()
	var/list/unselected_race_languages = list()
	for (var/language_name in GLOB.all_languages)
		var/datum/language/language = GLOB.language_datum_instances[language_name]
		if(language.secret)
			continue
		if(species.always_customizable && !(language.type in species.learnable_languages)) // For the ghostrole species. We don't want ashwalkers speaking beachtongue now.
			continue
		if(language.category == CORE_LANGUAGE)
			if(preferences.core_languages[language.type])
				selected_core_languages += generate_language_entry(language)
			else
				unselected_core_languages += generate_language_entry(language)
		if(language.category == RACE_LANGUAGE)
			if(preferences.race_languages[language.type])
				selected_race_languages += generate_language_entry(language)
			else
				unselected_race_languages += generate_language_entry(language)

	qdel(species)

	data["total_core_language_points"] = max_core_languages
	data["total_race_language_points"] = max_race_languages
	data["selected_core_languages"] = selected_core_languages
	data["selected_race_languages"] = selected_race_languages
	data["unselected_core_languages"] = unselected_core_languages
	data["unselected_race_languages"] = unselected_race_languages
	return data

/datum/preference_middleware/languages/proc/sanity_check_languages(list/languages, max_languages, list/default_languages, category)
	if(!languages || !languages.len || (languages && languages.len > max_languages)) // Too many languages, or no languages.
		languages.Cut()
		for(var/datum/language/language as anything in default_languages)
			language = new language()
			if(language.category == category)
				languages[language.type] = LANGUAGE_SPOKEN

/datum/preference_middleware/languages/proc/generate_language_entry(datum/language/language)
	return list(list(
					"description" = language.desc,
					"name" = language.name,
					"icon" = sanitize_css_class_name(language.name),
					"category" = language.category
				))

/datum/preference_middleware/languages/proc/give_language(list/params, mob/user)
	var/language_name = params["language_name"]
	var/max_core_languages = preferences.all_quirks.Find(QUIRK_LINGUIST) ? 2 : 1
	var/max_race_languages = preferences.all_quirks.Find(QUIRK_LINGUIST) ? 2 : 1
	var/language_category = params["language_category"]

	if(language_category == CORE_LANGUAGE && preferences.core_languages && preferences.core_languages.len == max_core_languages) // too many core languages
		return TRUE
	if(language_category == RACE_LANGUAGE && preferences.race_languages && preferences.race_languages.len == max_race_languages) // too many race languages
		return TRUE
	if(language_category == OTHER_LANGUAGE)
		return TRUE
	if(language_category == CORE_LANGUAGE)
		preferences.core_languages[name_to_language[language_name]] = LANGUAGE_SPOKEN
	if(language_category == RACE_LANGUAGE)
		preferences.race_languages[name_to_language[language_name]] = LANGUAGE_SPOKEN
	return TRUE

/datum/preference_middleware/languages/proc/remove_language(list/params, mob/user)
	var/language_name = params["language_name"]
	var/category = params["language_category"]
	if(category == CORE_LANGUAGE)
		preferences.core_languages -= name_to_language[language_name]
	if(category == RACE_LANGUAGE)
		preferences.race_languages -= name_to_language[language_name]
	return TRUE

/datum/preference_middleware/languages/proc/get_selected_languages()
	var/list/selected_languages = list()

	for (var/language in preferences.core_languages)
		var/datum/language/language_datum = GLOB.language_datum_instances[language]
		selected_languages += sanitize_css_class_name(language_datum.name)

	for (var/language in preferences.race_languages)
		var/datum/language/language_datum = GLOB.language_datum_instances[language]
		selected_languages += sanitize_css_class_name(language_datum.name)

	return selected_languages
