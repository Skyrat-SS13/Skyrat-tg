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

#undef TRUSTEDPLAYERS
