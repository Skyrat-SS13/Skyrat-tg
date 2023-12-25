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

/client/proc/mentor_datum_set()
	mentor_datum = GLOB.mentor_datums[ckey]
	if(!mentor_datum && is_admin(src)) // admin with no mentor datum? let's fix that
		new /datum/mentors(ckey)

	if(mentor_datum)
		mentor_datum.owner = src
		GLOB.mentors[src] = TRUE
		add_mentor_verbs()

		if(check_rights_for(src, R_ADMIN) && prefs.read_preference(/datum/preference/toggle/admin/auto_dementor))
			cmd_mentor_dementor()


/**
 * Returns whether or not the user is qualified as a mentor.
 *
 * Arguments:
 * * admin_bypass - Whether or not admins can succeed this check, even if they
 * do not actually possess the role. Defaults to `TRUE`.
 */
/client/proc/is_mentor(admin_bypass = TRUE)
	if(mentor_datum || (admin_bypass && check_rights_for(src, R_ADMIN)))
		return TRUE
