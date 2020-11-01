GLOBAL_LIST_EMPTY(mentorlog)
GLOBAL_PROTECT(mentorlog)

/proc/log_mentor(text)
	GLOB.mentorlog.Add(text)
	WRITE_FILE(GLOB.world_game_log, "MENTOR: [text]")

/datum/admins/proc/MentorLogSecret()
	var/dat = "<B>Mentor Log<HR></B>"
	for(var/l in GLOB.mentorlog)
		dat += "<li>[l]</li>"

	if(!GLOB.mentorlog.len)
		dat += "No mentors have done anything this round!"
	usr << browse(dat, "window=mentor_log")
