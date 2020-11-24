/datum/round_event/meteor_wave/setup()
	startWhen = rand(90, 180) // Apparently it is by 2 seconds, so 90 is actually 180 seconds, and 180 is 360 seconds. So this is 3-6 minutes
	endWhen = startWhen + 60
