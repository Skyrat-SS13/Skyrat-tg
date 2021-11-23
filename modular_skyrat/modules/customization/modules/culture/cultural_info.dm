/datum/cultural_info
	/// Name of the cultural thing, be it place, faction, or culture
	var/name
	/// It's description
	var/description
	/// Economic power, this impacts the initial paychecks by a bit
	var/economic_power = 1
	/// It'll force people to know this language if they've picked this cultural thing
	var/required_lang
	/// This will allow people to pick extra languages
	var/list/additional_langs

/datum/cultural_info/proc/get_extra_desc(more = FALSE)
	. += "<BR>Economic power: [economic_power*100]%"
	if(required_lang)
		var/datum/language/lang_datum = required_lang
		. += "<BR>Language: [initial(lang_datum.name)]"
	if(!more)
		return
	if(additional_langs)
		. += "<BR>Optional Languages: "
		var/not_first_iteration = FALSE
		for(var/langkey in additional_langs)
			var/datum/language/lang_datum = langkey
			if(not_first_iteration)
				. += ", "
			else
				not_first_iteration = TRUE
			. += "[initial(lang_datum.name)]"
