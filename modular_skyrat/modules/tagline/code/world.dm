/world/proc/update_status()

	var/list/features = list()

	var/new_status = ""
	var/hostedby
	if(config)
		var/server_name = CONFIG_GET(string/servername)
		if (server_name)
			new_status += "<b>[server_name]</b> &#8212; "
		hostedby = CONFIG_GET(string/hostedby)

	new_status += " ("
	new_status += "<a href=\"[CONFIG_GET(string/discord_link)]\">"
	new_status += "Discord"
	new_status += ")\]"
	new_status += "<br>[CONFIG_GET(string/servertagline)]<br>"


	var/players = GLOB.clients.len

	if(SSmapping.config)
		features += "[SSmapping.config.map_name]"

	features += "~[players] player[players == 1 ? "": "s"]"

	if (!host && hostedby)
		features += "hosted by <b>[hostedby]</b>"

	if(length(features))
		new_status += "\[[jointext(features, ", ")]"

	status = new_status

