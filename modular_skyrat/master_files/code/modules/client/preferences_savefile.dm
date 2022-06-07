/**
 * This is a cheap replica of the standard savefile version, only used for characters for now.
 * You can't really use the non-modular version, least you eventually want asinine merge
 * conflicts and/or potentially disastrous issues to arise, so here's your own.
 */
#define MODULAR_SAVEFILE_VERSION_MAX 1

#define MODULAR_SAVEFILE_UP_TO_DATE -1

/**
 * Checks if the modular side of the savefile is up to date.
 * If the return value is higher than 0, update_character_skyrat() will be called later.
 */
/datum/preferences/proc/savefile_needs_update_skyrat(savefile/save)
	var/savefile_version
	READ_FILE(save["modular_version"], savefile_version)

	if(savefile_version < MODULAR_SAVEFILE_VERSION_MAX)
		return savefile_version
	return MODULAR_SAVEFILE_UP_TO_DATE

/// Loads the modular customizations of a character from the savefile
/datum/preferences/proc/load_character_skyrat(savefile/save)

	var/needs_update = savefile_needs_update_skyrat(save)

	READ_FILE(save["loadout_list"], loadout_list)

	READ_FILE(save["augments"] , augments)
	READ_FILE(save["augment_limb_styles"] , augment_limb_styles)

	augments = SANITIZE_LIST(augments)
	// validating augments
	for(var/aug_slot in augments)
		var/datum/augment_item/aug = GLOB.augment_items[augments[aug_slot]]
		if(!aug)
			augments -= aug_slot
	augment_limb_styles = SANITIZE_LIST(augment_limb_styles)
	// validating limb styles
	for(var/key in augment_limb_styles)
		if(!GLOB.robotic_styles_list[augment_limb_styles[key]])
			augment_limb_styles -= key


	READ_FILE(save["features"], features)
	READ_FILE(save["mutant_bodyparts"], mutant_bodyparts)
	READ_FILE(save["body_markings"], body_markings)
	body_markings = update_markings(body_markings)
	READ_FILE(save["mismatched_customization"], mismatched_customization)
	READ_FILE(save["allow_advanced_colors"], allow_advanced_colors)

// SKYRAT EDIT REMOVAL BEGIN -- RECORDS REJUVINATION
/*	READ_FILE(save["general_record"], general_record)
	READ_FILE(save["security_record"], security_record)
	READ_FILE(save["medical_record"], medical_record)
	READ_FILE(save["background_info"], background_info)
	READ_FILE(save["exploitable_info"], exploitable_info) */
// SKYRAT EDIT REMOVAL END

	READ_FILE(save["alt_job_titles"], alt_job_titles)

	general_record = sanitize_text(general_record)
	security_record = sanitize_text(security_record)
	medical_record = sanitize_text(medical_record)
	background_info = sanitize_text(background_info)
	exploitable_info = sanitize_text(exploitable_info)
	loadout_list = sanitize_loadout_list(update_loadout_list(loadout_list))

	READ_FILE(save["languages"] , languages)
	languages = SANITIZE_LIST(languages)

	READ_FILE(save["tgui_prefs_migration"], tgui_prefs_migration)
	if(!tgui_prefs_migration)
		to_chat(parent, examine_block(span_redtext("PREFERENCE MIGRATION BEGINNING FOR.\
		\nDO NOT INTERACT WITH YOUR PREFERENCES UNTIL THIS PROCESS HAS BEEN COMPLETED.\
		\nDO NOT DISCONNECT UNTIL THIS PROCESS HAS BEEN COMPLETED.\
		")))
		migrate_skyrat(save)
		addtimer(CALLBACK(src, .proc/check_migration), 10 SECONDS)

	READ_FILE(save["headshot"], headshot)

	if(needs_update >= 0)
		update_character_skyrat(needs_update, save) // needs_update == savefile_version if we need an update (positive integer)

/// Brings a savefile up to date with modular preferences. Called if savefile_needs_update_skyrat() returned a value higher than 0
/datum/preferences/proc/update_character_skyrat(current_version, savefile/save)

	if(current_version < 1)
		// removed genital toggles, with the new choiced prefs paths as assoc
		var/static/list/old_toggles
		if(!old_toggles)
			old_toggles = list("penis_toggle" = /datum/preference/choiced/genital/penis,
				"testicles_toggle" = /datum/preference/choiced/genital/testicles,
				"vagina_toggle" = /datum/preference/choiced/genital/vagina,
				"womb_toggle" = /datum/preference/choiced/genital/womb,
				"breasts_toggle" = /datum/preference/choiced/genital/breasts,
				"anus_toggle" = /datum/preference/choiced/genital/anus,
			)
		for(var/toggle in old_toggles)
			var/has_genital
			READ_FILE(save[toggle], has_genital)
			if(!has_genital) // The toggle was off, so we make sure they have it set to the default "None" in the dropdown pref.
				var/datum/preference/genital = GLOB.preference_entries[old_toggles[toggle]]
				write_preference(genital, genital.create_default_value())

		var/uses_skintone
		READ_FILE(save["skin_tone_toggle"], uses_skintone)
		if(uses_skintone)
			for(var/pref_type in subtypesof(/datum/preference/toggle/genital_skin_tone))
				write_preference(GLOB.preference_entries[pref_type], TRUE)

/datum/preferences/proc/check_migration()
	if(!tgui_prefs_migration)
		to_chat(parent, examine_block(span_redtext("CRITICAL FAILURE IN PREFERENCE MIGRATION, REPORT THIS IMMEDIATELY.")))
		message_admins("PREFERENCE MIGRATION: [ADMIN_LOOKUPFLW(parent)] has failed the process for migrating PREFERENCES. Check runtimes.")

/// Saves the modular customizations of a character on the savefile
/datum/preferences/proc/save_character_skyrat(savefile/save)

	WRITE_FILE(save["loadout_list"], loadout_list)
	WRITE_FILE(save["augments"] , augments)
	WRITE_FILE(save["augment_limb_styles"] , augment_limb_styles)
	WRITE_FILE(save["features"] , features)
	WRITE_FILE(save["mutant_bodyparts"] , mutant_bodyparts)
	WRITE_FILE(save["body_markings"] , body_markings)

	WRITE_FILE(save["mismatched_customization"], mismatched_customization)
	WRITE_FILE(save["allow_advanced_colors"], allow_advanced_colors)

// SKYRAT EDIT REMOVAL BEGIN -- RECORDS REJUVINATION
/*	WRITE_FILE(save["general_record"] , general_record)
	WRITE_FILE(save["security_record"] , security_record)
	WRITE_FILE(save["medical_record"] , medical_record)
	WRITE_FILE(save["background_info"] , background_info)
	WRITE_FILE(save["exploitable_info"] , exploitable_info) */
// SKYRAT EDIT REMOVAL END
	WRITE_FILE(save["alt_job_titles"], alt_job_titles)
	WRITE_FILE(save["languages"] , languages)
	WRITE_FILE(save["headshot"], headshot)

	WRITE_FILE(save["modular_version"] , MODULAR_SAVEFILE_VERSION_MAX)

/datum/preferences/proc/update_mutant_bodyparts(datum/preference/preference)
	if (!preference.relevant_mutant_bodypart)
		return
	var/part = preference.relevant_mutant_bodypart
	var/value = read_preference(preference.type)
	if (isnull(value))
		return
	if (istype(preference, /datum/preference/toggle))
		if (!value)
			if (part in mutant_bodyparts)
				mutant_bodyparts -= part
		else
			var/datum/preference/choiced/name = GLOB.preference_entries_by_key["feature_[part]"]
			var/datum/preference/tri_color/color = GLOB.preference_entries_by_key["[part]_color"]
			if (isnull(name) || isnull(color))
				return
			mutant_bodyparts[part] = list()
			mutant_bodyparts[part][MUTANT_INDEX_NAME] = read_preference(name.type)
			mutant_bodyparts[part][MUTANT_INDEX_COLOR_LIST] = read_preference(color.type)
	if (istype(preference, /datum/preference/choiced))
		if (part in mutant_bodyparts)
			mutant_bodyparts[part][MUTANT_INDEX_NAME] = value
	if (istype(preference, /datum/preference/tri_color))
		if (part in mutant_bodyparts)
			mutant_bodyparts[part][MUTANT_INDEX_COLOR_LIST] = value

/datum/preferences/proc/update_markings(list/markings)
	if (islist(markings))
		for (var/marking in markings)
			for (var/title in markings[marking])
				if (!islist(markings[marking][title]))
					markings[marking][title] = list(sanitize_hexcolor(markings[marking][title]), FALSE)
	return markings

#undef MODULAR_SAVEFILE_VERSION_MAX
#undef MODULAR_SAVEFILE_UP_TO_DATE
