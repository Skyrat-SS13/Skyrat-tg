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
	if(IsAdminAdvancedProcCall())
		return

	if(!check_rights(R_PERMISSIONS))
		return

	var/choice = tgui_alert(usr, "Which rank would you like to manage?", "Manage Player Ranks", SKYRAT_PLAYER_RANKS)
	if(!choice || !(choice in SKYRAT_PLAYER_RANKS))
		return

	manage_player_rank_in_group(choice)

/**
 * Handles managing player ranks based on the name of the group that was chosen.
 *
 * Arguments:
 * * group - The title of the player rank that was chosen to be managed.
 */
/datum/admins/proc/manage_player_rank_in_group(group)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

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

			var/success = SSplayer_ranks.add_player_to_group(usr.client, player_to_be, group_title)

			if(!success)
				return

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

			var/success = SSplayer_ranks.remove_player_from_group(usr.client, player_that_was, group_title)

			if(!success)
				return

			message_admins("[key_name(usr)] has revoked [group_title] status from [player_that_was].")
			log_admin_private("[key_name(usr)] has revoked [group_title] status from [player_that_was].")

		else
			return



/client/proc/migrate_player_ranks()
	set category = "Debug"
	set name = "Migrate Player Ranks"
	set desc = "Individually migrate the various player ranks from their legacy system to the SQL-based one."

	if(!check_rights(R_PERMISSIONS | R_DEBUG | R_SERVER))
		return

	usr.client?.holder.migrate_player_ranks()


/datum/admins/proc/migrate_player_ranks()
	if(IsAdminAdvancedProcCall())
		return

	if(!check_rights(R_PERMISSIONS | R_DEBUG | R_SERVER))
		return

	if(!CONFIG_GET(flag/sql_enabled))
		return

	var/choice = tgui_alert(usr, "Which rank would you like to migrate?", "Migrate Player Ranks", SKYRAT_PLAYER_RANKS)
	if(!choice || !(choice in SKYRAT_PLAYER_RANKS))
		return

	if(tgui_alert(usr, "Are you sure that you would like to migrate [choice]s to the SQL-based system?", "Migrate Player Ranks", list("Yes", "No")) != "Yes")
		return

	log_admin("[key_name(usr)] is migrating the [choice] player rank from its legacy system to the SQL-based one.")
	SSplayer_ranks.migrate_player_rank_to_sql(usr.client, choice)


#undef SKYRAT_PLAYER_RANKS
