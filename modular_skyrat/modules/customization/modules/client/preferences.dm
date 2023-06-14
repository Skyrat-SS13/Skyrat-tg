/// Cleans up any invalid languages. Typically happens on language renames and codedels.
/datum/preferences/proc/sanitize_languages()
	var/languages_edited = FALSE
	for(var/lang_path as anything in languages)
		if(!lang_path)
			languages.Remove(lang_path)
			languages_edited = TRUE
			continue

		var/datum/language/language = new lang_path()
		// Yes, checking subtypes is VERY necessary, because byond doesn't check to see if a path is valid at runtime!
		// If you delete /datum/language/meme, it will still load as /datum/language/meme, and will instantiate with /datum/language's defaults!
		var/species_type = read_preference(/datum/preference/choiced/species)
		var/datum/species/species = new species_type()
		if(!(language.type in subtypesof(/datum/language)) || (language.secret && !(language.type in species.language_prefs_whitelist)))
			languages.Remove(lang_path)
			languages_edited = TRUE
		qdel(species)
		qdel(language)
	return languages_edited

/// Cleans any quirks that should be hidden, or just simply don't exist from quirk code.
/datum/preferences/proc/sanitize_quirks()
	var/quirks_edited = FALSE
	for(var/datum/quirk/quirk as anything in all_quirks)
		if(!quirk || !(quirk in SSquirks.quirks))
			all_quirks.Remove(quirk)
			quirks_edited = TRUE
			continue

		quirk = SSquirks.quirks[quirk]
		// Explanation for this is above.
		if(!quirk || initial(quirk.hidden_quirk))
			all_quirks.Remove(quirk)
			quirks_edited = TRUE

	return quirks_edited
