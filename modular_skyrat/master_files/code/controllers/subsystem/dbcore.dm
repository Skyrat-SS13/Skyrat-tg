/datum/controller/subsystem/dbcore
	/// An associative list of list of rows to add to a database table with the name of the target table as a key.
	/// Used to queue up log entries for bigger queries that happen less often, to reduce the strain on the server caused by
	/// hundreds of additional queries constantly trying to run.
	var/list/queued_log_entries_by_table = list()


/**
 * This is a proc to hopefully mitigate the effect of a large influx of queries needing to be created
 * for something like SQL-based game logs. The goal here is to bundle a certain amount of those log
 * entries together (default is 100, but it depends on the `SQL_GAME_LOG_MIN_BUNDLE_SIZE` config
 * entry) before sending them, so that we can massively reduce the amount of lag associated with
 * logging so many entries to the database.
 *
 * Arguments:
 * * table - The name of the table to insert the log enty into.
 * * log_entry - Associative list representing all of the information that needs to be logged.
 * Default format is as follows, for the `game_log` table (even if this could be used for another table):
 * 	list(
 * 		"datetime" = SQLtime(),
 * 		"round_id" = "[GLOB.round_id]",
 * 		"ckey" = key_name(src),
 * 		"loc" = loc_name(src),
 * 		"type" = message_type,
 * 		"message" = message,
 * 	)
 * Take a look at `/atom/proc/log_message()` for an example of implementation.
 */
/datum/controller/subsystem/dbcore/proc/add_log_to_mass_insert_queue(table, log_entry)
	if(IsAdminAdvancedProcCall())
		return

	if(!queued_log_entries_by_table[table])
		queued_log_entries_by_table[table] = list()

	queued_log_entries_by_table[table] += list(log_entry)

	if(length(queued_log_entries_by_table[table]) < CONFIG_GET(number/sql_game_log_min_bundle_size))
		return

	INVOKE_ASYNC(src, .proc/MassInsert, table, /*rows =*/ queued_log_entries_by_table[table], /*duplicate_key =*/ FALSE, /*ignore_errors =*/ FALSE, /*delayed =*/ FALSE, /*warn =*/ FALSE, /*async =*/ TRUE, /*special_columns =*/ null)
	queued_log_entries_by_table -= table
