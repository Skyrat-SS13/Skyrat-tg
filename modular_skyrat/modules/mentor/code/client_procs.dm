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
	
	//Converting mentorhelp to adminhelp
	if(href_list["convert"])
		var/text = locate(href_list["convert_text"])
		var/client/user = locate(href_list["convert"])

		if(!user || !text)
			return FALSE

		for(var/datum/admin_help/ticket in GLOB.ahelp_tickets.active_tickets)
			if(ticket.initiator_ckey == user.ckey)
				return FALSE
		
		to_chat(user, span_adminhelp("Your MentorHelp was converted into AdminHelp."))
		message_admins("[key_name(src)] converted MentorHelp from [key_name(user)] into AdminHelp")
		log_admin("[ckey] converted [user.ckey] MentorHelp into AdminHelp")

		GLOB.admin_help_ui_handler.perform_adminhelp(user, text)

/client/proc/mentor_datum_set(admin)
	mentor_datum = GLOB.mentor_datums[ckey]
	if(!mentor_datum && check_rights_for(src, R_ADMIN,0)) // admin with no mentor datum?let's fix that
		new /datum/mentors(ckey)
	if(mentor_datum)
		mentor_datum.owner = src
		GLOB.mentors[src] = TRUE
		add_mentor_verbs()
		if(check_rights_for(src, R_ADMIN,0) && prefs.read_preference(/datum/preference/toggle/admin/auto_dementor))
			cmd_mentor_dementor()

/client/proc/is_mentor() // admins are mentors too.
	if(mentor_datum || check_rights_for(src, R_ADMIN,0))
		return TRUE
