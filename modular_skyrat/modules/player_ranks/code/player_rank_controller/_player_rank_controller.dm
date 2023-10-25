/// The index of the ckey in the items of a given row in a query for player ranks.
#define INDEX_CKEY 1

/**
 * This datum is intended to be used as a method of abstraction for the different
 * ways that each player rank handles adding and removing players from their global
 * lists, as well as handling the legacy adding, removing, loading and saving of
 * said lists.
 */
/datum/player_rank_controller
	/// The name of the player rank in the database.
	/// This **NEEDS** to be set by subtypes, otherwise you WILL run into severe
	/// issues.
	var/rank_title = null
	/// The path to the legacy file holding all of the players that have this rank.
	/// Should be set in `New()`, since it has a non-constant compile-time value.
	var/legacy_file_path = null
	/// The header for the legacy file, if any.
	/// Leave as `""` if you don't have one.
	var/legacy_file_header = ""


/datum/player_rank_controller/vv_edit_var(var_name, var_value)
	// No touching the controller's vars, treat these as protected config.
	return FALSE


/**
 * Handles adding this rank to a player by their ckey. This is only intended to
 * be used for handling the in-game portion of adding this rank, and not to
 * save this change anywhere. That should be handled by the caller.
 *
 * DO NOT FORGET TO ADD A `IsAdminAdvancedProcCall()` CHECK SO THAT ADMINS
 * CAN'T JUST USE THAT TO SKIP PERMISSION CHECKS!!!
 */
/datum/player_rank_controller/proc/add_player(ckey)
	SHOULD_CALL_PARENT(FALSE)

	CRASH("[src] did not implement add_player()! Fix this ASAP!")


/**
 * Handles adding this rank to a player using the legacy system, updating the
 * legacy config file in the process.
 *
 * Don't override this, everything should be handled from `add_player()`,
 * this is mostly just a helper for convenience.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now possess this player rank.
 */
/datum/player_rank_controller/proc/add_player_legacy(ckey)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	add_player(ckey)
	text2file(ckey, legacy_file_path)


/**
 * Handles removing this rank from a player by their ckey. This is only
 * intended to be used for handling the in-game portion of removing this rank,
 * and not to save this change anywhere. That should be handled by the caller.
 *
 * DO NOT FORGET TO ADD A `IsAdminAdvancedProcCall()` CHECK SO THAT ADMINS
 * CAN'T JUST USE THAT TO SKIP PERMISSION CHECKS!!!
 */
/datum/player_rank_controller/proc/remove_player(ckey)
	SHOULD_CALL_PARENT(FALSE)

	CRASH("[src] did not implement remove_player()! Fix this ASAP!")


/**
 * Handles removing this rank from a player using the legacy system, updating
 * the legacy config file in the process.
 *
 * Don't override this, everything should be handled from `remove_player()`
 * and `save_legacy()`, this is mostly just a helper for convenience.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to no longer possess this player
 * rank.
 */
/datum/player_rank_controller/proc/remove_player_legacy(ckey)
	SHOULD_NOT_OVERRIDE(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	remove_player(ckey)
	// We have to save like this, because we're taking something out at an
	// arbitrary point in the list.
	save_legacy()


/**
 * Handles loading the players that have this rank from an already-executed
 * database query.
 *
 * Mostly just a helper to simplify the logic of the subsystem.
 */
/datum/player_rank_controller/proc/load_from_query(datum/db_query/query)
	if(IsAdminAdvancedProcCall())
		return

	clear_existing_rank_data()

	while(query.NextRow())
		var/ckey = ckey(query.item[INDEX_CKEY])
		add_player(ckey)


/**
 * Handles loading the players that have this rank from its legacy config file.
 *
 * Don't override this, use `clear_existing_rank_data()` to clear up anything
 * that needs to be cleared/initialized before loading the rank, and
 * `add_player()` for actually giving the rank to the ckey in-game.
 */
/datum/player_rank_controller/proc/load_legacy()
	SHOULD_NOT_OVERRIDE(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	clear_existing_rank_data()

	for(var/line in world.file2list(legacy_file_path))
		if(!line)
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		add_player(line)

	return TRUE


/**
 * Handles saving the players that have this rank using its legacy config file.
 *
 * Don't override this, use `get_ckeys_for_legacy_save()` if you need to filter
 * the list of ckeys that will get saved.
 */
/datum/player_rank_controller/proc/save_legacy()
	SHOULD_NOT_OVERRIDE(TRUE)

	if(IsAdminAdvancedProcCall())
		return

	var/save_file_contents = legacy_file_header

	for(var/player in get_ckeys_for_legacy_save())
		save_file_contents += player + "\n"

	rustg_file_write(save_file_contents, legacy_file_path)


/**
 * Handles returning a list of all the legacy ckeys that should be migrated
 * from the legacy system to the database one.
 *
 * Returns a list of ckeys as strings.
 */
/datum/player_rank_controller/proc/get_ckeys_to_migrate()
	SHOULD_NOT_OVERRIDE(TRUE)
	RETURN_TYPE(/list)

	var/list/ckeys_to_migrate = list()

	for(var/line in world.file2list(legacy_file_path))
		if(!line)
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		var/to_migrate = ckey(line)

		if(!to_migrate)
			continue

		ckeys_to_migrate += to_migrate

	return ckeys_to_migrate


/**
 * Simple proc for subtypes to override for their own handling of obtaining
 * a list of ckeys to save during a legacy save.
 *
 * DO NOT FORGET TO ADD A `IsAdminAdvancedProcCall()` CHECK SO THAT ADMINS
 * CAN'T JUST ELEVATE PERMISSIONS TO ADD THEMSELVES TO A LEGACY SAVE!!!
 */
/datum/player_rank_controller/proc/get_ckeys_for_legacy_save()
	SHOULD_CALL_PARENT(FALSE)
	RETURN_TYPE(/list)

	CRASH("[src] did not implement get_ckeys_for_legacy_save()! Fix this ASAP!")


/datum/player_rank_controller/proc/should_use_legacy_system()
	SHOULD_CALL_PARENT(FALSE)
	. = TRUE

	stack_trace("[src] did not implement should_use_legacy_system(), defaulting to TRUE! Fix this ASAP!")


/**
 * Simple proc for subtypes to override for their own handling of clearing any
 * lists that need to be cleared before loading the player rank data.
 *
 * DO NOT FORGET TO ADD A `IsAdminAdvancedProcCall()` CHECK SO THAT ADMINS
 * CAN'T JUST ELEVATE PERMISSIONS TO CLEAR RANK DATA AND SCREW YOU OVER!!!
 */
/datum/player_rank_controller/proc/clear_existing_rank_data()
	SHOULD_CALL_PARENT(FALSE)
	PROTECTED_PROC(TRUE)

	CRASH("[src] did not implement clear_existing_rank_data()! Fix this ASAP!")


#undef INDEX_CKEY
