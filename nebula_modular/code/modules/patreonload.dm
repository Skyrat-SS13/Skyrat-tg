GLOBAL_LIST(nebula_boosters)

//Loads on roundstart.
/proc/load_neboosters()
	GLOB.nebula_boosters = list()
	for(var/line in world.file2list("config/nebula/nebula_boosters.txt"))
		if(!line)
			continue
		GLOB.nebula_boosters[ckey(line)] = TRUE

//Use this to check out if a user is a donator in next features :>
/proc/is_nebula_booster(client/user)
	if(GLOB.nebula_boosters[user.ckey])
		return TRUE
	return FALSE

//Print proc
/client/proc/printneboosters()
	set name = "Print Nebula Donators"
	set category = "Debug"
	if(GLOB.nebula_boosters.len)
		message_admins("<--- All Donators ([GLOB.nebula_boosters.len]) --->")
	else
		message_admins("<--- No donators --->")
		return
	for(var/nebooster as anything in GLOB.nebula_boosters)
		message_admins(nebooster)
	message_admins("<-------------------------->")
