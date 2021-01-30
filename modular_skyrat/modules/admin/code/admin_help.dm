/datum/admin_help
	var/handler
	var/list/_interactions_player

//Let the initiator know their ahelp is being handled
/datum/admin_help/proc/HandleIssue(key_name = key_name_admin(usr))
	if(state != AHELP_ACTIVE)
		return

	//SKYRAT EDIT ADDITION BEGIN - ADMIN
	if(handler && handler != usr.ckey)
		var/response = alert(usr, "This ticket is already being handled by [handler]. Do you want to continue?", "Ticket already assigned", "Yes", "No")
		if(!response || response == "No")
			return
	//SKYRAT EDIT ADDITION END

	var/msg = "<span class ='adminhelp'>Your ticket is now being handled by [usr?.client?.holder?.fakekey? usr.client.holder.fakekey : "an administrator"]! Please wait while they type their response and/or gather relevant information.</span>"

	if(initiator)
		to_chat(initiator, msg)

	SSblackbox.record_feedback("tally", "ahelp_stats", 1, "handling")
	msg = "Ticket [TicketHref("#[id]")] is being handled by [key_name]"
	message_admins(msg)
	log_admin_private(msg)
	AddInteraction("Being handled by [key_name]")
	AddInteractionPlayer("Being handled by [key_name]")

	handler = "[usr.ckey]"

/datum/admin_help/proc/PlayerTicketPanel()
	var/list/dat = list("<html><head><meta http-equiv='Content-Type' content='text/html; charset=UTF-8'><title>Player Ticket</title></head>")
	var/ref_src = "[REF(src)]"
	dat += "<b>State: "
	switch(state)
		if(AHELP_ACTIVE)
			dat += "<font color='red'>OPEN</font>"
		if(AHELP_RESOLVED)
			dat += "<font color='green'>RESOLVED</font>"
		if(AHELP_CLOSED)
			dat += "CLOSED"
		else
			dat += "UNKNOWN"
	dat += "</b>[FOURSPACES][PlayerTicketHref("Refresh", ref_src)]"
	dat += "<br><br>Opened at: [gameTimestamp("hh:mm:ss", closed_at)] (Approx [DisplayTimeText(world.time - opened_at)] ago)"
	if(closed_at)
		dat += "<br>Closed at: [gameTimestamp("hh:mm:ss", closed_at)] (Approx [DisplayTimeText(world.time - closed_at)] ago)"
	dat += "<br><br>"
	dat += "<br><b>Log:</b><br><br>"
	for(var/I in _interactions_player)
		dat += "[I]<br>"

	usr << browse(dat.Join(), "window=ahelp[id];size=620x480")

/datum/admin_help/proc/PlayerTicketHref(msg, ref_src, action = "player_ticket")
	if(!ref_src)
		ref_src = "[REF(src)]"
	return "<A HREF='?_src_=holder;[HrefToken(TRUE)];ahelp_player=[ref_src];ahelp_action=[action]'>[msg]</A>"

/datum/admin_help/proc/AddInteractionPlayer(formatted_message)
	_interactions_player += "[time_stamp()]: [formatted_message]"
