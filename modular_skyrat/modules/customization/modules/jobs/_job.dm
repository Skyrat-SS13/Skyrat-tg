/datum/job
	///With this set to TRUE, the loadout will be applied before a job clothing will be
	var/no_dresscode
	//Whether the job can use the loadout system
	var/loadout = TRUE
	//List of banned quirks in their names(dont blame me, that's how they're stored), players can't join as the job if they have the quirk. Associative for the purposes of performance
	var/list/banned_quirks
	///A list of slots that can't have loadout items assigned to them if no_dresscode is applied, used for important items such as ID, PDA, backpack and headset
	var/list/blacklist_dresscode_slots
	//Whitelist of allowed species for this job. If not specified then all roundstart races can be used. Associative with TRUE
	var/list/species_whitelist
	//Blacklist of species for this job.
	var/list/species_blacklist
	/// Which languages does the job require, associative to LANGUAGE_UNDERSTOOD or LANGUAGE_SPOKEN
	var/list/required_languages = list(/datum/language/common = LANGUAGE_SPOKEN)
	//Alt titles
	var/list/alt_titles = list()

/datum/job/proc/has_banned_quirk(datum/preferences/pref)
	if(!pref) //No preferences? We'll let you pass, this time (just a precautionary check,you dont wanna mess up gamemode setting logic)
		return FALSE
	if(banned_quirks)
		for(var/Q in pref.all_quirks)
			if(banned_quirks[Q])
				return TRUE
	return FALSE

/datum/job/proc/has_banned_species(datum/preferences/pref)
	var/my_id = pref.pref_species.id
	if(species_whitelist && !species_whitelist[my_id])
		return TRUE
	else if(!GLOB.roundstart_races[my_id])
		return TRUE
	if(species_blacklist && species_blacklist[my_id])
		return TRUE
	return FALSE

// Misc
/datum/job/assistant
	no_dresscode = TRUE
	blacklist_dresscode_slots = list(ITEM_SLOT_EARS,ITEM_SLOT_BELT,ITEM_SLOT_ID,ITEM_SLOT_BACK) //headset, PDA, ID, backpack are important items
	required_languages = null
	alt_titles = list("Civilian", "Tourist", "Businessman", "Trader", "Entertainer")

/datum/job/prisoner
	required_languages = null

//Security
/datum/job/security_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

/datum/job/detective
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	alt_titles = list("Forensics Technician", "Private Investigator")

/datum/job/warden
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

/datum/job/security_sergeant
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

/datum/job/security_medic
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

/datum/job/junior_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

/datum/job/blueshield
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)

// Command

/datum/job/captain
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	alt_titles = list("Station Commander")

/datum/job/head_of_security
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, HEAD_RESTRICTED_QUIRKS)
	alt_titles = list("Security Commander")

/datum/job/chief_medical_officer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

/datum/job/chief_engineer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Paraplegic" = TRUE)
	alt_titles = list("Engineering Foreman")

/datum/job/research_director
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

/datum/job/head_of_personnel
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

/datum/job/quartermaster
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)

//Engineering
/datum/job/engineer
	alt_titles = list("Maintenance Technician", "Engine Technician", "Electrician")

/datum/job/atmos
	alt_titles = list("Firefighter", "Life Support Specialist")

//Medical
/datum/job/doctor
	alt_titles = list("Nurse", "Surgeon")

/datum/job/paramedic
	alt_titles = list("Emergency Medical Technician", "Medical Responder")

/datum/job/chemist
	alt_titles = list("Pharmacist", "Pharmacologist")

//Silicon
/datum/job/ai
	loadout = FALSE

/datum/job/cyborg
	loadout = FALSE

//Science
/datum/job/scientist
	alt_titles = list("Circuitry Designer", "Xenobiologist", "Cytologist", "Nanomachine Programmer", "Plasma Researcher")

/datum/job/roboticist
	alt_titles = list("Biomechanical Engineer", "Mechatronic Engineer")

//Service
/datum/job/cook
	required_languages = null
	alt_titles = list("Chef", "Culinary Artist", "Butcher")

/datum/job/botanist
	required_languages = null
	alt_titles = list("Gardener", "Herbalist", "Botanical Researcher")

/datum/job/curator
	required_languages = null
	alt_titles = list("Journalist", "Librarian", "Archivist")

/datum/job/janitor
	required_languages = null
	alt_titles = list("Custodian", "Sanitation Technician")

/datum/job/lawyer
	alt_titles = list("Human Resources Agent", "Internal Affairs Agent")

/datum/job/proc/has_required_languages(datum/preferences/pref)
	if(!required_languages)
		return TRUE
	for(var/lang in required_languages)
		//Doesnt have language, or the required "level" is too low (understood, while needing spoken)
		if(!pref.languages[lang] || pref.languages[lang] < required_languages[lang])
			return FALSE
	return TRUE
