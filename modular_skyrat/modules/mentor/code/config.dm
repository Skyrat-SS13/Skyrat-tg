/datum/configuration
	var/mentors_mobname_only = FALSE		// Only display mob name to mentors in mentorhelps
	var/mentor_legacy_system = FALSE		// Whether to use the legacy mentor system (flat file) instead of SQL

/datum/config_entry/flag/mentors_mobname_only

/datum/config_entry/flag/mentor_legacy_system	//Defines whether the server uses the legacy mentor system with mentors.txt or the SQL system
	protection = CONFIG_ENTRY_LOCKED
