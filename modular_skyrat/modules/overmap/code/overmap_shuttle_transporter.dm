/datum/overmap_object/shuttle/proc/HasTransporter()
	if(length(transporter_extensions))
		return TRUE
	return FALSE

/datum/overmap_object/shuttle/proc/GetTransporter()
	for(var/i in transporter_extensions)
		return i

/datum/overmap_object/shuttle/proc/CapableOfTransporting()
	if(!HasTransporter())
		return FALSE
	if(!lock)
		return FALSE
	var/datum/shuttle_extension/transporter/my_transp = GetTransporter()
	if(my_transp.CanTransport())
		return TRUE
	return FALSE
