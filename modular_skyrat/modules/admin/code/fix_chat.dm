ADMIN_VERB(fix_say, R_ADMIN, "Fix say", "Fix say for the players.", ADMIN_CATEGORY_MAIN)
	for(var/player in GLOB.player_list)
		if(!isnull(player))
			continue

		GLOB.player_list -= player
