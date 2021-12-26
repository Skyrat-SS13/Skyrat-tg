/datum/mind
	var/datum/opposing_force/opposing_force

/datum/mind/Destroy()
	QDEL_NULL(opposing_force)
	return ..()
