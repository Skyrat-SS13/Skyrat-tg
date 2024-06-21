// The mentor system is a bit more complex than the other player ranks, so it's
// got its own handling and global lists declarations in the `mentor` module.

/datum/player_rank_controller/mentor
	rank_title = "mentor"


/datum/player_rank_controller/mentor/New()
	. = ..()
	legacy_file_path = "[global.config.directory]/skyrat/mentors.txt"


/datum/player_rank_controller/mentor/add_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	ckey = ckey(ckey)

	new /datum/mentors(ckey)


/datum/player_rank_controller/mentor/remove_player(ckey)
	if(IsAdminAdvancedProcCall())
		return

	var/datum/mentors/mentor_datum = GLOB.mentor_datums[ckey]
	mentor_datum?.remove_mentor()


/datum/player_rank_controller/mentor/get_ckeys_for_legacy_save()
	if(IsAdminAdvancedProcCall())
		return

	// This whole mess is just to only save the mentors that were in the config
	// already so that we don't add every admin to the config file, which would
	// be a pain to maintain afterwards.
	// We don't save mentors that are new to the `GLOB.mentor_datums` list,
	// because they should have already been saved from `add_player_legacy()`.
	var/list/mentors_to_save = list()
	var/list/existing_mentor_config = world.file2list(legacy_file_path)
	for(var/line in existing_mentor_config)
		if(!length(line))
			continue

		if(findtextEx(line, "#", 1, 2))
			continue

		var/existing_mentor = ckey(line)
		if(!existing_mentor)
			continue

		// Only save them if they're still in the mentor datums list in-game.
		if(!GLOB.mentor_datums[existing_mentor])
			continue

		// Associative list for extra SPEED!
		mentors_to_save[existing_mentor] = TRUE

	return mentors_to_save


/datum/player_rank_controller/mentor/should_use_legacy_system()
	return CONFIG_GET(flag/mentor_legacy_system)


/datum/player_rank_controller/mentor/clear_existing_rank_data()
	if(IsAdminAdvancedProcCall())
		return

	GLOB.mentor_datums.Cut()

	for(var/client/ex_mentor as anything in GLOB.mentors)
		ex_mentor.remove_mentor_verbs()
		ex_mentor.mentor_datum = null

	GLOB.mentors.Cut()
