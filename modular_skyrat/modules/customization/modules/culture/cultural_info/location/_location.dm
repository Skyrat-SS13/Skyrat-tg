/datum/cultural_info/location
	var/distance
	var/ruling_body
	var/capital

/datum/cultural_info/location/generic
	name = "Other Location"
	description = "You reside in one, less known place somewhere in the galaxy."

/datum/cultural_info/location/get_extra_desc(more = FALSE)
	. = ..()
	if(!more)
		return
	. += "<BR>Distance: [distance ? "[distance]" : "Unknown"]"
	. += "<BR>Ruler: [ruling_body ? "[ruling_body]" : "Unknown"]"
	. += "<BR>Capital: [capital ? "[capital]" : "Unknown"]"
