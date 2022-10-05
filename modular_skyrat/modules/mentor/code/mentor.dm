#define SKYRAT_MENTOR_CONFIG_FILE "[global.config.directory]/skyrat/mentors.txt"

GLOBAL_LIST_EMPTY(mentor_datums)
GLOBAL_PROTECT(mentor_datums)

GLOBAL_VAR_INIT(mentor_href_token, GenerateToken())
GLOBAL_PROTECT(mentor_href_token)

//#define SKYRAT_MENTOR_CONFIG_FILE "[global.config.directory]/skyrat/mentors.txt"

/datum/mentors
	var/name = "someone's mentor datum"
	var/client/owner // the actual mentor, client type
	var/target // the mentor's ckey
	var/href_token // href token for mentor commands, uses the same token used by admins.
	var/mob/following

/datum/mentors/New(ckey)
	if(!ckey)
		QDEL_IN(src, 0)
		CRASH("Mentor datum created without a ckey")
	target = ckey(ckey)
	name = "[ckey]'s mentor datum"
	href_token = GenerateToken()
	GLOB.mentor_datums[target] = src
	//set the owner var and load commands
	owner = GLOB.directory[ckey]
	if(owner)
		owner.mentor_datum = src
		owner.add_mentor_verbs()
		if(!check_rights_for(owner, R_ADMIN,0)) // don't add admins to mentor list.
			GLOB.mentors[owner] = TRUE

/datum/mentors/proc/remove_mentor()
	if(owner)
		owner.remove_mentor_verbs()
		GLOB.mentors -= owner
		owner.mentor_datum = null
		owner = null
	log_admin_private("[target] was removed from the rank of mentor.")
	GLOB.mentor_datums -= target
	qdel(src)

/datum/mentors/proc/CheckMentorHREF(href, href_list)
	var/auth = href_list["mentor_token"]
	. = auth && (auth == href_token || auth == GLOB.mentor_href_token)
	if(.)
		return
	var/msg = !auth ? "no" : "a bad"
	message_admins("[key_name_admin(usr)] clicked an href with [msg] authorization key!")
	if(CONFIG_GET(flag/debug_admin_hrefs))
		message_admins("Debug mode enabled, call not blocked. Please ask your coders to review this round's logs.")
		log_world("UAH: [href]")
		return TRUE
	log_admin_private("[key_name(usr)] clicked an href with [msg] authorization key! [href]")

/proc/RawMentorHrefToken(forceGlobal = FALSE)
	var/tok = GLOB.mentor_href_token
	if(!forceGlobal && usr)
		var/client/C = usr.client
		to_chat(world, C)
		to_chat(world, usr)
		if(!C)
			CRASH("No client for HrefToken()!")
		var/datum/mentors/holder = C.mentor_datum
		if(holder)
			tok = holder.href_token
	return tok

/proc/MentorHrefToken(forceGlobal = FALSE)
	return "mentor_token=[RawMentorHrefToken(forceGlobal)]"

/proc/load_mentors()
	usr = null
	GLOB.mentor_datums.Cut()
	for(var/it as anything in GLOB.mentors)
		var/client/C = it
		C.remove_mentor_verbs()
		C.mentor_datum = null
	GLOB.mentors.Cut()
	//if(CONFIG_GET(flag/mentor_legacy_system))//legacy
	var/list/lines = world.file2list(SKYRAT_MENTOR_CONFIG_FILE)
	for(var/line in lines)
		if(!length(line))
			continue
		if(findtextEx(line, "#", 1, 2))
			continue
		new /datum/mentors(line)
	/*else//Database
		if(!SSdbcore.Connect())
			log_world("Failed to connect to database in load_mentors(). Reverting to legacy system.")
			WRITE_FILE(GLOB.world_game_log, "Failed to connect to database in load_mentors(). Reverting to legacy system.")
			CONFIG_SET(flag/mentor_legacy_system, TRUE)
			load_mentors()
			return
		var/datum/DBQuery/query_load_mentors = SSdbcore.NewQuery("SELECT ckey FROM [format_table_name("mentor")]")
		if(!query_load_mentors.Execute())
			return
		while(query_load_mentors.NextRow())
			var/ckey = ckey(query_load_mentors.item[1])
			new /datum/mentors(ckey)*/

/// Proc to save the current mentor list into the config, overwriting it.
/proc/save_mentors()
	usr = null
	var/mentor_list = ""

	// This whole mess is just to create a cache of all the mentors that were in the config already
	// so that we don't add every admin to the list, which would be a pain to maintain afterwards.
	var/list/existing_mentor_config = world.file2list(SKYRAT_MENTOR_CONFIG_FILE)
	var/list/existing_mentors = list()
	for(var/line in existing_mentor_config)
		if(!length(line))
			continue
		if(findtextEx(line, "#", 1, 2))
			continue
		var/existing_mentor = ckey(line)
		if(!existing_mentor)
			continue
		existing_mentors[existing_mentor] = TRUE

	for(var/mentor as anything in GLOB.mentor_datums)
		// We're doing this check to not add admins to the file, as explained above.
		if(existing_mentors[mentor] == TRUE)
			mentor_list += mentor + "\n"
	// rustg_file_write(mentor_list, SKYRAT_MENTOR_CONFIG_FILE)


// new client var: mentor_datum. Acts the same way holder does towards admin: it holds the mentor datum. if set, the guy's a mentor.
/client
	var/datum/mentors/mentor_datum

#undef SKYRAT_MENTOR_CONFIG_FILE
