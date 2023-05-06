/// This logs subtler emotes in game.txt, if the conflig flag in config\skyrat\skyrat_config.txt is true.
/proc/log_subtler(text)
	if (CONFIG_GET(flag/log_subtler))
		WRITE_LOG(GLOB.world_game_log, "SUBTLER EMOTE: [text]")

/// This logs subtler emotes in game.txt, if the conflig flag in config\skyrat\skyrat_config.txt is true.
/proc/log_creator(text)
	WRITE_LOG(GLOB.character_creation_log, "CREATOR LOG: [text]")

/// Logging for borer evolutions
/proc/log_borer_evolution(text)
	if (CONFIG_GET(flag/log_uplink))
		WRITE_LOG(GLOB.world_uplink_log, "BORER EVOLUTION: [text]")
