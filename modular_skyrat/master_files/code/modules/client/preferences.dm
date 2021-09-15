/datum/preferences
	/// Toggles for our specific functions, such as AOOC and LOOC
	var/skyrat_toggles
	/// Loadout prefs. Assoc list of [typepaths] to [associated list of item info].
	var/list/loadout_list
	/// Associative list, keyed by language typepath, pointing to LANGUAGE_UNDERSTOOD, or LANGUAGE_SPOKEN, for whether we understand or speak the language
	var/list/languages = list()

/datum/preferences/proc/get_linguistic_points()
	var/points = LINGUISTIC_POINTS_DEFAULT
	for(var/langpath in languages)
		points -= languages[langpath]
	return points

/datum/preferences/proc/get_required_languages()
	var/list/lang_list = list()
	var/datum/cultural_info/cult
	if(cult.required_lang)
		lang_list[cult.required_lang] = TRUE
	return lang_list

/datum/preferences/proc/get_optional_languages()
	var/list/lang_list = list()
	var/species_type = read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type()
	for(var/lang in species.learnable_languages)
		lang_list[lang] = TRUE
	var/datum/cultural_info/cult
	if(cult.additional_langs)
		for(var/langtype in cult.additional_langs)
			lang_list[langtype] = TRUE
	return lang_list

/datum/preferences/proc/get_available_languages()
	var/list/lang_list = get_required_languages()
	for(var/lang_key in get_optional_languages())
		lang_list[lang_key] = TRUE
	return lang_list

/datum/preferences/proc/validate_languages()
	var/list/opt_langs = get_optional_languages()
	var/list/req_langs = get_required_languages()
	for(var/langkey in languages)
		if(!opt_langs[langkey] && !req_langs[langkey])
			languages -= langkey
	for(var/req_lang in req_langs)
		if(!languages[req_lang])
			languages[req_lang] = LANGUAGE_SPOKEN
	var/left_points = get_linguistic_points()
	//If we're below 0 points somehow, remove all optional languages
	if(left_points < 0)
		for(var/lang in languages)
			if(!req_langs[lang])
				languages -= lang

/datum/preferences/proc/can_buy_language(language_path, level)
	var/points = get_linguistic_points()
	if(languages[language_path])
		points += languages[language_path]
	if(points < level)
		return FALSE
	return TRUE

//Whenever we switch a species, we'll try to get common if we can to not confuse anyone
/datum/preferences/proc/try_get_common_language()
	var/list/langs = get_available_languages()
	if(langs[/datum/language/common])
		languages[/datum/language/common] = LANGUAGE_SPOKEN
