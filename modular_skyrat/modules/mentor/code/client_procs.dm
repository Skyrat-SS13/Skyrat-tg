/client/New()
	. = ..()
	mentor_datum_set()

/client/Destroy()
	if(GLOB.mentors[src])
		GLOB.mentors -= src
	return ..()

/client/proc/mentor_client_procs(href_list)
	if(href_list["mentor_msg"])
		if(CONFIG_GET(flag/mentors_mobname_only))
			var/mob/M = locate(href_list["mentor_msg"])
			cmd_mentor_pm(M,null)
		else
			cmd_mentor_pm(href_list["mentor_msg"],null)
		return TRUE

	//Mentor Follow
	if(href_list["mentor_follow"])
		var/mob/living/M = locate(href_list["mentor_follow"])

		if(istype(M))
			mentor_follow(M)
		return TRUE

	if(href_list["mentor_unfollow"])
		if(mentor_datum.following)
			mentor_unfollow()
		return TRUE

/client/proc/mentor_datum_set(admin)
	mentor_datum = GLOB.mentor_datums[ckey]
	if(!mentor_datum && check_rights_for(src, R_ADMIN,0)) // admin with no mentor datum?let's fix that
		new /datum/mentors(ckey)
	if(mentor_datum)
		mentor_datum.owner = src
		GLOB.mentors[src] = TRUE
		add_mentor_verbs()
		if(check_rights_for(src, R_ADMIN,0))
			cmd_mentor_dementor()

/client/proc/is_mentor() // admins are mentors too.
	if(mentor_datum || check_rights_for(src, R_ADMIN,0))
		return TRUE
