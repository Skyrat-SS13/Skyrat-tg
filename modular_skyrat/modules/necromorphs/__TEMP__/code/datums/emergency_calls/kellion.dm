/*
	Emergency Call
*/
/datum/emergency_call/kellionteam
	name = "Kellionteam"
	pref_name = "CEC Repair Crew"
	weight = 1
	landmark_tag = "kellionteam"
	antag_id = ERT_CEC_REPAIR

/*
	Antagonist
*/


/datum/antagonist/ert/kellion
	id = ERT_CEC_REPAIR
	role_text = "CEC Repair Crew"
	role_text_plural = "CEC Repair Crew"
	leader_welcome_text = "As leader of the CEC Repair Crew, you are there with the intention of restoring normal operation to the vessel or the safe evacuation of crew and passengers. You should first of all make contact with the local command staff, and follow all orders from them."
	landmark_id = "kellionteam"
	initial_spawn_req = 1	//Isaac can come alone
	outfits = list(
		/decl/hierarchy/outfit/isaac,
		/decl/hierarchy/outfit/kendra,
		/decl/hierarchy/outfit/kellion_sec_leader
		)

	fallback_outfits = list(/decl/hierarchy/outfit/kellion_sec)
