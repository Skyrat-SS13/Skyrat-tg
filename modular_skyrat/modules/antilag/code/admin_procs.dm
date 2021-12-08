/client/proc/kick_afk()
	set category = "Admin"
	set name = "Kick ALL AFK Clients"
	set desc = "Kicks all clients who are AFK, both ingame and in the lobby."

	var/kick_type_choice = tgui_alert(usr, "Do you want to kick all AFK clients, or only those observing or in the lobby?", "Kick who?", list("All of them", "Only those in the lobby/observing", "Cancel"))

	if(!kick_type_choice || kick_type_choice == "Cancel")
		return

	var/list/kicked_client_names = list()

	if(kick_type_choice == "All of them")
		for(var/client/iterating_client as anything in GLOB.clients)
			if(!iterating_client)
				continue
			if(is_admin(iterating_client))
				continue
			if(iterating_client?.is_afk())
				to_chat_immediate(iterating_client, "You have been kicked for being AFK.")
				kicked_client_names.Add("[iterating_client.key]")
				qdel(iterating_client)
		message_admins("[key_name(usr)] has kicked ALL AFK clients. Kicked [length(kicked_client_names)] players.")
		log_admin("[key_name(usr)] has kicked ALL AFK clients. Kicked [length(kicked_client_names)] players.")
	else
		for(var/client/iterating_client as anything in GLOB.clients)
			if(!iterating_client)
				continue
			if(iterating_client?.is_afk() && (isnewplayer(iterating_client.mob) || isobserver(iterating_client.mob)))
				to_chat_immediate(iterating_client, "You have been kicked for being AFK.")
				kicked_client_names.Add("[iterating_client.key]")
				qdel(iterating_client)
		message_admins("[key_name(usr)] has kicked all AFK clients in the lobby/observing. Kicked [length(kicked_client_names)] players.")
		log_admin("[key_name(usr)] has kicked all AFK clients in the lobby/observing. Kicked [length(kicked_client_names)] players.")

	to_chat(usr, span_admin("Total kicked clients: [length(kicked_client_names)] | Kicked clients: " + kicked_client_names.Join(", ")))

/client/proc/move_ghost_to_lobby()
	set category = "Admin"
	set name = "Notify ghost/lobby overpopulation"
	set desc = "Notify ghosts/lobbiers to join the game or leave, autokick if they do not."

	var/choice = tgui_alert(usr, "Are you sure you want to notify all current ghosts/new players that they will be kicked soon?", "Notify kick", list("Yes", "No"))

	if(!(choice == "Yes"))
		return

	var/list/ghost_client_names = list()

	for(var/client/iterating_client as anything in GLOB.clients)
		if(!iterating_client)
			continue
		if(is_admin(iterating_client))
			continue
		if(isobserver(iterating_client?.mob) || isnewplayer(iterating_client?.mob))
			to_chat(iterating_client, span_userdanger("The server is currently expereincing extreme load, please join the game or leave. You will shortly be kicked."))
			SSautokick.clients_to_check_lobby.Add(iterating_client)

	message_admins("[key_name(usr)] has set autokick for [length(ghost_client_names)] new players and ghosts.")
	log_admin("[key_name(usr)] has set autokick for [length(ghost_client_names)] new players and ghosts.")

	to_chat(usr, span_admin("Total autokick tagged clients: [length(ghost_client_names)] | Tagged clients: " + ghost_client_names.Join(", ")))
