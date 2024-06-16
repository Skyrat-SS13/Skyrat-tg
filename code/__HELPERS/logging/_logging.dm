//print a warning message to world.log
#define WARNING(MSG) warning("[MSG] in [__FILE__] at line [__LINE__] src: [UNLINT(src)] usr: [usr].")
/proc/warning(msg)
	msg = "## WARNING: [msg]"
	log_world(msg)

//not an error or a warning, but worth to mention on the world log, just in case.
#define NOTICE(MSG) notice(MSG)
/proc/notice(msg)
	msg = "## NOTICE: [msg]"
	log_world(msg)

#define SET_SERIALIZATION_SEMVER(semver_list, semver) semver_list[type] = semver
#define CHECK_SERIALIZATION_SEMVER(wanted, actual) (__check_serialization_semver(wanted, actual))

/// Checks if the actual semver is equal or later than the wanted semver
/// Must be passed as TEXT; you're probably looking for CHECK_SERIALIZATION_SEMVER, look right above
/proc/__check_serialization_semver(wanted, actual)
	if(wanted == actual)
		return TRUE

	var/list/wanted_versions = semver_to_list(wanted)
	var/list/actual_versions = semver_to_list(actual)

	if(!wanted_versions || !actual_versions)
		stack_trace("Invalid semver string(s) passed to __check_serialization_semver: '[wanted]' and '[actual]'")
		return FALSE

	if(wanted_versions[1] != actual_versions[1])
		return FALSE // major must always

	if(wanted_versions[2] > actual_versions[2])
		return FALSE // actual must be later than wanted

	// patch is not checked
	return TRUE

//print a testing-mode debug message to world.log and world
#ifdef TESTING
#define testing(msg) log_world("## TESTING: [msg]"); to_chat(world, "## TESTING: [msg]")

GLOBAL_LIST_INIT(testing_global_profiler, list("_PROFILE_NAME" = "Global"))
// we don't really check if a word or name is used twice, be aware of that
#define testing_profile_start(NAME, LIST) LIST[NAME] = world.timeofday
#define testing_profile_current(NAME, LIST) round((world.timeofday - LIST[NAME])/10,0.1)
#define testing_profile_output(NAME, LIST) testing("[LIST["_PROFILE_NAME"]] profile of [NAME] is [testing_profile_current(NAME,LIST)]s")
#define testing_profile_output_all(LIST) { for(var/_NAME in LIST) { testing_profile_current(,_NAME,LIST); }; };
#else
#define testing(msg)
#define testing_profile_start(NAME, LIST)
#define testing_profile_current(NAME, LIST)
#define testing_profile_output(NAME, LIST)
#define testing_profile_output_all(LIST)
#endif

#define testing_profile_global_start(NAME) testing_profile_start(NAME,GLOB.testing_global_profiler)
#define testing_profile_global_current(NAME) testing_profile_current(NAME, GLOB.testing_global_profiler)
#define testing_profile_global_output(NAME) testing_profile_output(NAME, GLOB.testing_global_profiler)
#define testing_profile_global_output_all testing_profile_output_all(GLOB.testing_global_profiler)

#define testing_profile_local_init(PROFILE_NAME) var/list/_timer_system = list( "_PROFILE_NAME" = PROFILE_NAME, "_start_of_proc" = world.timeofday )
#define testing_profile_local_start(NAME) testing_profile_start(NAME, _timer_system)
#define testing_profile_local_current(NAME) testing_profile_current(NAME, _timer_system)
#define testing_profile_local_output(NAME) testing_profile_output(NAME, _timer_system)
#define testing_profile_local_output_all testing_profile_output_all(_timer_system)

#if defined(UNIT_TESTS) || defined(SPACEMAN_DMM)
/proc/log_test(text)
	WRITE_LOG(GLOB.test_log, text)
	SEND_TEXT(world.log, text)
#endif

#if defined(REFERENCE_TRACKING_LOG_APART)
#define log_reftracker(msg) log_harddel("## REF SEARCH [msg]")

/proc/log_harddel(text)
	WRITE_LOG(GLOB.harddel_log, text)

#elif defined(REFERENCE_TRACKING) // Doing it locally
#define log_reftracker(msg) log_world("## REF SEARCH [msg]")

#else //Not tracking at all
#define log_reftracker(msg)
#endif

/**
 * Generic logging helper
 *
 * reads the type of the log
 * and writes it to the respective log file
 * unless log_globally is FALSE
 * Arguments:
 * * message - The message being logged
 * * message_type - the type of log the message is(ATTACK, SAY, etc)
 * * color - color of the log text
 * * log_globally - boolean checking whether or not we write this log to the log file
 */
/atom/proc/log_message(message, message_type, color = null, log_globally = TRUE, list/data)
	if(!log_globally)
		return

	//SKYRAT EDIT ADDITION BEGIN
	#ifndef SPACEMAN_DMM
	if(CONFIG_GET(flag/sql_game_log) && CONFIG_GET(flag/sql_enabled))
		SSdbcore.add_log_to_mass_insert_queue(
			format_table_name("game_log"),
			list(
				"datetime" = ISOtime(),
				"round_id" = "[GLOB.round_id]",
				"ckey" = key_name(src),
				"loc" = loc_name(src),
				"type" = message_type,
				"message" = message,
			)
		)
		if(!CONFIG_GET(flag/file_game_log))
			return
	#endif
	//SKYRAT EDIT ADDITION END
	var/log_text = "[key_name_and_tag(src)] [message] [loc_name(src)]"
	switch(message_type)
		/// ship both attack logs and victim logs to the end of round attack.log just to ensure we don't lose information
		if(LOG_ATTACK, LOG_VICTIM)
			log_attack(log_text, data)
		if(LOG_SAY)
			log_say(log_text, data)
		if(LOG_WHISPER)
			log_whisper(log_text, data)
		if(LOG_EMOTE)
			log_emote(log_text, data)
		//SKYRAT EDIT ADDITION BEGIN
		if(LOG_SUBTLE)
			log_subtle(log_text, data)
		if(LOG_SUBTLER)
			log_subtler(log_text, data)
		//SKYRAT EDIT ADDITION END
		if(LOG_RADIO_EMOTE)
			log_radio_emote(log_text, data)
		if(LOG_DSAY)
			log_dsay(log_text, data)
		if(LOG_PDA)
			log_pda(log_text, data)
		if(LOG_CHAT)
			log_chat(log_text, data)
		if(LOG_COMMENT)
			log_comment(log_text, data)
		if(LOG_TELECOMMS)
			log_telecomms(log_text, data)
		if(LOG_TRANSPORT)
			log_transport(log_text, data)
		if(LOG_ECON)
			log_econ(log_text, data)
		if(LOG_OOC)
			log_ooc(log_text, data)
		if(LOG_ADMIN)
			log_admin(log_text, data)
		if(LOG_ADMIN_PRIVATE)
			log_admin_private(log_text, data)
		if(LOG_ASAY)
			log_adminsay(log_text, data)
		if(LOG_OWNERSHIP)
			log_game(log_text, data)
		if(LOG_GAME)
			log_game(log_text, data)
		if(LOG_MECHA)
			log_mecha(log_text, data)
		if(LOG_SHUTTLE)
			log_shuttle(log_text, data)
		if(LOG_SPEECH_INDICATORS)
			log_speech_indicators(log_text, data)
		else
			stack_trace("Invalid individual logging type: [message_type]. Defaulting to [LOG_GAME] (LOG_GAME).")
			log_game(log_text, data)

/* For logging round startup. */
/proc/start_log(log)
	WRITE_LOG(log, "Starting up round ID [GLOB.round_id].\n-------------------------")

/* Close open log handles. This should be called as late as possible, and no logging should hapen after. */
/proc/shutdown_logging()
	rustg_log_close_all()
	logger.shutdown_logging()

/* Helper procs for building detailed log lines */
/proc/key_name(whom, include_link = null, include_name = TRUE)
	var/mob/M
	var/client/C
	var/key
	var/ckey
	var/fallback_name

	if(!whom)
		return "*null*"
	if(istype(whom, /client))
		C = whom
		M = C.mob
		key = C.key
		ckey = C.ckey
	else if(ismob(whom))
		M = whom
		C = M.client
		key = M.key
		ckey = M.ckey
	else if(istext(whom))
		key = whom
		ckey = ckey(whom)
		C = GLOB.directory[ckey]
		if(C)
			M = C.mob
	else if(istype(whom,/datum/mind))
		var/datum/mind/mind = whom
		key = mind.key
		ckey = ckey(key)
		if(mind.current)
			M = mind.current
			if(M.client)
				C = M.client
		else
			fallback_name = mind.name
	else // Catch-all cases if none of the types above match
		var/swhom = null

		if(istype(whom, /atom))
			var/atom/A = whom
			swhom = "[A.name]"
		else if(isdatum(whom))
			swhom = "[whom]"

		if(!swhom)
			swhom = "*invalid*"

		return "\[[swhom]\]"

	. = ""

	if(!ckey)
		include_link = FALSE

	if(key)
		if(C?.holder && C.holder.fakekey && !include_name)
			if(include_link)
				. += "<a href='?priv_msg=[C.getStealthKey()]'>"
			. += "Administrator"
		else
			if(include_link)
				. += "<a href='?priv_msg=[ckey]'>"
			. += key
		if(!C)
			. += "\[DC\]"

		if(include_link)
			. += "</a>"
	else
		. += "*no key*"

	if(include_name)
		if(M)
			if(M.real_name)
				. += "/([M.real_name])"
			else if(M.name)
				. += "/([M.name])"
		else if(fallback_name)
			. += "/([fallback_name])"

	return .

/proc/key_name_admin(whom, include_name = TRUE)
	return key_name(whom, TRUE, include_name)

/proc/key_name_and_tag(whom, include_link = null, include_name = TRUE)
	var/tag = "!tagless!" // whom can be null in key_name() so lets set this as a safety
	if(isatom(whom))
		var/atom/subject = whom
		tag = subject.tag
	return "[key_name(whom, include_link, include_name)] ([tag])"

/proc/loc_name(atom/A)
	if(!istype(A))
		return "(INVALID LOCATION)"

	var/turf/T = A
	if (!istype(T))
		T = get_turf(A)

	if(istype(T))
		return "([AREACOORD(T)])"
	else if(A.loc)
		return "(UNKNOWN (?, ?, ?))"
