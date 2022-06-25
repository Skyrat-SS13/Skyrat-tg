/datum/action/innate/cellular_emporium/proc/opfor_check()
	if(owner.has_antag_datum(/datum/antagonist))
		var/datum/opposing_force/user_opfor = owner?.mind?.opposing_force
		if(user_opfor.approved_ever)
			return TRUE
		return FALSE
	return TRUE
