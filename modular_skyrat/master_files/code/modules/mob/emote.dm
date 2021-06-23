GLOBAL_LIST_INIT(emote_blacklist, world.file2list('modular_skyrat/modules/nullf­a­g_masspr/emote_blacklist.txt'))

/datum/emote/run_emote(mob/user, params, type_override, intentional)
	if(intentional && (key in GLOB.emote_blacklist)) //you could probably bypass this with like force-say nanites or similar
		return FALSE
	return ..()
