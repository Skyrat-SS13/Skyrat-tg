GLOBAL_LIST_EMPTY(mentorlog)
GLOBAL_PROTECT(mentorlog)

/proc/log_mentor(text)
	GLOB.mentorlog.Add(text)
	WRITE_FILE(GLOB.world_game_log, "MENTOR: [text]")
