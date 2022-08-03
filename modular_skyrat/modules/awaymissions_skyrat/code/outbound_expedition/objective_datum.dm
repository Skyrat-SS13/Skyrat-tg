/datum/outbound_objective
	/// What's the objective called?
	var/name = ""
	/// Text given to whoever gets it
	var/desc = ""
	/// Matching ID of the landmark
	var/landmark_id = ""

/// If it should do anything extra when given, bear in mind the objectives are initialized on the controller, not person
/datum/outbound_objective/proc/on_give(mob/living/given_mob)
	return

// generic "go to cryo" objective used a bunch
/datum/outbound_objective/cryo
	name = "Cryo"
	desc = "Enter cryogenic storage when you are ready."
	landmark_id = "cryo"

/datum/outbound_objective/cryo/on_give()
	OUTBOUND_CONTROLLER
	if(!length(outbound_controller.uncryoed_mobs))
		outbound_controller.uncryoed_mobs = outbound_controller.participating_mobs.Copy()

/datum/outbound_objective/talk_person
	name = "Commander Talk"
	desc = "Talk with the commander before departing."
	landmark_id = "talk_person"

/datum/outbound_objective/wait
	name = "Wait"
	desc = "Wait for the ship's thrusters to recharge."
	landmark_id = "wait" //won't be used but muh safety

/datum/outbound_objective/wait_beacon
	name = "Wait (Cargo Beacon)"
	desc = "Wait for the ship's thrusters to recharge."
	landmark_id = "wait_pod" // unused too

/datum/outbound_objective/radio_listen
	name = "Listen to Bridge Radio"
	desc = "Proceed to the bridge."
	landmark_id = "bridge_radio"

/datum/outbound_objective/raid_ship //raiders
	name = "Raid the Ship"
	desc = "Raid the interdicted ship."
	landmark_id = "bridge_center"

/datum/outbound_objective/part_fix
	name = "Part Fixing"
	desc = "Fix the malfunctioning panels!"
	landmark_id = "part_fix"
