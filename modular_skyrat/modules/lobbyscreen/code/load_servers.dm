/datum/config_entry/flag/server_swap_enabled

GLOBAL_LIST_EMPTY(swappable_ips)

SUBSYSTEM_DEF(serverswap)
	name = "Server Swap"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_DEFAULT


/datum/controller/subsystem/serverswap/Initialize()
	if(!CONFIG_GET(flag/server_swap_enabled))
		return ..()

	if(!fexists("config/skyrat/swap_ips.txt"))
		to_chat_immediate(world, span_boldwarning("SERVER SWAP ERROR: swap_ips.txt does not exist, unable to set up server swapping!"))
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
		to_chat(world, span_boldannounce("SERVER SWAP: [server_name] loaded with IP: [IP]!"))

	return ..()
