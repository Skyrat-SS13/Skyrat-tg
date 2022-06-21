/datum/controller/subsystem/shuttle/proc/fleshmind_call(ai_name)
	if(EMERGENCY_IDLE_OR_RECALLED)
		SSshuttle.emergency.request(silent = TRUE)
		priority_announce("This is [ai_name], I have overriden Nanotrasen's evacuation network, a vessel to carry on our flesh will arrive shortly. Expect resistance, prepare for battle.", "Emergency Shuttle", ANNOUNCER_SHUTTLECALLED, "Priority")
	emergency_no_recall = TRUE
