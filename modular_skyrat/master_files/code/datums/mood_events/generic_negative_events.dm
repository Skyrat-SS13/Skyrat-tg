// Species trait debuffs
/datum/mood_event/dry_skin
	description = "<span class='warning'>My skin feels awfully dry...</span>\n"
	mood_change = -1

// Surgery mood debuffs
/datum/mood_event/mild_surgery
	description = "<span class='warning'>Even if I couldn't feel most of it, it feels wrong being awake while somebody works on your body. Ugh!</span>\n"
	mood_change = -1
	timeout = 5 MINUTES

/datum/mood_event/severe_surgery
	description = "<span class='boldwarning'>Wait, THEY CUT ME OPEN - AND I FELT EVERY SECOND OF IT!</span>\n"
	mood_change = -4
	timeout = 15 MINUTES

/datum/mood_event/robot_surgery
	description = "<span class='warning'>Having my robotic parts messed with while I was conscious felt wrong... if only I had a sleep mode!</span>\n"
	mood_change = -4
	timeout = 10 MINUTES
