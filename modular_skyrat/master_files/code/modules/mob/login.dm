/mob/Login()
	. = ..()

	if(!.)
		return FALSE

	if(SSplayer_ranks.initialized)
		SSplayer_ranks.update_prefs_donator_status(client?.prefs)

	return TRUE
