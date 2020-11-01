/client/proc/mentor_follow(mob/living/M)
	if(!is_mentor())
		return
	var/orbiting = TRUE
	if(!isobserver(usr))
		mentor_datum.following = M
		usr.reset_perspective(M)
		add_verb(src,/client/proc/mentor_unfollow)
		to_chat(usr, "<span class='info'>Click the <a href='?_src_=mentor;mentor_unfollow=1;[MentorHrefToken(TRUE)]'>\"Stop Following\"</a> button here or in the Mentor tab to stop following [key_name(M)].</span>")
		orbiting = FALSE
	else
		var/mob/dead/observer/O = usr
		O.ManualFollow(M)
	to_chat(GLOB.admins, "<span class='mentor'><span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is now [orbiting ? "orbiting" : "following"] <EM>[key_name(M)][key_name(M)][orbiting ? " as a ghost" : ""].</span>")
	log_mentor("[key_name(usr)] [orbiting ? "is now orbiting" : "began following"][key_name(M)][orbiting ? " as a ghost" : ""].")

/client/proc/mentor_unfollow()
	set category = "Mentor"
	set name = "Stop Following"
	set desc = "Stop following the followed."

	if(!is_mentor())
		return
	usr.reset_perspective()
	remove_verb(src,/client/proc/mentor_unfollow)
	to_chat(GLOB.admins, "<span class='mentor'><span class='prefix'>MENTOR:</span> <EM>[key_name(usr)]</EM> is no longer following <EM>[key_name(mentor_datum.following)].</span>")
	log_mentor("[key_name(usr)] stopped following [key_name(mentor_datum.following)].")
	mentor_datum.following = null
