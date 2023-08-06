/// The list of the available special player ranks
#define SKYRAT_PLAYER_RANKS list("Donator", "Mentor", "Veteran")

/client/proc/manage_player_ranks()
	set category = "Admin"
	set name = "Manage Player Ranks"
	set desc = "Manage who has the special player ranks while the server is running."

	if(!check_rights(R_PERMISSIONS))
		return
	usr.client?.holder.manage_player_ranks()

/// Proc for admins to change people's "player" ranks (donator, mentor, veteran, etc.)
/datum/admins/proc/manage_player_ranks()
	if(!check_rights(R_PERMISSIONS))
		return

	var/choice = tgui_alert(usr, "Which rank would you like to manage?", "Manage Player Ranks", SKYRAT_PLAYER_RANKS)
	if(!choice || !(choice in SKYRAT_PLAYER_RANKS))
		return

	manage_player_rank_in_group(choice)

/// Proc that helps a bit with repetition, basically an extension of `manage_player_ranks()`
/datum/admins/proc/manage_player_rank_in_group(group)
	if(!(group in SKYRAT_PLAYER_RANKS))
		CRASH("[key_name(usr)] attempted to add someone to an invalid \"[group]\" group.")

	var/group_title = lowertext(group)

	var/list/choices = list("Add", "Remove")
	switch(tgui_alert(usr, "What would you like to do?", "Manage [group]s", choices))
		if("Add")
			var/name = input(usr, "Please enter the CKEY (case-insensitive) of the person you would like to make a [group_title]:", "Add a [group_title]") as null|text
			if(!name)
				return

			var/player_to_be = ckey(name)
			if(!player_to_be)
				to_chat(usr, span_warning("\"[name]\" is not a valid CKEY."))
				return

			SSplayer_ranks.add_player_to_group(key_name(usr), player_to_be, group_title)

			message_admins("[key_name(usr)] has granted [group_title] status to [player_to_be].")
			log_admin_private("[key_name(usr)] has granted [group_title] status to [player_to_be].")


		if("Remove")
			var/name = input(usr, "Please enter the CKEY (case-insensitive) of the person you would like to no longer be a [group_title]:", "Remove a [group_title]") as null|text
			if(!name)
				return

			var/player_that_was = ckey(name)
			if(!player_that_was)
				to_chat(usr, span_warning("\"[name]\" is not a valid CKEY."))
				return

			var/changes = FALSE
			switch(group)
				if ("Donator")
					for(var/a_donator as anything in GLOB.donator_list)
						if(player_that_was == a_donator)
							GLOB.donator_list -= player_that_was
							changes = TRUE
					if(!changes)
						to_chat(usr, span_warning("\"[player_that_was]\" was already not a [group_title]."))
						return
					// save_donators()

				if("Mentor")
					for(var/a_mentor as anything in GLOB.mentor_datums)
						if(player_that_was == a_mentor)
							var/datum/mentors/mentor_datum = GLOB.mentor_datums[a_mentor]
							mentor_datum.remove_mentor()
							changes = TRUE
					if(!changes)
						to_chat(usr, span_warning("\"[player_that_was]\" was already not a [group_title]."))
					// save_mentors()

				if("Veteran")


				else
					return
			message_admins("[key_name(usr)] has revoked [group_title] status from [player_that_was].")
			log_admin_private("[key_name(usr)] has revoked [group_title] status from [player_that_was].")

		else
			return

#undef SKYRAT_PLAYER_RANKS
