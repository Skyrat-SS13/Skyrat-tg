
// Sends an OOC message to all dem other servers!
/proc/send_ooc_to_other_server(exp_name, message)
	if(!CONFIG_GET(flag/enable_cross_server_ooc))
		return FALSE
	var/list/ooc_information = list()
	ooc_information["server_name"] = CONFIG_GET(string/cross_server_name) ? CONFIG_GET(string/cross_server_name) : station_name()
	ooc_information["expected_name"] = exp_name
	send2otherserver(source = html_decode(ooc_information["server_name"]), msg = message, type = "incoming_ooc_message", additional_data = ooc_information)
	return TRUE

/datum/world_topic/incoming_ooc_message
	keyword = "incoming_ooc_message"
	require_comms_key = TRUE

/datum/world_topic/incoming_ooc_message/Run(list/input)
	if(!CONFIG_GET(flag/enable_cross_server_ooc))
		return FALSE
	var/server_name = input["server_name"]
	var/exp_name = input["expected_name"]
	var/message = input["message"]

	send_ooc_message(exp_name, server_name, message)

/proc/send_ooc_message(sender_name, server_name, message)
	if(!GLOB.ooc_allowed)
		return
	for(var/client/C in GLOB.clients)
		if(C.prefs.chat_toggles & CHAT_OOC)
			to_chat(C, span_crossooc("[span_prefix("CROSSLINK-OOC([server_name]):")] <EM>[sender_name]:</EM> <span class='message linkify'>[message]</span></b>"), type = MESSAGE_TYPE_OOC)


// Sends an asay message to all deh other servers!
/proc/send_asay_to_other_server(exp_name, message)
	if(!CONFIG_GET(flag/enable_cross_server_asay))
		return
	var/list/asay_information = list()
	asay_information["server_name"] = CONFIG_GET(string/cross_server_name) ? CONFIG_GET(string/cross_server_name) : station_name()
	asay_information["expected_name"] = exp_name
	send2otherserver(source = html_decode(asay_information["server_name"]), msg = message, type = "incoming_asay_message", additional_data = asay_information)
	return TRUE

/datum/world_topic/incoming_asay_message
	keyword = "incoming_asay_message"
	require_comms_key = TRUE

/datum/world_topic/incoming_asay_message/Run(list/input)
	if(!CONFIG_GET(flag/enable_cross_server_asay))
		return
	var/server_name = input["server_name"]
	var/exp_name = input["expected_name"]
	var/message = input["message"]

	send_asay_message(exp_name, server_name, message)

/proc/send_asay_message(sender_name, server_name, message)
	var/msg = "[span_adminsay("[span_crossasay("CROSSLINK-ASAY")]([server_name]): <EM>[sender_name]</EM>: <span class='message linkify'>[message]")]</span>"
	to_chat(GLOB.admins,
		type = MESSAGE_TYPE_ADMINCHAT,
		html = msg,
		confidential = TRUE)

/client/proc/request_help()
	set category = "Admin"
	set name = "Cross-server Help Request"
	set desc = "Sends a loud message to all other servers that we are crosslinked to!"

	var/help_request_message = tgui_input_text(src, "Input help message!", "Help message", "Send help!", 150, FALSE)
	if(!help_request_message)
		return
	send2adminchat(ckey, "CROSSLINK HELP REQUEST([CONFIG_GET(string/cross_server_name) ? CONFIG_GET(string/cross_server_name) : station_name()]): [help_request_message]")
	send_help_request_to_other_server(ckey, help_request_message)

	message_admins("[ADMIN_LOOKUPFLW(usr)] sent out a cross-server help request with the message: [help_request_message].")
	log_admin("[key_name(usr)] sent cross-server help request [help_request_message].")

// Oh no, they need help!
/proc/send_help_request_to_other_server(exp_name, message)
	if(!CONFIG_GET(flag/enable_cross_server_asay))
		return
	var/list/asay_information = list()
	asay_information["server_name"] = CONFIG_GET(string/cross_server_name) ? CONFIG_GET(string/cross_server_name) : station_name()
	asay_information["expected_name"] = exp_name
	send2otherserver(source = html_decode(asay_information["server_name"]), msg = message, type = "incoming_help_request", additional_data = asay_information)
	return TRUE

/datum/world_topic/incoming_help_request
	keyword = "incoming_help_request"
	require_comms_key = TRUE

/datum/world_topic/incoming_help_request/Run(list/input)
	if(!CONFIG_GET(flag/enable_cross_server_asay))
		return
	var/server_name = input["server_name"]
	var/exp_name = ckey(input["expected_name"])
	var/message = input["message"]

	send_help_request(exp_name, server_name, message)

/proc/send_help_request(sender_name, server_name, message)
	var/msg = span_command_headset("[span_adminsay("[span_crossasay("CROSSLINK HELP REQUEST")]([server_name]): <EM>[sender_name]</EM>: <span class='message linkify'>[message]")]</span>")

	to_chat(GLOB.admins,
		type = MESSAGE_TYPE_ADMINCHAT,
		html = msg,
		confidential = TRUE)

	for(var/client/admin_client in GLOB.admins)
		if(admin_client?.prefs?.toggles & SOUND_ADMINHELP)
			SEND_SOUND(admin_client, sound('modular_skyrat/modules/admin/sound/duckhonk.ogg'))
		window_flash(admin_client, ignorepref = TRUE)
