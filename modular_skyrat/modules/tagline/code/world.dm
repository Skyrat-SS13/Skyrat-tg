/world/proc/update_status()

	var/list/features = list()

	var/s = ""
	var/hostedby
	if(config)
		var/server_name = CONFIG_GET(string/servername)
		if (server_name)
			s += "<b>[server_name]</b> &#8212; "
		hostedby = CONFIG_GET(string/hostedby)

	s += " ("
	s += "<a href=\"[CONFIG_GET(string/discord_link)]\">"
	s += "Discord"
	s += ")\]"
	s += "<br>[CONFIG_GET(string/servertagline)]<br>"


	var/n = 0
	for (var/mob/M in GLOB.player_list)
		if (M.client)
			n++

	if(SSmapping.config)
		features += "[SSmapping.config.map_name]"

	if (n > 1)
		features += "~[n] players"
	else if (n > 0)
		features += "~[n] player"

	if (!host && hostedby)
		features += "hosted by <b>[hostedby]</b>"

	if (features)
		s += "\[[jointext(features, ", ")]"

	status = s

