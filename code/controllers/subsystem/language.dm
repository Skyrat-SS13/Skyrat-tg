SUBSYSTEM_DEF(language)
	name = "Language"
	init_order = INIT_ORDER_LANGUAGE
	flags = SS_NO_FIRE

/datum/controller/subsystem/language/Initialize(timeofday)
	// SKYRAT EDIT START
	if(!GLOB.all_languages.len)
		for(var/L in subtypesof(/datum/language))
			var/datum/language/language = L
			if(!initial(language.key))
				continue

			GLOB.all_languages += language

			var/datum/language/instance = new language

			GLOB.language_datum_instances[language] = instance
	// SKYRAT EDIT END
	return ..()
