/datum/round_event_control
	/// Do we override the votable component? (For events that just end the round)
	var/votable = TRUE

/datum/round_event_control/cme/armageddon
	votable = FALSE

