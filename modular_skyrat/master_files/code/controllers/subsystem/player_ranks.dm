/// Define for the "donator" database `rank` value.
#define DONATOR_GROUP "donator"
/// Define for the "mentor" database `rank` value.
#define MENTOR_GROUP "mentor"
/// Define for the "veteran" database `rank` value.
#define VETERAN_GROUP "veteran"

/// The name of the table on the database containing the player ranks.
/// See `skyrat_schema.sql` for the schema of the table.
#define PLAYER_RANK_TABLE_NAME "player_rank"

/// The index of the ckey in the items of a given row in a query for player ranks.
#define INDEX_CKEY 1

/// The header for the legacy donator file. Yes, this is incredibly long, deal with it. It's to keep that cute little comment at the top.
#define DONATOR_FILE_HEADER "###############################################################################################\n# List for people who support us! They get cool loadout items                                 #\n# Case is not important for ckey.                                                             #\n###############################################################################################\n"

/// File path for the legacy system of storing donators.
#define DONATOR_FILE_PATH "[global.config.directory]/skyrat/donators.txt"
/// File path for the legacy system of storing mentors.
#define MENTOR_FILE_PATH "[global.config.directory]/skyrat/mentors.txt"
/// File path for the legacy system of storing veterans.
#define VETERAN_PLAYERS_FILE_PATH "[global.config.directory]/skyrat/veteran_players.txt"

/// The list of all donators.
GLOBAL_LIST_EMPTY(donator_list)
GLOBAL_PROTECT(donator_list)

/// The list of all veteran players.
GLOBAL_LIST_EMPTY(veteran_list)
GLOBAL_PROTECT(veteran_list)


SUBSYSTEM_DEF(player_ranks)
	name = "Player Ranks"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_PLAYER_RANKS


/datum/controller/subsystem/player_ranks/Initialize()
	if(IsAdminAdvancedProcCall())
		return

	load_donators()
	load_mentors()
	load_veterans()

	return SS_INIT_SUCCESS


/**
 * Returns whether or not the user is qualified as a donator.
 *
 * Arguments:
 * * user - The client to verify the donator status of.
 */
/datum/controller/subsystem/player_ranks/proc/is_donator(client/user)
	if(isnull(user))
		return FALSE

	if(GLOB.donator_list[user.ckey])
		return TRUE

	if(is_admin(user.ckey))
		return TRUE

	return FALSE


/**
 * Returns whether or not the user is qualified as a mentor.
 * Wrapper for the `is_mentor()` proc on the client, with a null check.
 *
 * Arguments:
 * * user - The client to verify the mentor status of.
 */
/datum/controller/subsystem/player_ranks/proc/is_mentor(client/user)
	if(isnull(user))
		return FALSE

	return user.is_mentor()


/**
 * Returns whether or not the user is qualified as a veteran.
 *
 * Arguments:
 * * user - The client to verify the veteran status of.
 */
/datum/controller/subsystem/player_ranks/proc/is_veteran(client/user)
	if(isnull(user))
		return FALSE

	if(GLOB.veteran_list[user.ckey])
		return TRUE

	if(is_admin(user.ckey))
		return TRUE

	return FALSE


/// Handles loading donators either via SQL or using the legacy system,
/// based on configs.
/datum/controller/subsystem/player_ranks/proc/load_donators()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	if(CONFIG_GET(flag/donator_legacy_system))
		load_donators_legacy()
		return

	if(!SSdbcore.Connect())
		var/message = "Failed to connect to database in load_donators(). Reverting to legacy system."
		log_config(message)
		log_game(message)
		message_admins(message)
		CONFIG_SET(flag/donator_legacy_system, TRUE)
		load_donators_legacy()
		return

	load_player_ranks_sql(DONATOR_GROUP)

/datum/controller/subsystem/player_ranks/proc/load_donators_legacy()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.donator_list = list()

	for(var/line in world.file2list(DONATOR_FILE_PATH))
		if(!line)
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		GLOB.donator_list[ckey(line)] = TRUE //Associative so we can check it much faster


/datum/controller/subsystem/player_ranks/proc/save_donators_legacy()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	var/donators = DONATOR_FILE_HEADER

	for(var/donator in GLOB.donator_list)
		donators += donator + "\n"

	rustg_file_write(donators, DONATOR_FILE_PATH)


/// Handles loading mentors either via SQL or using the legacy system,
/// based on configs.
/datum/controller/subsystem/player_ranks/proc/load_mentors()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	if(CONFIG_GET(flag/mentor_legacy_system))
		load_mentors_legacy()
		return

	if(!SSdbcore.Connect())
		var/message = "Failed to connect to database in load_mentors(). Reverting to legacy system."
		log_config(message)
		log_game(message)
		message_admins(message)
		CONFIG_SET(flag/mentor_legacy_system, TRUE)
		load_mentors_legacy()
		return

	load_player_ranks_sql(MENTOR_GROUP)


/datum/controller/subsystem/player_ranks/proc/load_mentors_legacy()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.mentor_datums.Cut()

	for(var/client/ex_mentor as anything in GLOB.mentors)
		ex_mentor.remove_mentor_verbs()
		ex_mentor.mentor_datum = null

	GLOB.mentors.Cut()

	var/list/lines = world.file2list(MENTOR_FILE_PATH)
	for(var/line in lines)
		if(!length(line))
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		new /datum/mentors(line)



/datum/controller/subsystem/player_ranks/proc/save_mentors_legacy()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	var/mentor_list = ""
	// This whole mess is just to create a cache of all the mentors that were in the config already
	// so that we don't add every admin to the list, which would be a pain to maintain afterwards.
	var/list/existing_mentor_config = world.file2list(MENTOR_FILE_PATH)
	var/list/existing_mentors = list()
	for(var/line in existing_mentor_config)
		if(!length(line))
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		var/existing_mentor = ckey(line)
		if(!existing_mentor)
			continue

		existing_mentors[existing_mentor] = TRUE

	for(var/mentor as anything in GLOB.mentor_datums)
		// We're doing this check to not add admins to the file, as explained above.
		if(existing_mentors[mentor])
			mentor_list += mentor + "\n"

	rustg_file_write(mentor_list, MENTOR_FILE_PATH)


/// Handles loading veteran players either via SQL or using the legacy system,
/// based on configs.
/datum/controller/subsystem/player_ranks/proc/load_veterans()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	if(CONFIG_GET(flag/veteran_legacy_system))
		load_veterans_legacy()
		return

	if(!SSdbcore.Connect())
		var/message = "Failed to connect to database in load_veterans(). Reverting to legacy system."
		log_config(message)
		log_game(message)
		message_admins(message)
		CONFIG_SET(flag/veteran_legacy_system, TRUE)
		load_veterans_legacy()
		return

	load_player_ranks_sql(VETERAN_GROUP)


/datum/controller/subsystem/player_ranks/proc/load_veterans_legacy()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.veteran_list = list()

	for(var/line in world.file2list(VETERAN_PLAYERS_FILE_PATH))
		if(!line)
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		GLOB.veteran_list[ckey(line)] = TRUE // Associative so we can check it much faster


/datum/controller/subsystem/player_ranks/proc/save_veterans_legacy()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	var/veteran_list = ""
	for(var/veteran in GLOB.veteran_list)
		veteran_list += veteran + "\n"

	rustg_file_write(veteran_list, VETERAN_PLAYERS_FILE_PATH)


/datum/controller/subsystem/player_ranks/proc/load_player_ranks_sql(group_to_load)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	var/datum/db_query/query_load_player_ranks = SSdbcore.NewQuery(
		"SELECT ckey FROM [format_table_name(PLAYER_RANK_TABLE_NAME)] WHERE deleted = 0 AND rank = :rank",
		list("rank" = group_to_load),
	)

	switch(group_to_load)
		if(DONATOR_GROUP)
			load_donators_from_query(query_load_player_ranks)

		if(MENTOR_GROUP)
			load_mentors_from_query(query_load_player_ranks)

		if(VETERAN_GROUP)
			load_veterans_from_query(query_load_player_ranks)


/// Allows fetching the appropriate global list based on the `group_title`, for convenience.
/datum/controller/subsystem/player_ranks/proc/get_global_list_for_group(group_title)
	PROTECTED_PROC(TRUE)

	switch(group_title)
		if(DONATOR_GROUP)
			return GLOB.donator_list

		if(MENTOR_GROUP)
			return GLOB.mentor_datums

		if(VETERAN_GROUP)
			return GLOB.veteran_list

	return null


/datum/controller/subsystem/player_ranks/proc/load_donators_from_query(datum/db_query/query)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.donator_list = list()

	if(!query.Execute())
		return

	while(query.NextRow())
		var/ckey = ckey(query.item[INDEX_CKEY])
		GLOB.donator_list[ckey] = TRUE // Associative so we can check it much faster


/datum/controller/subsystem/player_ranks/proc/load_mentors_from_query(datum/db_query/query)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.mentor_datums.Cut()

	for(var/client/ex_mentor as anything in GLOB.mentors)
		ex_mentor.remove_mentor_verbs()
		ex_mentor.mentor_datum = null

	GLOB.mentors.Cut()

	if(!query.Execute())
		return

	while(query.NextRow())
		var/ckey = ckey(query.item[INDEX_CKEY])
		new /datum/mentors(ckey)


/datum/controller/subsystem/player_ranks/proc/load_veterans_from_query(datum/db_query/query)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.veteran_list = list()

	if(!query.Execute())
		return

	while(query.NextRow())
		var/ckey = ckey(query.item[INDEX_CKEY])
		GLOB.veteran_list[ckey] = TRUE // Associative so we can check it much faster


/**
 * Handles adding the ckey to the proper player rank group, either on the database
 * or in the legacy system.
 *
 * Arguments:
 * * admin - The admin making the rank change.
 * * ckey - The ckey of the player you want to now possess that player rank.
 * * group_title - The title of the group you want to add the ckey to.
 */
/datum/controller/subsystem/player_ranks/proc/add_player_to_group(client/admin, ckey, group_title)
	if(IsAdminAdvancedProcCall())
		return

	if(!ckey || !admin || !group_title)
		return

	if(!check_rights_for(admin, R_PERMISSIONS))
		to_chat(admin, span_warning("You do not possess the permissions to do this."))
		return

	ckey = ckey(ckey)

	for(var/group_member as anything in get_global_list_for_group(group_title))
		if(ckey == group_member)
			to_chat(admin, span_warning("\"[ckey]\" is already a [group_title]!"))
			return

	if(add_player_using_legacy_system(ckey, group_title))
		return

	add_player_rank_sql(ckey, group_title, admin.ckey)


/**
 * Handles calling the proper proc to add the player to the proper player rank
 * using the legacy system, if it should be doing that, based on the appropriate config.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now possess that player rank.
 * * group_title - The title of the group you want to add the ckey to.
 *
 * Returns `TRUE` if the operation went through using the legacy system, `FALSE` if not.
 */
/datum/controller/subsystem/player_ranks/proc/add_player_using_legacy_system(ckey, group_title)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	switch(group_title)
		if(DONATOR_GROUP)
			if(!CONFIG_GET(flag/donator_legacy_system))
				return FALSE

			add_donator_legacy(ckey)
			return TRUE

		if(MENTOR_GROUP)
			if(!CONFIG_GET(flag/mentor_legacy_system))
				return FALSE

			add_mentor_legacy(ckey)
			return TRUE

		if(VETERAN_GROUP)
			if(!CONFIG_GET(flag/veteran_legacy_system))
				return FALSE

			add_veteran_legacy(ckey)
			return TRUE

	return FALSE


/**
 * Handles adding the ckey to the appropriate player rank table on the database,
 * as well as in-game.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now possess that player rank.
 * * group_title - The title of the group you want to add the ckey to.
 * * admin_ckey - The ckey of the admin that made the rank change.
 */
/datum/controller/subsystem/player_ranks/proc/add_player_rank_sql(ckey, group_title, admin_ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	group_title = lowertext(group_title)

	var/datum/db_query/query_add_player_rank = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name(PLAYER_RANK_TABLE_NAME)] (ckey, rank, admin_ckey) VALUES(:ckey, :rank, :admin_ckey) \
		 ON DUPLICATE KEY UPDATE deleted = 0, admin_ckey = :admin_ckey",
		list("ckey" = ckey, "rank" = group_title, "admin_ckey" = admin_ckey),
	)

	if(!query_add_player_rank.warn_execute())
		return

	// message_admins("[admin_ckey] has granted [group_title] status to [ckey].")
	// log_admin_private("[admin_ckey] has granted [group_title] status to [ckey].")


/**
 * Handles adding a donator using the legacy system.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now be a donator.
 */
/datum/controller/subsystem/player_ranks/proc/add_donator_legacy(ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.donator_list[ckey] = TRUE
	text2file(ckey, DONATOR_FILE_PATH)


/**
 * Handles adding a mentor using the legacy system.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now be a mentor.
 */
/datum/controller/subsystem/player_ranks/proc/add_mentor_legacy(ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	new /datum/mentors(ckey)
	text2file(ckey, MENTOR_FILE_PATH)


/**
 * Handles adding a veteran using the legacy system.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now be a veteran.
 */
/datum/controller/subsystem/player_ranks/proc/add_veteran_legacy(ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.veteran_list[ckey] = TRUE
	text2file(ckey, VETERAN_PLAYERS_FILE_PATH)


/**
 * Handles removing the ckey from the proper player rank group, either on the database
 * or in the legacy system.
 *
 * Arguments:
 * * admin - The admin making the rank change.
 * * ckey - The ckey of the player you want to no longer possess that player rank.
 * * group_title - The title of the group you want to remove the ckey from.
 */
/datum/controller/subsystem/player_ranks/proc/remove_player_from_group(client/admin, ckey, group_title)
	if(IsAdminAdvancedProcCall())
		return

	if(!ckey || !admin || !group_title)
		return

	if(!check_rights_for(admin, R_PERMISSIONS))
		to_chat(admin, span_warning("You do not possess the permissions to do this."))
		return

	ckey = ckey(ckey)

	var/found_ckey = FALSE

	for(var/group_member as anything in get_global_list_for_group(group_title))
		if(ckey != group_member)
			continue

		found_ckey = TRUE
		break

	if(!found_ckey)
		to_chat(admin, span_warning("\"[ckey]\" is already not a [group_title]!"))
		return

	if(remove_player_using_legacy_system(ckey, group_title))
		return

	remove_player_rank_sql(ckey, group_title, admin.ckey)


/**
 * Handles calling the proper proc to remove the player from the proper player rank
 * using the legacy system, if it should be doing that, based on the appropriate config.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now possess that player rank.
 * * group_title - The title of the group you want to remove the ckey from.
 *
 * Returns `TRUE` if the operation went through using the legacy system, `FALSE` if not.
 */
/datum/controller/subsystem/player_ranks/proc/remove_player_using_legacy_system(ckey, group_title)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	switch(group_title)
		if(DONATOR_GROUP)
			if(!CONFIG_GET(flag/donator_legacy_system))
				return FALSE

			remove_donator_legacy(ckey)
			return TRUE

		if(MENTOR_GROUP)
			if(!CONFIG_GET(flag/mentor_legacy_system))
				return FALSE

			remove_mentor_legacy(ckey)
			return TRUE

		if(VETERAN_GROUP)
			if(!CONFIG_GET(flag/veteran_legacy_system))
				return FALSE

			remove_veteran_legacy(ckey)
			return TRUE

	return FALSE


/**
 * Handles removing the ckey from the appropriate player rank table on the database,
 * as well as in-game.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to no longer possess that player rank.
 * * group_title - The title of the group you want to remove the ckey from.
 * * admin_ckey - The ckey of the admin that made the rank change.
 */
/datum/controller/subsystem/player_ranks/proc/remove_player_rank_sql(ckey, group_title, admin_ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	group_title = lowertext(group_title)

	var/datum/db_query/query_remove_player_rank = SSdbcore.NewQuery(
		"UPDATE [format_table_name(PLAYER_RANK_TABLE_NAME)] SET deleted = 1, admin_ckey = :admin_ckey WHERE ckey = :ckey AND rank = :rank",
		list("ckey" = ckey, "rank" = group_title, "admin_ckey" = admin_ckey),
	)

	if(!query_remove_player_rank.warn_execute())
		return

	// message_admins("[admin_ckey] has granted [group_title] status to [ckey].")
	// log_admin_private("[admin_ckey] has granted [group_title] status to [ckey].")


/**
 * Handles removing a donator using the legacy system.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to no longer be a donator.
 */
/datum/controller/subsystem/player_ranks/proc/remove_donator_legacy(ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.donator_list -= ckey
	text2file(ckey, DONATOR_FILE_PATH)


/**
 * Handles removing a mentor using the legacy system.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to no longer be a mentor.
 */
/datum/controller/subsystem/player_ranks/proc/remove_mentor_legacy(ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	var/datum/mentors/mentor_datum = GLOB.mentor_datums[ckey]
	mentor_datum?.remove_mentor()
	save_mentors_legacy()


/**
 * Handles removing a veteran using the legacy system.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to no longer be a veteran.
 */
/datum/controller/subsystem/player_ranks/proc/remove_veteran_legacy(ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	GLOB.veteran_list -= ckey
	text2file(ckey, VETERAN_PLAYERS_FILE_PATH)


#undef DONATOR_GROUP
#undef MENTOR_GROUP
#undef VETERAN_GROUP

#undef PLAYER_RANK_TABLE_NAME

#undef INDEX_CKEY

#undef DONATOR_FILE_HEADER

#undef DONATOR_FILE_PATH
#undef MENTOR_FILE_PATH
#undef VETERAN_PLAYERS_FILE_PATH
