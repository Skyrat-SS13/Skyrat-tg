// LOOC Module
GLOBAL_VAR_INIT(looc_allowed, TRUE)

/datum/config_entry/number/rockplanet_budget
	config_entry_value = 60
	integer = FALSE
	min_val = 0

/datum/config_entry/string/servertagline
	config_entry_value = "We forgot to set the server's tagline in config.txt"

/datum/config_entry/string/discord_link
	config_entry_value = "We forgot to set the server's discord link in config.txt"

/// Whether or not we log game logs to the SQL database. Requires the SQL database to function, as well as our Skyrat-only table, `game_log`.
/datum/config_entry/flag/sql_game_log
	protection = CONFIG_ENTRY_LOCKED

/// Whether or not we log game logs to files on the server when we're already logging them on the server, if SQL_GAME_LOG is enabled.
/datum/config_entry/flag/file_game_log
	protection = CONFIG_ENTRY_LOCKED

/// The minimum amount of entries there should be in the list of game logs for a mass query to be sent to the database.
/// Depends on SQL_GAME_LOG being enabled, doesn't mean anything otherwise.
/// Setting this to a value that's too low risks to severely affect perceptible performance, due to a high amount of
/// sleeps being involved with running queries.
/datum/config_entry/number/sql_game_log_min_bundle_size
	default = 100
	min_val = 1

/datum/config_entry/flag/events_use_random

/datum/config_entry/flag/events_public_voting

/datum/config_entry/flag/log_event_votes

/datum/config_entry/flag/low_chaos_event_system

/datum/config_entry/flag/allow_consecutive_catastropic_events

/datum/config_entry/number/event_frequency_upper
	default = 20 MINUTES

/datum/config_entry/number/event_frequency_lower
	default = 15 MINUTES

/datum/config_entry/flag/admin_event_uses_chaos

/// Ticket ping frequency. Set 0 for disable that subsystem. 3000 - 5 minutes, 600 - 1 minute.
/datum/config_entry/number/ticket_ping_frequency
