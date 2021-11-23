
//This logs subtler emotes in game.txt, if the conflig flag in config\skyrat\skyrat_config.txt is true.
/proc/log_subtler(text)
	if (CONFIG_GET(flag/log_subtler))
		WRITE_LOG(GLOB.world_game_log, "SUBTLER EMOTE: [text]")

/proc/log_ambition(text)
	if(CONFIG_GET(flag/log_ambition))
		WRITE_LOG(GLOB.world_game_log, "AMBITION: [text]")
