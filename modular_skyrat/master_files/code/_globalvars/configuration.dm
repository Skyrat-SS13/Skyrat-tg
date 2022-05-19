//LOOC Module
GLOBAL_VAR_INIT(looc_allowed, TRUE)

/datum/config_entry/number/rockplanet_budget
	config_entry_value = 60
	integer = FALSE
	min_val = 0

/datum/config_entry/string/servertagline
	config_entry_value = "We forgot to set the server's tagline in config.txt"

/datum/config_entry/string/discord_link
	config_entry_value = "We forgot to set the server's discord link in config.txt"

/datum/config_entry/flag/sql_game_log
	protection = CONFIG_ENTRY_LOCKED

/datum/config_entry/flag/file_game_log
	protection = CONFIG_ENTRY_LOCKED

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
