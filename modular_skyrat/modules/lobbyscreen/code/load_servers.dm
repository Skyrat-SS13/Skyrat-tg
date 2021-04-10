/datum/config_entry/flag/server_swap_enabled

GLOBAL_LIST_EMPTY(swappable_ips)

SUBSYSTEM_DEF(serverswap)
	name = "Server Swap"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DEFAULT

	var/file_path
	var/icon/startup_splash

/datum/controller/subsystem/serverswap/Initialize()
	if(!CONFIG_GET(flag/server_swap_enabled))
		return ..()

	var/list/lines = world.file2list("config/skyrat/swap_ips.txt")
	for(var/line in lines)
		if(!length(line))
			continue
		if(findtextEx(line, "#", 1, 2))
			continue
		var/list/L = splittext(line,"+")
		if(L.len < 2)
			continue
		var/server_name = L[1]
		var/IP = L[2]
		GLOB.swappable_ips[server_name] = IP
		add_startupmessage("SERVER SWAP: [server_name] loaded with IP: [IP]!")

	return ..()
