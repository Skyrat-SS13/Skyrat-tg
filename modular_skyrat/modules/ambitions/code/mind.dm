/// Our ambitions holder, if it exists
/datum/mind/var/datum/ambitions/ambitions

/datum/mind/Destroy()
	ambitions?.disconnect()
	return ..()

/datum/mind/New()
	if(GLOB.ambitions[key])
		GLOB.ambitions[key].connect(src)
	return ..()

/// Add an antag datum to our ambitions holder
/datum/mind/proc/init_ambition(datum/antagonist/antag)
	if(!ambitions)
		ambitions = new(src)
	ambitions.owner_antags |= antag
	to_chat(src, span_adminhelp("You are now \a [antag]! Please adjust your ambitions accordingly."))
	if(ambitions.approved)
		message_admins(span_adminhelp("[src] is now \a [antag] after their previous ambitions were approved. Their ambitions have been automatically un-approved however they may still their old equipment/powers."))
		ambitions.approved = FALSE
		ambitions.handling = null
	ambitions._log("ANTAG+= [antag]")

/// Remove an antag datum from our ambitions holder
/datum/mind/proc/dest_ambition(datum/antagonist/antag)
	if(!ambitions)
		CRASH("Attempted to remove antag from a non-extistant ambitions holder")
	ambitions.owner_antags -= antag

	if(length(ambitions.owner_antags) > 0)
		to_chat(src, span_adminhelp("You are no longer \a [antag]! Please adjust your ambitions accordingly."))
		if(ambitions.approved)
			message_admins(span_adminhelp("[src] is now \a [antag] after their previous ambitions were approved. Their ambitions have been automatically un-approved however they may still their old equipment/powers."))
			ambitions.approved = FALSE
			ambitions.handling = null
		return

	to_chat(src, span_adminhelp("You are no longer an antag and your ambitions will now be removed."))
	message_admins(span_adminhelp("[src] is no longer an antag."))
	qdel(src)
