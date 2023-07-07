SUBSYSTEM_DEF(language)
	name = "Language"
	init_order = INIT_ORDER_LANGUAGE
	flags = SS_NO_FIRE

/datum/controller/subsystem/language/Initialize()
<<<<<<< HEAD
	// SKYRAT EDIT START
	if(!GLOB.all_languages.len)
		for(var/L in subtypesof(/datum/language))
			var/datum/language/language = L
			if(!initial(language.key))
				continue

			GLOB.all_languages += language

			var/datum/language/instance = new language
=======
	for(var/datum/language/language as anything in subtypesof(/datum/language))
		if(!initial(language.key))
			continue

		GLOB.all_languages += language
		GLOB.language_types_by_name[initial(language.name)] = language

		var/datum/language/instance = new language
		GLOB.language_datum_instances[language] = instance
>>>>>>> a2c8cce5359 (Bilingual can now choose their language (#76609))

			GLOB.language_datum_instances[language] = instance
	// SKYRAT EDIT END
	return SS_INIT_SUCCESS
