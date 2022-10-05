#define VETERANPLAYERS "[global.config.directory]/skyrat/veteran_players.txt"

GLOBAL_LIST(veteran_players)

/proc/load_veteran_players()
	GLOB.veteran_players = list()
	for(var/line in world.file2list(VETERANPLAYERS))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.veteran_players[ckey(line)] = TRUE //Associative so we can check it much faster

/proc/save_veteran_players()
	var/veteran_list = ""
	for(var/veteran in GLOB.veteran_players)
		veteran_list += veteran + "\n"
	// rustg_file_write(veteran_list, VETERANPLAYERS)

/proc/is_veteran_player(client/user)
	if(isnull(user))
		return FALSE
	if(GLOB.veteran_players[user.ckey])
		return TRUE
	if(check_rights(R_ADMIN, FALSE))
		return TRUE
	return FALSE

#undef VETERANPLAYERS
