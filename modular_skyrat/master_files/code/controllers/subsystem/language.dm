/datum/controller/subsystem/language/Initialize()
	if(GLOB.all_languages.len)
		return SS_INIT_SUCCESS
	return ..()
