/mob/Login()
	. = ..()

	if(!.)
		return FALSE

	if(SSplayer_ranks.initialized)
		SSplayer_ranks.update_prefs_unlock_content(client?.prefs)

	return TRUE
