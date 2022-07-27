/datum/outbound_objective
	/// What's the objective called?
	var/name = ""
	/// Text given to whoever gets it
	var/desc = ""
	/// Matching ID of the landmark
	var/landmark_id = ""

// generic "go to cryo" objective used a bunch
/datum/outbound_objective/cryo
	name = "Cryo"
	desc = "Enter cryogenic storage when you are ready."
	landmark_id = "cryo"

/datum/outbound_objective/talk_person
	name = "Commander Talk"
	desc = "Talk with the commander before departing."
	landmark_id = "talk_person"

