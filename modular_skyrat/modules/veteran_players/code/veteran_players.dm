GLOBAL_LIST(veteran_players)

/*
/// Handles loading veteran players either via SQL or using the legacy system,
/// based on configs.
/proc/load_veteran_players()
	if(CONFIG_GET(flag/veteran_legacy_system))
		load_veteran_players_legacy()
		return

	if(!SSdbcore.Connect())
		var/message = "Failed to connect to database in load_veteran_players(). Reverting to legacy system."
		log_config(message)
		log_game(message)
		message_admins(message)
		CONFIG_SET(flag/veteran_legacy_system, TRUE)
		load_veteran_players_legacy()
		return

	load_veteran_players_sql()


/proc/load_veteran_players_legacy()
	GLOB.veteran_players = list()
	for(var/line in world.file2list(VETERANPLAYERS))
		if(!line)
			continue
		if(findtextEx(line,"#",1,2))
			continue
		GLOB.veteran_players[ckey(line)] = TRUE //Associative so we can check it much faster


/proc/load_veteran_players_sql()
	GLOB.veteran_players = list()

	var/datum/db_query/query_load_veterans = SSdbcore.NewQuery("SELECT ckey FROM [format_table_name("veteran")]")

	if(!query_load_veterans.Execute())
		return

	while(query_load_mentors.NextRow())
		var/ckey = ckey(query_load_mentors.item[1])
		GLOB.veteran_players[ckey] = TRUE // Associative so we can check it much faster


/**
 * Handles adding the ckey to the veteran players list, either on the database
 * or in the legacy system.
 *
 * Arguments:
 * * ckey - The ckey of the player you want to now be a veteran.
 * * admin_ckey - The ckey of the admin adding the veteran.
 */
/proc/add_veteran_player(ckey, admin_ckey)
	if(!ckey)
		return

	for(var/veteran as anything in GLOB.veteran_players)
		if(ckey == veteran)
			return "\"[ckey]\" is already a veteran!"

	if(CONFIG_GET(flag/veteran_legacy_system))
		add_veteran_player_legacy(ckey)
		return

	if(!admin_ckey)
		CRASH("No admin ckey provided in add_veteran_player() when not running the legacy veteran system!")

	add_veteran_player_sql(ckey, admin_ckey)


/proc/add_veteran_player_legacy(ckey)
	GLOB.veteran_players[ckey] = TRUE
	text2file(ckey, SKYRAT_VETERAN_CONFIG_FILE)



/proc/save_veteran_players_legacy()
	var/veteran_list = ""
	for(var/veteran in GLOB.veteran_players)
		veteran_list += veteran + "\n"
	rustg_file_write(veteran_list, VETERANPLAYERS)

/proc/is_veteran_player(client/user)
	if(isnull(user))
		return FALSE
	if(GLOB.veteran_players[user.ckey])
		return TRUE
	if(check_rights_for(user, R_ADMIN))
		return TRUE
	if(GLOB.deadmins[user.ckey])
		return TRUE
	return FALSE
*/
