/datum/ambition_objective
	var/name
	var/desc
	var/intensity
	var/complete
	var/key
	var/client/parent

/datum/ambition_objective/New(name, desc, intensity, client/parent)
	src.name = truncate(name, 256)
	src.desc = truncate(desc, 256)
	src.intensity = intensity
	src.parent = parent
	key = make_key()
	ParentConnect(parent)

/datum/ambition_objective/proc/make_key()
	. = ""
	do
		. += "[rand()]"
		. = replacetext(., ".", "")
		. = replacetext(., "0", "")
		. = copytext(., -16)
	while(length(.) < 16)

/datum/ambition_objective/Destroy()
	ParentDisconnect(parent)
	parent = null
	return ..()

/datum/ambition_objective/proc/ParentConnect(client/parent)
	return

/datum/ambition_objective/proc/ParentDisconnect(client/parent)
	return

/datum/ambition_objective/proc/mark_completed()
	if(complete)
		return
	complete = TRUE
	on_completion()

/datum/ambition_objective/proc/mark_failed()
	if(!complete)
		return
	complete = FALSE
	on_failed()

/datum/ambition_objective/proc/on_completion()
	return

/datum/ambition_objective/proc/on_failed()
	return
