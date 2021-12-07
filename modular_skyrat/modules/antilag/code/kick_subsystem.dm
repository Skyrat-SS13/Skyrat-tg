SUBSYSTEM_DEF(autockick)
	name = "Autokick"
	init_order = INIT_ORDER_TIMER
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME
	wait = DEFAULT_AUTOKICK_SS_WAIT

	/// A list of clients we have been handed to check for lobby autokicking.
	var/list/clients_to_check_lobby = list()

/datum/controller/subsystem/autockick/stat_entry(msg)
	msg += "|CHK:[clients_to_check_lobby.len]|TIME:[next_fire - world.time]"
	return ..()

/datum/controller/subsystem/autockick/fire(resumed)
	var/list/kicked_lobby = list()
	var/list/kicked_ghosts = list()
	var/list/kicked_clients = list()
	remove_nulls_from_list(clients_to_check_lobby)
	var/severity = AUTOKICK_SEVERITY_NORMAL
	if(TGS_CLIENT_COUNT >= PERFORMANCE_THRESHOLD_CRITICAL) // Kicking any and all AFK clients.
		severity = AUTOKICK_SEVERITY_CRITICAL
	else if(TGS_CLIENT_COUNT >= PERFORMANCE_THRESHOLD_MODERATE) // Kicking AFK ghosts.
		severity = AUTOKICK_SEVERITY_MODERATE

	message_admins("AUTOKICK: Running AFK check... Population: [TGS_CLIENT_COUNT] | PRIORITY: [severity]")
	for(var/client/iterating_client as anything in GLOB.clients) //Copied code is there for performance, why run two for loops when we can run one?
		if(!iterating_client)
			continue
		if((iterating_client in clients_to_check_lobby) && isnewplayer(iterating_client.mob))
			clients_to_check_lobby -= iterating_client
			to_chat_immediate(iterating_client, "As you have not joined the game, you have been kicked.")
			qdel(iterating_client)
			continue
		if(iterating_client.is_afk())
			switch(severity)
				if(AUTOKICK_SEVERITY_CRITICAL)
					kicked_clients += "[iterating_client.key]"
					kick_player(iterating_client)
					continue
				if(AUTOKICK_SEVERITY_MODERATE)
					if(isobserver(iterating_client.mob))
						kicked_ghosts += "[iterating_client.key]"
						kick_player(iterating_client)
						continue
					if(isnewplayer(iterating_client.mob)) // Kicking anyone in the lobby.
						kicked_lobby += "[iterating_client.key]"
						kick_player(iterating_client)
						continue
				if(AUTOKICK_SEVERITY_NORMAL)
					if(isnewplayer(iterating_client.mob)) // Kicking anyone in the lobby.
						kicked_lobby += "[iterating_client.key]"
						kick_player(iterating_client)
						continue
		if(MC_TICK_CHECK)
			message_admins("AUTOKICK: MC check failed, aborting.")
			return
	var/total = kicked_lobby.len + kicked_ghosts.len + kicked_clients.len
	message_admins("AUTOKICK: Kicked [total] total clients | Lobby: [kicked_lobby.len] | Ghosts: [kicked_ghosts.len] | Clients: [kicked_clients.len]")

/datum/controller/subsystem/autockick/proc/kick_player(client/client_to_kick)
	to_chat_immediate(client_to_kick, "You have been kicked for being AFK.")
	qdel(client_to_kick)
