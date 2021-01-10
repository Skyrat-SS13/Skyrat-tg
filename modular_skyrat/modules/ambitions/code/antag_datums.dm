/datum/antagonist
	///Whether the antagonist uses ambitions
	var/uses_ambitions = FALSE
	///A check to see if they have already been given there gear
	var/has_been_antag_geared = FALSE

///This gets called after our ambitions are submitted, or the antag datum is given to someone with filled ambitions
/datum/antagonist/proc/ambitions_add()
	return

///This gets called to remove things from an antagonist, given that they had ambitions submitted (ie. remove powers from ling, remove uplink from traitors)
/datum/antagonist/proc/ambitions_removal()
	return

/datum/antagonist/traitor
	uses_ambitions = TRUE

/datum/antagonist/traitor/ambitions_add()
	if(traitor_kind == TRAITOR_HUMAN && should_equip)
		if(!has_been_antag_geared)
			equip()
			has_been_antag_geared = TRUE
		else
			message_admins("[usr.ckey] has already had there Trator items given, Not Giving Items")

/datum/antagonist/changeling
	uses_ambitions = TRUE

/datum/antagonist/changeling/ambitions_add()
	create_actions()
	reset_powers()
	create_initial_profile()

/datum/antagonist/changeling/ambitions_removal()
	remove_changeling_powers()

/datum/objective/ambitions
	name = "ambitions"
	explanation_text = "Open up ambitions from the IC tab and craft your unique antagonistic story."

/datum/objective/ambitions/check_completion()
	return TRUE
