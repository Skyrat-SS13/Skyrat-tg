/**
 * This proc is designed to be lightweight and straight forward, clients are finicky and joining all the time.
 * FALSE = Deny connection
 * True = Confirm connection
 */
/client/proc/check_population(connecting_admin = FALSE)
	if(connecting_admin)
		return TRUE //We allow admins to pass freeeeeeeely

	var/population = TGS_CLIENT_COUNT
	var/player_cap = CONFIG_GET(number/player_hard_cap)

	if(player_cap && population >= player_cap)
		var/overflow_server_ip = CONFIG_GET(string/overflow_server_ip)
		if(!overflow_server_ip)
			message_admins("WARNING: Overflow server IP not set!")
			return TRUE
		to_chat_immediate(src, span_boldwarning("The round is full, please wait while you are transferred to the secondary server..."))
		message_admins("[src] attempted to join, but the server was full and were sent to the secondary server.")
		src << link(overflow_server_ip)
		return FALSE
	return TRUE

/mob/dead/new_player/proc/connect_to_second_server()
	var/choice = tgui_alert(src, "The server is currently experiencing high demand, please consider joining our secondary server.", "High Demand", list("Stay here", "Connect me!"))
	if(!client)
		return
	if(choice != "Send me there")
		return
	to_chat(client, span_notice("So long, spaceman."))
	var/overflow_server_ip = CONFIG_GET(string/overflow_server_ip)
	if(!overflow_server_ip)
		message_admins("WARNING: Overflow server IP not set!")
		return
	client << link(overflow_server_ip)

