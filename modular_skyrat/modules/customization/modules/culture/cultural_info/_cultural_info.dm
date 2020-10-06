/datum/cultural_info
	var/name
	var/description
	var/economic_power = 1
	var/required_lang
	var/list/additional_langs

/datum/cultural_info/proc/get_extra_desc(more = FALSE)
	. += "<BR>Economic power: [economic_power*100]%"
	if(required_lang)
		. += "<BR>Language: [required_lang]"
	if(!more)
		return
	if(additional_langs)
		. += "<BR>Optional Languages: [length(additional_langs)]"
