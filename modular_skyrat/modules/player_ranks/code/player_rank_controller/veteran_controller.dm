/// The list of all veteran players.
GLOBAL_LIST_EMPTY(veteran_list)
GLOBAL_PROTECT(veteran_list)


/datum/player_rank_controller/veteran
	rank_title = "veteran"


/datum/player_rank_controller/veteran/New()
	. = ..()
	legacy_file_path = "[global.config.directory]/skyrat/veteran_players.txt"


/datum/player_rank_controller/veteran/add_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	ckey = ckey(ckey)

	// Associative list for extra SPEED!
	GLOB.veteran_list[ckey] = TRUE


/datum/player_rank_controller/veteran/remove_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	GLOB.veteran_list -= ckey


/datum/player_rank_controller/veteran/get_ckeys_for_legacy_save()
	if(IsAdminAdvancedProcCall())
		return

	return GLOB.veteran_list


/datum/player_rank_controller/veteran/should_use_legacy_system()
	return CONFIG_GET(flag/veteran_legacy_system)


/datum/player_rank_controller/veteran/clear_existing_rank_data()
	if(IsAdminAdvancedProcCall())
		return

	GLOB.veteran_list = list()
