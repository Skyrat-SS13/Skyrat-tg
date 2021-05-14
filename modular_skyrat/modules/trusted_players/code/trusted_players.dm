#define TRUSTEDPLAYERS "[global.config.directory]/skyrat/trusted_players.txt"

GLOBAL_LIST(trusted_players)

/proc/load_trusted_players()
	GLOB.trusted_players = list()
	for(var/line in world.file2list(TRUSTEDPLAYERS))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.trusted_players[ckey(line)] = TRUE //Associative so we can check it much faster

/proc/is_trusted_player(client/user)
	if(GLOB.trusted_players[user.ckey])
		return TRUE
	if(check_rights(R_ADMIN, FALSE))
		return TRUE
	return FALSE

#undef TRUSTEDPLAYERS
