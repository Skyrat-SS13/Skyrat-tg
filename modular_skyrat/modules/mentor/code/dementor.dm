/client/proc/cmd_mentor_dementor()
	set category = "Mentor"
	set name = "dementor"
	if(!is_mentor())
		return
	remove_mentor_verbs()
	if (/client/proc/mentor_unfollow in verbs)
		mentor_unfollow()
	GLOB.mentors -= src
	to_chat(src, span_interface("You are no longer a mentor."))
	log_mentor("MENTOR: [src] dementored.")
	add_verb(src,/client/proc/cmd_mentor_rementor)

/client/proc/cmd_mentor_rementor()
	set category = "Mentor"
	set name = "rementor"
	if(!is_mentor())
		return
	add_mentor_verbs()
	GLOB.mentors[src] = TRUE
	to_chat(src, span_interface("You are now a mentor."))
	log_mentor("MENTOR: [src] rementored.")
	remove_verb(src,/client/proc/cmd_mentor_rementor)
