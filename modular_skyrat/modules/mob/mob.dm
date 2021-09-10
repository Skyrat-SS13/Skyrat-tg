#define COMSIG_MOB_KEY_CHANGE "mob_key_change"					//from base of /mob/transfer_ckey(): (new_character, old_character)
#define COMSIG_MOB_PRE_PLAYER_CHANGE "mob_pre_player_change"



/mob/proc/transfer_ckey(mob/new_mob, send_signal = TRUE)
	if(!new_mob || (!ckey && new_mob.ckey))
		CRASH("transfer_ckey() called [new_mob ? "on ckey-less mob with a player mob as target" : "without a valid mob target"]!")
	if(!ckey)
		return
	SEND_SIGNAL(new_mob, COMSIG_MOB_PRE_PLAYER_CHANGE, new_mob, src)
	// if (client)
	// 	if(client.prefs?.auto_ooc)
	// 		if (client.prefs.chat_toggles & CHAT_OOC && isliving(new_mob))
	// 			client.prefs.chat_toggles ^= CHAT_OOC
	// 		if (!(client.prefs.chat_toggles & CHAT_OOC) && isdead(new_mob))
	// 			client.prefs.chat_toggles ^= CHAT_OOC
	new_mob.ckey = ckey
	if(send_signal)
		SEND_SIGNAL(src, COMSIG_MOB_KEY_CHANGE, new_mob, src)
	return TRUE
