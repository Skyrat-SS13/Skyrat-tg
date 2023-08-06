/// The name of the table on the database containing the player ranks.
/// See `skyrat_schema.sql` for the schema of the table.
#define PLAYER_RANK_TABLE_NAME "player_rank"


SUBSYSTEM_DEF(player_ranks)
	name = "Player Ranks"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_PLAYER_RANKS
	// The following controllers handle most of the legacy system's functions,
	// and provide a layer of abstraction for this subsystem to have cleaner
	// logic.
	/// The donator player rank controller.
	var/datum/player_rank_controller/donator/donator_controller
	/// The mentor player rank controller.
	var/datum/player_rank_controller/mentor/mentor_controller
	/// The veteran player rank controller.
	var/datum/player_rank_controller/veteran/veteran_controller


/datum/controller/subsystem/player_ranks/Initialize()
	if(IsAdminAdvancedProcCall())
		return

	load_donators()
	load_mentors()
	load_veterans()

	return SS_INIT_SUCCESS


/datum/controller/subsystem/player_ranks/Destroy()
	. = ..()

	QDEL_NULL(donator_controller)
	QDEL_NULL(mentor_controller)
	QDEL_NULL(veteran_controller)


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

	donator_controller = new

	if(CONFIG_GET(flag/donator_legacy_system))
		donator_controller.load_legacy()
		return

	if(!SSdbcore.Connect())
		var/message = "Failed to connect to database in load_donators(). Reverting to legacy system."
		log_config(message)
		log_game(message)
		message_admins(message)
		CONFIG_SET(flag/donator_legacy_system, TRUE)
		donator_controller.load_legacy()
		return

	load_player_rank_sql(donator_controller)


/// Handles loading mentors either via SQL or using the legacy system,
/// based on configs.
/datum/controller/subsystem/player_ranks/proc/load_mentors()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	mentor_controller = new

	if(CONFIG_GET(flag/mentor_legacy_system))
		mentor_controller.load_legacy()
		return

	if(!SSdbcore.Connect())
		var/message = "Failed to connect to database in load_mentors(). Reverting to legacy system."
		log_config(message)
		log_game(message)
		message_admins(message)
		CONFIG_SET(flag/mentor_legacy_system, TRUE)
		mentor_controller.load_legacy()
		return

	load_player_rank_sql(mentor_controller)


/// Handles loading veteran players either via SQL or using the legacy system,
/// based on configs.
/datum/controller/subsystem/player_ranks/proc/load_veterans()
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	veteran_controller = new

	if(CONFIG_GET(flag/veteran_legacy_system))
		veteran_controller.load_legacy()
		return

	if(!SSdbcore.Connect())
		var/message = "Failed to connect to database in load_veterans(). Reverting to legacy system."
		log_config(message)
		log_game(message)
		message_admins(message)
		CONFIG_SET(flag/veteran_legacy_system, TRUE)
		veteran_controller.load_legacy()
		return

	load_player_rank_sql(veteran_controller)


/**
 * Handles populating the player rank from the database, 
 */
/datum/controller/subsystem/player_ranks/proc/load_player_rank_sql(datum/player_rank_controller/rank_controller)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	var/datum/db_query/query_load_player_rank = SSdbcore.NewQuery(
		"SELECT ckey FROM [format_table_name(PLAYER_RANK_TABLE_NAME)] WHERE deleted = 0 AND rank = :rank",
		list("rank" = rank_controller.rank_title),
	)

	if(!query_load_player_rank.warn_execute())
		return

	rank_controller.load_from_query(query_load_player_rank)


/// Allows fetching the appropriate player_rank_controller based on its
/// `rank_title`, for convenience.
/datum/controller/subsystem/player_ranks/proc/get_controller_for_group(rank_title)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return null

	// Can't make switch() statements with non-constant values.
	if(rank_title == donator_controller.rank_title)
		return donator_controller

	if(rank_title == mentor_controller.rank_title)
		return mentor_controller

	if(rank_title == veteran_controller.rank_title)
		return veteran_controller

	return null


/**
 * Handles adding the ckey to the proper player rank group, either on the database
 * or in the legacy system.
 *
 * Arguments:
 * * admin - The admin making the rank change.
 * * ckey - The ckey of the player you want to now possess that player rank.
 * * rank_title - The title of the group you want to add the ckey to.
 */
/datum/controller/subsystem/player_ranks/proc/add_player_to_group(client/admin, ckey, rank_title)
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(!ckey || !admin || !rank_title)
		return FALSE

	if(!check_rights_for(admin, R_PERMISSIONS))
		to_chat(admin, span_warning("You do not possess the permissions to do this."))
		return FALSE

	rank_title = lowertext(rank_title)

	var/datum/player_rank_controller/controller = get_controller_for_group(rank_title)

	if(!controller)
		stack_trace("Invalid player rank \"[rank_title]\" supplied in add_player_to_group()!")
		return FALSE

	ckey = ckey(ckey)

	var/already_in_config = controller.get_ckeys_for_legacy_save()

	if(already_in_config[ckey])
		to_chat(admin, span_warning("\"[ckey]\" is already a [rank_title]!"))
		return FALSE

	if(controller.should_use_legacy_system())
		controller.add_player_legacy(ckey)
		return TRUE

	return add_player_rank_sql(controller, ckey, admin.ckey)


/**
 * Handles adding the ckey to the appropriate player rank table on the database,
 * as well as in-game.
 *
 * Arguments:
 * * controller - The controller of the player rank you want to add the ckey to.
 * * ckey - The ckey of the player you want to now possess that player rank.
 * * admin_ckey - The ckey of the admin that made the rank change.
 */
/datum/controller/subsystem/player_ranks/proc/add_player_rank_sql(datum/player_rank_controller/controller, ckey, admin_ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return FALSE

	var/datum/db_query/query_add_player_rank = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name(PLAYER_RANK_TABLE_NAME)] (ckey, rank, admin_ckey) VALUES(:ckey, :rank, :admin_ckey) \
		 ON DUPLICATE KEY UPDATE deleted = 0, admin_ckey = :admin_ckey",
		list("ckey" = ckey, "rank" = controller.rank_title, "admin_ckey" = admin_ckey),
	)

	if(!query_add_player_rank.warn_execute())
		return FALSE

	controller.add_player(ckey)
	return TRUE


/**
 * Handles removing the ckey from the proper player rank group, either on the database
 * or in the legacy system.
 *
 * Arguments:
 * * admin - The admin making the rank change.
 * * ckey - The ckey of the player you want to no longer possess that player rank.
 * * rank_title - The title of the group you want to remove the ckey from.
 */
/datum/controller/subsystem/player_ranks/proc/remove_player_from_group(client/admin, ckey, rank_title)
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(!ckey || !admin || !rank_title)
		return FALSE

	if(!check_rights_for(admin, R_PERMISSIONS))
		to_chat(admin, span_warning("You do not possess the permissions to do this."))
		return FALSE

	rank_title = lowertext(rank_title)

	var/datum/player_rank_controller/controller = get_controller_for_group(rank_title)

	if(!controller)
		stack_trace("Invalid player rank \"[rank_title]\" supplied in add_player_to_group()!")
		return FALSE

	ckey = ckey(ckey)

	var/already_in_config = controller.get_ckeys_for_legacy_save()

	if(!already_in_config[ckey])
		to_chat(admin, span_warning("\"[ckey]\" is already not a [rank_title]!"))
		return FALSE

	if(controller.should_use_legacy_system())
		controller.remove_player_legacy(ckey)
		return TRUE

	return remove_player_rank_sql(controller, ckey, admin.ckey)


/**
 * Handles removing the ckey from the appropriate player rank table on the database,
 * as well as in-game.
 *
 * Arguments:
 * * controller - The controller of the player rank you want to remove the ckey from.
 * * ckey - The ckey of the player you want to no longer possess that player rank.
 * * admin_ckey - The ckey of the admin that made the rank change.
 */
/datum/controller/subsystem/player_ranks/proc/remove_player_rank_sql(datum/player_rank_controller/controller, ckey, admin_ckey)
	PROTECTED_PROC(TRUE)

	if(IsAdminAdvancedProcCall())
		return FALSE

	var/datum/db_query/query_remove_player_rank = SSdbcore.NewQuery(
		"UPDATE [format_table_name(PLAYER_RANK_TABLE_NAME)] SET deleted = 1, admin_ckey = :admin_ckey WHERE ckey = :ckey AND rank = :rank",
		list("ckey" = ckey, "rank" = controller.rank_title, "admin_ckey" = admin_ckey),
	)

	if(!query_remove_player_rank.warn_execute())
		return FALSE

	controller.remove_player(ckey)
	return TRUE


#undef PLAYER_RANK_TABLE_NAME
