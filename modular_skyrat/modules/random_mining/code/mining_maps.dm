SUBSYSTEM_DEF(randommining)
	name = "Random Mining"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TICKER

	var/list/possible_names = list()
	var/previous_map
	var/chosen_map
	var/traits
	var/voted_next_map
	var/voted_map

/datum/controller/subsystem/randommining/Initialize()

	var/list/possible_choices = list()

	if(fexists("data/next_mining.dat"))
		var/list/_voted_map = world.file2list("data/next_mining.dat")
		if(istext(_voted_map[1]))
			voted_map = _voted_map[1]
		fdel("data/previous_mining.dat")

	if(fexists("data/previous_mining.dat"))
		var/list/_previous_map = world.file2list("data/previous_mining.dat")
		if(istext(_previous_map[1]))
			previous_map = _previous_map[1]
		fdel("data/previous_mining.dat")

	if(!fexists("config/skyrat/mining_levels.txt"))
		to_chat(world, span_boldannounce("RANDOM MINING ERROR: mining_levels.txt does not exist, unable to load mining level!"))
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
		if(!voted_map && name == previous_map && lines.len > 1)
			continue
		possible_choices[name] = traits
		possible_names += name
		to_chat(world, span_boldannounce("RANDOM MINING: [uppertext(name)] Level loaded!"))

	if(voted_map)
		chosen_map = voted_map
		traits = possible_choices[chosen_map]
	else
		chosen_map = pick(possible_choices)
		traits = possible_choices[chosen_map]

	if(!chosen_map)
		to_chat(world, span_boldannounce("RANDOM MINING: Error, no map was chosen!"))
		return ..()
	else if(voted_map)
		to_chat(world, span_boldannounce("RANDOM MINING: Voted map loaded!"))
	else
		to_chat(world, span_boldannounce("RANDOM MINING: Map randomly picked!"))

	var/F = file("data/previous_mining.dat")
	WRITE_FILE(F, chosen_map)

	return ..()

/datum/controller/subsystem/randommining/proc/mapvote()
	if(voted_next_map) //If voted or set by other means.
		return
	if(SSvote.mode) //Theres already a vote running, default to rotation.
		to_chat(world, span_boldannounce("MAPPING VOTE ERROR; VOTE IN PROGRESS, REVERTING TO RANDOM MAP."))
		if(fexists("data/next_mining.dat"))
			fdel("data/next_mining.dat")
		return
	SSvote.initiate_vote("mining_map", "automatic mining map rotation")

/client/proc/set_mining_map()
	set name = "Set Mining Map"
	set category = "Server"
	set desc = "Force change the next mining map."

	if(!check_rights(R_SERVER))
		return

	var/new_map = tgui_input_list(usr, "Choose a mining map:", "Mining Map Change", SSrandommining.possible_names)

	if(fexists("data/next_mining.dat"))
		fdel("data/next_mining.dat")

	var/F = file("data/next_mining.dat")

	WRITE_FILE(F, new_map)

	SSrandommining.voted_next_map = TRUE

	message_admins("[key_name_admin(usr)] has set the next mining map to [new_map]!")
