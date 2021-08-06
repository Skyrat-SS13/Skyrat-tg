/client/proc/cmd_mentor_dementor()
	set category = "Mentor"
	set name = "dementor"
	if(!is_mentor())
		return
	remove_mentor_verbs()
	if (/client/proc/mentor_unfollow in verbs)
		mentor_unfollow()
	to_chat(GLOB.mentors, "<span class='mentor'><b><font color ='#E236D8'><span class='prefix'>MENTOR:</span> [src] has dementored.</font></b></span>")
	GLOB.mentors -= src
	add_verb(src,/client/proc/cmd_mentor_rementor)

/client/proc/cmd_mentor_rementor()
	set category = "Mentor"
	set name = "rementor"
	if(!is_mentor())
		return
	add_mentor_verbs()
	GLOB.mentors[src] = TRUE
	to_chat(GLOB.mentors, "<span class='mentor'><b><font color ='#E236D8'><span class='prefix'>MENTOR:</span> [src] has rementored.</font></b></span>")
	remove_verb(src,/client/proc/cmd_mentor_rementor)
