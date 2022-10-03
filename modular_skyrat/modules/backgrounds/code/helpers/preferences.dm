/// Clean and reset backgrounds where appropriate. Typically happens on background codedels and renames.
/// Returns TRUE on any changes made.
/datum/preferences/proc/sanitize_backgrounds()
	var/datum/preference_middleware/backgrounds/background_middleware
	for(var/datum/preference_middleware/backgrounds/middleware in middleware) // Cursed as fuck, but I don't care.
		background_middleware = middleware

	if(!background_middleware)
		message_admins("\[PREFS_SANITIZE_BACKGROUNDS] OH NO, I CAN'T FIND THE BACKGROUNDS MIDDLEWARE!! ALERT CODERS!")
		return

	// I'm not remaking code I already made.
	if(!background_middleware.verify_origin(list("background" = "[origin]")))
		origin = null
		// Better be safe than sorry when people get fucked background prefs that break systems.
		social_background = null
		employment = null
		return TRUE
	if(background_middleware.verify_social_background(list("background" = "[social_background]")))
		social_background = null
		employment = null
		return TRUE
	if(background_middleware.verify_employment(list("background" = "[employment]")))
		employment = null
		return TRUE
