#define MAX_LANGUAGES_NORMAL 3
#define MAX_LANGUAGES_LINGUIST 4

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
	/// A associative list of language names to their typepath
	var/static/list/name_to_language = list()
	action_delegations = list(
		"give_language" = .proc/give_language,
		"remove_language" = .proc/remove_language,
	)

/datum/preference_middleware/languages/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences) // SKYRAT EDIT CHANGE
	var/datum/language_holder/language_holder = target.get_language_holder()
	language_holder.remove_all_languages()
	language_holder.omnitongue = TRUE // a crappy hack but it works
	for(var/lang_path in preferences.languages)
		language_holder.grant_language(lang_path)

/datum/preference_middleware/languages/get_ui_assets()
	return list(
		get_asset_datum(/datum/asset/spritesheet/languages),
	)

/datum/preference_middleware/languages/post_set_preference(mob/user, preference, value)
	if(preference != "species")
		return
	preferences.languages = list()
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type()
	var/datum/language_holder/lang_holder = new species.species_language_holder()
	for(var/language in preferences.get_adjusted_language_holder())
		preferences.languages[language] = LANGUAGE_SPOKEN
	qdel(lang_holder)
	qdel(species)

	for(var/language in lang_holder.spoken_languages)
		preferences.languages[language] = LANGUAGE_SPOKEN

	qdel(lang_holder)
	qdel(species)

	return ..()

/datum/preference_middleware/languages/get_ui_data(mob/user)
	if(length(name_to_language) != length(GLOB.all_languages))
		initialize_name_to_language()

	var/list/data = list()

	var/max_languages = preferences.all_quirks.Find(QUIRK_LINGUIST) ? MAX_LANGUAGES_LINGUIST : MAX_LANGUAGES_NORMAL
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type()
	var/datum/language_holder/lang_holder = preferences.get_adjusted_language_holder()
	if(!preferences.languages || !preferences.languages.len || (preferences.languages && preferences.languages.len > max_languages)) // Too many languages, or no languages.
		preferences.languages = list()
		for(var/language in lang_holder.spoken_languages)
			preferences.languages[language] = LANGUAGE_SPOKEN

	var/list/selected_languages = list()
	var/list/unselected_languages = list()

	for (var/language_name in GLOB.all_languages)
		var/datum/language/language = GLOB.language_datum_instances[language_name]

		if(language.secret)
			continue

		if(species.always_customizable && !(language.type in lang_holder.spoken_languages)) // For the ghostrole species. We don't want ashwalkers speaking beachtongue now.
			continue
		if(preferences.languages[language.type])
			selected_languages += list(list(
				"description" = language.desc,
				"name" = language.name,
				"icon" = sanitize_css_class_name(language.name)
			))
		else
			unselected_languages += list(list(
				"description" = language.desc,
				"name" = language.name,
				"icon" = sanitize_css_class_name(language.name)
			))

	qdel(lang_holder)
	qdel(species)

	data["total_language_points"] = max_languages
	data["selected_languages"] = selected_languages
	data["unselected_languages"] = unselected_languages
	return data

/// (Re-)Initializes the `name_to_language` associative list, to ensure that it's properly populated.
/datum/preference_middleware/languages/proc/initialize_name_to_language()
	name_to_language = list()
	for(var/language_name in GLOB.all_languages)
		var/datum/language/language = GLOB.language_datum_instances[language_name]
		name_to_language[language.name] = language_name

/**
 * Proc that gives a language to a character, granted that they don't already have too many
 * of them, based on their maximum amount of languages.
 *
 * Arguments:
 * * params - List of parameters, given to us by the `act()` method from TGUI. Needs to
 * contain a value under `"language_name"`.
 *
 * Returns TRUE all the time, to ensure that the UI is updated.
 */
/datum/preference_middleware/languages/proc/give_language(list/params)
	var/language_name = params["language_name"]
	var/max_languages = preferences.all_quirks.Find(QUIRK_LINGUIST) ? MAX_LANGUAGES_LINGUIST : MAX_LANGUAGES_NORMAL

	if(preferences.languages && preferences.languages.len == max_languages) // too many languages
		return TRUE

	preferences.languages[name_to_language[language_name]] = LANGUAGE_SPOKEN
	return TRUE

/**
 * Proc that removes a language from a character.
 *
 * Arguments:
 * * params - List of parameters, given to us by the `act()` method from TGUI. Needs to
 * contain a value under `"language_name"`.
 *
 * Returns TRUE all the time, to ensure that the UI is updated.
 */
/datum/preference_middleware/languages/proc/remove_language(list/params)
	var/language_name = params["language_name"]
	preferences.languages -= name_to_language[language_name]
	return TRUE
