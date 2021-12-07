/client/proc/kick_afk()
	set category = "Admin"
	set name = "Kick ALL AFK Clients"
	set desc = "Kicks all clients who are AFK, both ingame and in the lobby."

	var/kick_type_choice = tgui_alert("Do you want to kick all AFK clients, or only those observing or in the lobby?", "All of them", "Only those in the lobby/observing", "Cancel")

	if(!kick_type_choice || kick_type_choice == "Cancel")
		return

	var/list/kicked_client_names = list()

	if(kick_type_choice == "All of them")
		for(var/client/iterating_client as anything in GLOB.clients)
			if(!iterating_client)
				continue
			if(is_admin(iterating_client))
				continue
			if(iterating_client.is_afk())
				to_chat_immediate(iterating_client, "You have been kicked for being AFK.")
				kicked_client_names.Add("[iterating_client.key]")
				qdel(iterating_client)
		message_admins("[key_name(usr)] has kicked ALL AFK clients. Kicked [length(kicked_client_names)] players.")
	else
		for(var/client/iterating_client as anything in GLOB.clients)
			if(!iterating_client)
				continue
			if(iterating_client.is_afk() && isnewplayer(iterating_client.mob) || isobserver(iterating_client.mob))
				to_chat_immediate(iterating_client, "You have been kicked for being AFK.")
				kicked_client_names.Add("[iterating_client.key]")
				qdel(iterating_client)
		message_admins("[key_name(usr)] has kicked all AFK clients in the lobby/observing. Kicked [length(kicked_client_names)] players.")

	to_chat(usr, span_admin("Total kicked clients: [length(kicked_client_names)] | Kicked clients: " + kicked_client_names.Join(", ")))

/client/proc/move_ghost_to_lobby()
	set category = "Admin"
	set name = "Move ghosts to lobby"
	set desc = "Moves any ghosts to the lobby."

	if(GLOB.clients.len < 150)
		to_chat(usr, span_danger("There are not enough players to move ghosts to the lobby."))
		return

	var/choice = tgui_alert("Are you sure you want to move all ghosts to the lobby?", "Yes", "No")

	if(!choice || choice == "No")
		return

	var/list/ghost_client_names = list()

	for(var/client/iterating_client as anything in GLOB.clients)
		if(!iterating_client)
			continue
		if(is_admin(iterating_client))
			continue
		if(isobserver(iterating_client.mob))
			to_chat(iterating_client, span_danger("You have been moved to the lobby, either join a game or disconnect. You will shortly be kicked."))
			SSautockick.clients_to_check_lobby.Add(iterating_client)
			var/mob/dead/new_player/new_player = new()
			new_player.ckey = iterating_client.ckey
			ghost_client_names.Add("[iterating_client.key]")
			qdel(iterating_client.mob)

	message_admins("[key_name(usr)] has moved [ghost_client_names.len] ghosts to the lobby.")

	to_chat(usr, span_admin("Total moved observers: [ghost_client_names.len] | Moved observers: " + ghost_client_names.Join(", ")))
