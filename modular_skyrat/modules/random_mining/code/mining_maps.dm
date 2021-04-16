GLOBAL_LIST_EMPTY(mining_zs)

SUBSYSTEM_DEF(randommining)
	name = "Random Mining"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TICKER


/datum/controller/subsystem/randommining/Initialize()

	if(!fexists("config/skyrat/mining_levels.txt"))
		add_startupmessage("RANDOM MINING ERROR: mining_levels.txt does not exist, unable to load mining level!")
		return ..()

	var/list/lines = world.file2list("config/skyrat/mining_levels.txt")
	for(var/line in lines)
		if(!length(line))
			continue
		if(findtextEx(line, "#", 1, 2))
			continue
		var/list/L = splittext(line,"+")
		if(L.len < 2)
			continue
		var/name = L[1]
		var/traits = L[2]
		GLOB.mining_zs[name] = traits
		add_startupmessage("RANDOM MINING: [uppertext(name)] Level loaded!")

	return ..()
