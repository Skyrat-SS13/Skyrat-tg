/// The list of all donators.
GLOBAL_LIST_EMPTY(donator_list)
GLOBAL_PROTECT(donator_list)

/datum/player_rank_controller/donator
	rank_title = "donator"
	// Yes, this is incredibly long, deal with it. It's to keep that cute little comment at the top.
	legacy_file_header = "###############################################################################################\n# List for people who support us! They get cool loadout items                                 #\n# Case is not important for ckey.                                                             #\n###############################################################################################\n"


/datum/player_rank_controller/donator/New()
	. = ..()
	legacy_file_path = "[global.config.directory]/skyrat/donators.txt"



/datum/player_rank_controller/donator/add_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	ckey = ckey(ckey)

	// Associative list for extra SPEED!
	GLOB.donator_list[ckey] = TRUE


/datum/player_rank_controller/donator/remove_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	GLOB.donator_list -= ckey


/datum/player_rank_controller/donator/get_ckeys_for_legacy_save()
	if(IsAdminAdvancedProcCall())
		return

	return GLOB.donator_list


/datum/player_rank_controller/donator/should_use_legacy_system()
	return CONFIG_GET(flag/donator_legacy_system)


/datum/player_rank_controller/donator/clear_existing_rank_data()
	if(IsAdminAdvancedProcCall())
		return

	GLOB.donator_list = list()
