/datum/language
	/// Setting this to TRUE prevents the language from being sanitized in sanitize_languages if it is considered 'secret'
	/// See modular_skyrat/modules/customization/modules/client/preferences.dm
	/// Currently only Ashtongue needs this because it is the only secret language that can appear in prefs.
	var/do_not_sanitize = FALSE

/datum/language/aphasia
	secret = TRUE

/datum/language/codespeak
	secret = TRUE

/datum/language/drone
	secret = TRUE

/datum/language/narsie
	secret = TRUE

/datum/language/piratespeak
	secret = TRUE

/datum/language/xenocommon
	secret = TRUE
	
/datum/language/ashtongue
	do_not_sanitize = TRUE
