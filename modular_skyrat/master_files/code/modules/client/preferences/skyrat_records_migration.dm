/datum/preferences/proc/migrate_record(savefile/S)
	READ_FILE(S["general_record"], general_record) //NOTE TO MAINTAINERS: i am NOT SURE if using the preferences.dm vars as keys here will cause issues. i doubt it, but i cant be certain
	if(general_record)
		write_preference(GLOB.preference_entries[/datum/preference/text/general_records], general_record)

	READ_FILE(S["medical_record"], medical_record)
	if(medical_record)
		write_preference(GLOB.preference_entries[/datum/preference/text/medical_records], medical_record)

	READ_FILE(S["security_record"], security_record)
	if(security_record)
		write_preference(GLOB.preference_entries[/datum/preference/text/security_records], security_record)

	READ_FILE(S["exploitable_info"], exploitable_info)
	if(exploitable_info)
		write_preference(GLOB.preference_entries[/datum/preference/text/exploitable_records], exploitable_info)

	READ_FILE(S["background_info"], background_info)
	if(background_info)
		write_preference(GLOB.preference_entries[/datum/preference/text/background_records], background_info)

	to_chat(parent, examine_block(span_greentext("Records migration successful! You may safely interact with your records.")))
	skyrat_records_migration = TRUE
	WRITE_FILE(S["skyrat_records_migration"], skyrat_records_migration)

