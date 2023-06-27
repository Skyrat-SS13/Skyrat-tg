// Species trait debuffs
/datum/mood_event/dry_skin
	description = "My skin feels awfully dry...\n"
	mood_change = -2

// Surgery mood debuffs
/datum/mood_event/mild_surgery
	description = "Even if I couldn't feel most of it, it feels wrong being awake while somebody works on your body. Ugh!\n"
	mood_change = -1
	timeout = 5 MINUTES

/datum/mood_event/severe_surgery
	description = "Wait, THEY CUT ME OPEN - AND I FELT EVERY SECOND OF IT!\n"
	mood_change = -4
	timeout = 15 MINUTES

/datum/mood_event/robot_surgery
	description = "Having my robotic parts messed with while I was conscious felt wrong... if only I had a sleep mode!\n"
	mood_change = -4
	timeout = 10 MINUTES
