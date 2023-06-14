/// This logs subtle emotes in game.log
/proc/log_subtle(text, list/data)
	logger.Log(LOG_CATEGORY_GAME_SUBTLE, text, data)

/// This logs subtler emotes in game.log, if the conflig flag in config\skyrat\skyrat_config.txt is true.
/proc/log_subtler(text, list/data)
	logger.Log(LOG_CATEGORY_GAME_SUBTLER, text, data)

/// This logs character creator changes in debug.log
/proc/log_creator(text, list/data)
	logger.Log(LOG_CATEGORY_DEBUG_CHARACTER_CREATOR, text, data)

/// Logging for borer evolutions
/proc/log_borer_evolution(text, list/data)
	logger.Log(LOG_CATEGORY_UPLINK_BORER, text, data)
