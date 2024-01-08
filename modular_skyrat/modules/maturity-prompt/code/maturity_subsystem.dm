// Might as well go and group it up into a subsystem.

// Y'know, on a downstream you can go ahead and set it to whatever the fuck you want
#define AGE_TO_PLAY 18

#define AGE_CHECK_PASSED 0
#define AGE_CHECK_UNDERAGE 1
#define AGE_CHECK_INVALID 2

SUBSYSTEM_DEF(maturity_guard)
	name = "Maturity guard"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_MATURITY_GUARD
	/// A list of currently active prompts.
	var/list/prompt_cache = list()
	/// A list of players who already passed the check via prompt or are listed in the db
	var/list/whitelisted_cache = list()

	var/current_month
	var/current_year
	var/current_day


/datum/controller/subsystem/maturity_guard/Initialize()
	var/current_time = world.realtime
	current_day = text2num(time2text(current_time, "DD"))
	current_month = text2num(time2text(current_time, "MM"))
	current_year = text2num(time2text(current_time, "YYYY"))
	return SS_INIT_SUCCESS

/**
 * Checks if the player is declared of age. Prompts the player for DoB if necessary.
 */
/datum/controller/subsystem/maturity_guard/proc/age_check(mob/user)
	// Well, if there's no checks meant to be made, everyone automatically passes.
	if(!CONFIG_GET(flag/age_prompt_system))
		return TRUE

	if(!istype(user))
		return FALSE

	if(!SSmaturity_guard.initialized) // To prevent false bans, we dont let people use the prompt until the subsystem is initialized.
		return FALSE

	if(!user.ckey)
		return FALSE

	if(user.ckey in prompt_cache)
		return FALSE

	if(user.ckey in whitelisted_cache)
		return TRUE

	var/age_from_db = get_age_from_db(user)
	if(age_from_db && validate_dob(age_from_db[1], age_from_db[2], simple_check=TRUE))
		whitelisted_cache |= user.ckey
		return TRUE

	// Let's not hold up other procs
	INVOKE_ASYNC(src, PROC_REF(age_prompt), user)

/**
 * Creates a prompt window for user's date of birth.
 */
/datum/controller/subsystem/maturity_guard/proc/age_prompt(mob/user)
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(!user)
		user = usr

	if(!istype(user))
		if(IS_CLIENT_OR_MOCK(user))
			var/client/client = user
			user = client.mob
		else
			return FALSE

	if(isnull(user.client))
		return FALSE

	if(user.ckey in prompt_cache)
		return FALSE

	var/user_ckey = user.ckey

	prompt_cache |= user_ckey

	var/datum/maturity_prompt/prompt = new(user, 60 SECONDS, GLOB.always_state)
	prompt.ui_interact(user)
	prompt.wait()
	prompt_cache -= user_ckey
	if(prompt)
		. = list(prompt.year, prompt.month, prompt.day)

		message_admins("validate_dob called with [prompt.year], [prompt.month], [prompt.day]")
		var/check_result = validate_dob(prompt.year, prompt.month, prompt.day)
		message_admins("validate_dob result: [check_result]")
		switch(check_result)
			if(AGE_CHECK_PASSED)
				add_age_to_db(user, prompt.year, prompt.month)
				whitelisted_cache |= user.ckey
			if(AGE_CHECK_UNDERAGE)
				create_underage_ban(user)
			if(AGE_CHECK_INVALID)
				to_chat_immediate(user, span_warning("Invalid information entered. Please try again."))
		qdel(prompt)


/datum/controller/subsystem/maturity_guard/proc/get_age_from_db(mob/user)
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(!SSdbcore.Connect())
		return FALSE

	if(!istype(user) || !user.ckey)
		return FALSE

	var/datum/db_query/get_age_from_db = SSdbcore.NewQuery(
		"SELECT dob_year, dob_month FROM [format_table_name("player_dob")] WHERE ckey = :ckey",
		list("ckey" = user.ckey),
	)

	if(!get_age_from_db.warn_execute())
		return  FALSE

	// There should be only one, we're querying by the primary key; if it returns more than one row something is very wrong
	get_age_from_db.NextRow()
	return get_age_from_db.item


/datum/controller/subsystem/maturity_guard/proc/add_age_to_db(mob/user, year, month)
	if(IsAdminAdvancedProcCall())
		return FALSE

	if(!SSdbcore.Connect())
		return FALSE

	if(!istype(user) || !user.ckey)
		return FALSE

	if(!isnum(year) || !isnum(month))
		return FALSE

	var/datum/db_query/add_age_to_db = SSdbcore.NewQuery(
		"INSERT INTO [format_table_name("player_dob")] (ckey, dob_year, dob_month) VALUES(:ckey, :dob_year, :dob_month) \
		 ON DUPLICATE KEY UPDATE dob_year = :dob_year, dob_month = :dob_month",
		list("ckey" = user.ckey, "dob_year" = year, "dob_month" = month),
	)

	if(!add_age_to_db.warn_execute())
		return FALSE

	return TRUE

// create_ban(player_key, ip_check, player_ip, cid_check, player_cid, use_last_connection, applies_to_admins, duration, interval, severity, reason, global_ban, list/roles_to_ban)
// Logic shamefully borrowed from S.P.L.U.R.T
// https://github.com/SPLURT-Station/S.P.L.U.R.T-Station-13/blob/6e6bce87726b7a5ac7ebf23bec7b020a004c6e60/code/modules/mob/dead/new_player/new_player.dm
/datum/controller/subsystem/maturity_guard/proc/validate_dob(player_year, player_month, player_day, simple_check = FALSE)
	//Rudimentary sanity check
	if(player_year >= current_year || player_year <= 1900 || player_month < 1 || player_month > 12)
		return AGE_CHECK_INVALID

	var/player_total_months = (player_year * 12) + player_month
	var/current_total_months = (current_year * 12) + current_month
	var/months_in_required_age = AGE_TO_PLAY * 12

	var/month_difference = current_total_months - player_total_months
	if(month_difference > months_in_required_age)
		return AGE_CHECK_PASSED

	if(month_difference < months_in_required_age)
		return AGE_CHECK_UNDERAGE

	// We're assuming the data we're operating on has already undergone a more rigorous check
	if(simple_check)
		return AGE_CHECK_PASSED

	//they could be 17 or 18 depending on the /day/ they were born in
	var/days_in_months = list(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)
	if((player_year % 4) == 0) // leap year so february actually has 29 days
		days_in_months[2] = 29
	var/total_days_in_player_month = days_in_months[player_month]

	if(player_day < 1 || player_day > total_days_in_player_month)
		return AGE_CHECK_INVALID

	if(player_day <= current_day)
		//their birthday has passed
		return AGE_CHECK_PASSED
	else
		//it has NOT been their 18th birthday yet
		return AGE_CHECK_UNDERAGE

// I hate this abomination
/// Because apparently there's no simple proc for applying bans and admin datums need an actual admin holding them
/datum/controller/subsystem/maturity_guard/proc/create_underage_ban(mob/user)
	if(IsAdminAdvancedProcCall())
		return

	if(!SSdbcore.Connect())
		return

	if(!istype(user) || !user.ckey)
		return

	var/list/clients_online = GLOB.clients.Copy()
	var/list/admins_online = list()
	for(var/client/C in clients_online)
		if(C.holder) //deadmins aren't included since they wouldn't show up on adminwho
			admins_online += C
	var/who = clients_online.Join(", ")
	var/adminwho = admins_online.Join(", ")

	var/special_columns = list(
		"bantime" = "NOW()",
		"server_ip" = "INET_ATON(?)",
		"ip" = "INET_ATON(?)",
		"a_ip" = "INET_ATON(?)",
		"expiration_time" = "NULL"
	)

	var/sql_ban = list(
		"server_name" = CONFIG_GET(string/serversqlname),
		"server_ip" = world.internet_address || 0,
		"server_port" = world.port,
		"round_id" = GLOB.round_id,
		"role" = "Server",
		"global_ban" = TRUE,
		"expiration_time" = null,
		"applies_to_admins" = TRUE,
		"reason" = "You do not meet the minimum age requirements for this community. If you believe this to be a mistake, file an appeal in our community.",
		"ckey" = user.ckey,
		"ip" = user.client.address,
		"computerid" = user.client.computer_id,
		"a_ckey" = "AGE CHECK SYSTEM",
		"a_ip" = 0,
		"a_computerid" = "N/A",
		"who" = who,
		"adminwho" = adminwho
	)

	if(!SSdbcore.MassInsert(format_table_name("ban"), sql_ban, warn = TRUE, special_columns = special_columns))
		return

	var/target = "[user.ckey]/[user.client.address]/[user.client.computer_id]"
	var/msg = "has created a global permanent server ban for [target]."
	log_admin_private("AGE CHECK SYSTEM [msg]")
	message_admins("AGE CHECK SYSTEM [msg]")


	var/discord_appeal_text = ""
	if(CONFIG_GET(string/discord_link))
		discord_appeal_text = "If you believe this to be a mistake, file an appeal in our community. <a href='[CONFIG_GET(string/discord_link)]>[CONFIG_GET(string/discord_link)]</a>"

	var/player_ban_notification = span_boldannounce("You have been banned by the AGE CHECK SYSTEM from the server.\nReason: You do not meet the minimum age requirements for this community. [discord_appeal_text]<br>[span_danger("This ban is permanent. The round ID is [GLOB.round_id].")]")
	to_chat(user, player_ban_notification)

	qdel(user.client)
