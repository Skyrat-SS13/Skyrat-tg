/// Runs a check to determine if events will be suspended due to shuttle related events
/datum/controller/subsystem/events/proc/debug_event_schedule()
	message_admins("ICES: Real time: [world.realtime]")
	message_admins("ICES: Transfer target: [SSautotransfer.targettime]")
	message_admins("ICES: World time: [world.time]")
	message_admins("ICES: Start time: [SSticker.round_start_time]")
	message_admins("ICES: Timer differential: [(SSautotransfer.targettime - world.realtime)]")
	message_admins("ICES: Vote period: [15 MINUTES + CONFIG_GET(number/vote_period)]")
	message_admins("ICES: Shuttle refuelling: [CONFIG_GET(number/shuttle_refuel_delay)]")
	if((SSautotransfer.targettime - world.realtime) <= 15 MINUTES + CONFIG_GET(number/vote_period))
		message_admins("ICES: Timer precondition check: FAILED (value is [(SSautotransfer.targettime - world.realtime)] which is lower than [15 MINUTES + CONFIG_GET(number/vote_period)])")
	else
		message_admins("ICES: Timer precondition check: PASSED")
	if((world.time - SSticker.round_start_time <= CONFIG_GET(number/shuttle_refuel_delay)))
		message_admins("ICES: Shuttle precondition check: FAILED (shuttle is refuelling)")
		return
	if(!SSshuttle.canEvac())
		message_admins("ICES: Shuttle precondition check: FAILED ([SSshuttle.canEvac()])")
	else
		message_admins("ICES: Shuttle precondition check: PASSED")
