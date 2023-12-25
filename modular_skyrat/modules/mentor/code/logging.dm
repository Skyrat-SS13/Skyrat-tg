GLOBAL_LIST_EMPTY(mentorlog)
GLOBAL_PROTECT(mentorlog)

/proc/log_mentor(text, list/data)
	GLOB.mentorlog.Add(text)
	logger.Log(LOG_CATEGORY_GAME_MENTOR, text, data)

/datum/admins/proc/MentorLogSecret()
	var/dat = "<B>Mentor Log<HR></B>"
	for(var/l in GLOB.mentorlog)
		dat += "<li>[l]</li>"

	if(!GLOB.mentorlog.len)
		dat += "No mentors have done anything this round!"
	usr << browse(dat, "window=mentor_log")
