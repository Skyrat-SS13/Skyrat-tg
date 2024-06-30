/datum/job
	///With this set to TRUE, the loadout will be applied before a job clothing will be
	var/no_dresscode
	//Whether the job can use the loadout system
	var/loadout = TRUE
	//List of banned quirks in their names(dont blame me, that's how they're stored), players can't join as the job if they have the quirk. Associative for the purposes of performance
	var/list/banned_quirks
	/// List of banned augments
	var/list/banned_augments
	///A list of slots that can't have loadout items assigned to them if no_dresscode is applied, used for important items such as ID, PDA, backpack and headset
	var/list/blacklist_dresscode_slots
	//Whitelist of allowed species for this job. If not specified then all roundstart races can be used. Associative with TRUE
	var/list/species_whitelist
	//Blacklist of species for this job.
	var/list/species_blacklist
	/// Which languages does the job require, associative to LANGUAGE_UNDERSTOOD or LANGUAGE_SPOKEN
	var/list/required_languages = list(/datum/language/common = LANGUAGE_SPOKEN)

	///Is this job veteran only? If so, then this job requires the player to be in the veteran_players.txt
	var/veteran_only = FALSE


/datum/job/proc/has_banned_quirk(datum/preferences/pref)
	if(!pref) //No preferences? We'll let you pass, this time (just a precautionary check,you dont wanna mess up gamemode setting logic)
		return FALSE
	if(banned_quirks)
		for(var/Q in pref.all_quirks)
			if(banned_quirks[Q])
				var/exception = RESTRICTED_QUIRKS_EXCEPTIONS[Q]
				if (!exception || !pref.all_quirks.Find(exception))
					return TRUE
	return FALSE

/datum/job/proc/has_banned_species(datum/preferences/pref)
	var/species_type = pref.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	var/my_id = species.id
	if(species_whitelist && !species_whitelist[my_id])
		return TRUE
	else if(!(my_id in get_selectable_species()))
		return TRUE
	if(species_blacklist && species_blacklist[my_id])
		return TRUE
	return FALSE

/datum/job/proc/has_banned_augment(datum/preferences/pref)
	if(!pref)
		return FALSE

	if(!banned_augments)
		return FALSE

	var/list/player_augments = pref.augments
	for(var/key in player_augments)
		if(player_augments[key] in banned_augments)
			return TRUE

	return FALSE

// Misc
/datum/job/assistant
	no_dresscode = TRUE
	blacklist_dresscode_slots = list(ITEM_SLOT_EARS,ITEM_SLOT_BELT,ITEM_SLOT_ID,ITEM_SLOT_BACK) //headset, PDA, ID, backpack are important items
	required_languages = null

/datum/job/prisoner
	required_languages = null

//Security
/datum/job/security_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)

/datum/job/detective
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)

/datum/job/warden
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)

/datum/job/blueshield
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)

/datum/job/corrections_officer
	banned_quirks = list(SEC_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)

// Command
/datum/job/captain
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/nanotrasen_consultant
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/head_of_security
	banned_quirks = list(SEC_RESTRICTED_QUIRKS, HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(SEC_RESTRICTED_AUGMENTS)

/datum/job/chief_medical_officer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/chief_engineer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS, "Paraplegic" = TRUE)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/research_director
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/head_of_personnel
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/quartermaster
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

//Silicon
/datum/job/ai
	loadout = FALSE

/datum/job/cyborg
	loadout = FALSE

//Service
/datum/job/cook
	required_languages = null

/datum/job/botanist
	required_languages = null

/datum/job/curator
	required_languages = null

/datum/job/janitor
	required_languages = null

/datum/job/prisoner
	required_languages = null

/datum/job/orderly
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/science_guard
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/customs_agent
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/bouncer
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/engineering_guard
	banned_quirks = list(GUARD_RESTRICTED_QUIRKS)

/datum/job/proc/has_required_languages(datum/preferences/pref)
	if(!required_languages)
		return TRUE
	// if we have a bilingual quirk, check that as well
	var/bilingual_pref
	if(/datum/quirk/bilingual::name in pref.all_quirks)
		bilingual_pref = pref.read_preference(/datum/preference/choiced/language)

	for(var/datum/language/lang as anything in required_languages)
		//Doesnt have language, or the required "level" is too low (understood, while needing spoken)
		if((!pref.languages[lang] || pref.languages[lang] < required_languages[lang]) && bilingual_pref != lang.name) // SKYRAT EDIT - check the bilingual quirk
			return FALSE
	return TRUE

// Nanotrasen Fleet
/datum/job/fleetmaster
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/operations_inspector
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/deck_crew
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)

/datum/job/bridge_officer
	banned_quirks = list(HEAD_RESTRICTED_QUIRKS)
	banned_augments = list(HEAD_RESTRICTED_AUGMENTS)
