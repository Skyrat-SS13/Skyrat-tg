/datum/mind/proc/make_contractor_support()
	var/contractor_support_datum = has_antag_datum(/datum/antagonist/traitor/contractor_support)
	if(contractor_support_datum)
		return contractor_support_datum
	return add_antag_datum(/datum/antagonist/traitor/contractor_support)
