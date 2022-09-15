SUBSYSTEM_DEF(language)
	name = "Language"
	init_order = INIT_ORDER_LANGUAGE
	flags = SS_NO_FIRE

<<<<<<< HEAD
/datum/controller/subsystem/language/Initialize(timeofday)
	// SKYRAT EDIT START
	if(!GLOB.all_languages.len)
		for(var/L in subtypesof(/datum/language))
			var/datum/language/language = L
			if(!initial(language.key))
				continue
=======
/datum/controller/subsystem/language/Initialize()
	for(var/L in subtypesof(/datum/language))
		var/datum/language/language = L
		if(!initial(language.key))
			continue
>>>>>>> 4733643f395 (Clean up subsystem Initialize(), require an explicit result returned, give a formal way to fail (for SSlua) (#69775))

			GLOB.all_languages += language

			var/datum/language/instance = new language

<<<<<<< HEAD
			GLOB.language_datum_instances[language] = instance
	// SKYRAT EDIT END
	return ..()
=======
	return SS_INIT_SUCCESS
>>>>>>> 4733643f395 (Clean up subsystem Initialize(), require an explicit result returned, give a formal way to fail (for SSlua) (#69775))
