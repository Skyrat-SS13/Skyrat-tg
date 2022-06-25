/datum/component/uplink/proc/opfor_check(mob/living/carbon/user)
	if(user.has_antag_datum(/datum/antagonist))
		var/datum/opposing_force/user_opfor = user?.mind?.opposing_force
		if(user_opfor.approved_ever)
			return TRUE
		return FALSE
	return TRUE
