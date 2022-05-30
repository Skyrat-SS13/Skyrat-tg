/mob/dead/new_player/Topic(href, href_list[])
	if(src != usr)
		return

	if(!client)
		return

	if(client.interviewee)
		return FALSE

	if(href_list["observe"])
		play_lobby_button_sound()
		make_me_an_observer()
		return

	if(href_list["server_swap"])
		play_lobby_button_sound()
		server_swap()
		return

	if(href_list["view_manifest"])
		play_lobby_button_sound()
		ViewManifest()
		return

	if(href_list["toggle_antag"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.write_preference(GLOB.preference_entries[/datum/preference/toggle/be_antag], !preferences.read_preference(/datum/preference/toggle/be_antag))
		client << output(preferences.read_preference(/datum/preference/toggle/be_antag), "title_browser:toggle_antag")
		return

	if(href_list["character_setup"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
		preferences.update_static_data(src)
		preferences.ui_interact(src)
		return

	if(href_list["game_options"])
		play_lobby_button_sound()
		var/datum/preferences/preferences = client.prefs
		preferences.current_window = PREFERENCE_TAB_GAME_PREFERENCES
		preferences.update_static_data(usr)
		preferences.ui_interact(usr)
		return

	if(href_list["toggle_ready"])
		play_lobby_button_sound()
		if(!is_admin(client) && length_char(client?.prefs?.read_preference(/datum/preference/text/flavor_text)) < FLAVOR_TEXT_CHAR_REQUIREMENT)
			to_chat(src, span_notice("You need at least [FLAVOR_TEXT_CHAR_REQUIREMENT] characters of flavor text to ready up for the round. You have [length_char(client.prefs.read_preference(/datum/preference/text/flavor_text))] characters."))
			return

		ready = !ready
		client << output(ready, "title_browser:toggle_ready")
		return

	if(href_list["late_join"])
		play_lobby_button_sound()
		if(!SSticker?.IsRoundInProgress())
			to_chat(src, span_boldwarning("The round is either not ready, or has already finished..."))
			return

		//Determines Relevent Population Cap
		var/relevant_cap
		var/hard_popcap = CONFIG_GET(number/hard_popcap)
		var/extreme_popcap = CONFIG_GET(number/extreme_popcap)
		if(hard_popcap && extreme_popcap)
			relevant_cap = min(hard_popcap, extreme_popcap)
		else
			relevant_cap = max(hard_popcap, extreme_popcap)

		if(SSticker.queued_players.len || (relevant_cap && living_player_count() >= relevant_cap && !(ckey(key) in GLOB.admin_datums)))
			to_chat(src, span_danger("[CONFIG_GET(string/hard_popcap_message)]"))

			var/queue_position = SSticker.queued_players.Find(src)
			if(queue_position == 1)
				to_chat(src, span_notice("You are next in line to join the game. You will be notified when a slot opens up."))
			else if(queue_position)
				to_chat(src, span_notice("There are [queue_position-1] players in front of you in the queue to join the game."))
			else
				SSticker.queued_players += src
				to_chat(src, span_notice("You have been added to the queue to join the game. Your position in queue is [SSticker.queued_players.len]."))
			return

		if(length_char(src.client.prefs.read_preference(/datum/preference/text/flavor_text)) < FLAVOR_TEXT_CHAR_REQUIREMENT)
			to_chat(src, span_notice("You need at least [FLAVOR_TEXT_CHAR_REQUIREMENT] characters of flavor text to join the round. You have [length_char(src.client.prefs.read_preference(/datum/preference/text/flavor_text))] characters."))
			return

		LateChoices()
		return

	if(href_list["cancrand"])
		src << browse(null, "window=randjob") //closes the random job window
		LateChoices()
		return

	if(href_list["SelectedJob"])
		select_job(href_list["SelectedJob"])
		return

	if(href_list["viewpoll"])
		play_lobby_button_sound()
		var/datum/poll_question/poll = locate(href_list["viewpoll"]) in GLOB.polls
		poll_player(poll)
		return

	if(href_list["votepollref"])
		var/datum/poll_question/poll = locate(href_list["votepollref"]) in GLOB.polls
		vote_on_poll_handler(poll, href_list)
		return


/mob/dead/new_player/Login()
	. = ..()
	show_title_screen()

/**
 * Shows the titlescreen to a new player.
 */
/mob/dead/new_player/proc/show_title_screen()
	if (client?.interviewee)
		return

	winset(src, "title_browser", "is-disabled=false;is-visible=true")

	var/datum/asset/assets = get_asset_datum(/datum/asset/simple/lobby) //Sending pictures to the client
	assets.send(src)

	update_title_screen()

/**
 * Hard updates the title screen HTML, it causes visual glitches if used.
 */
/mob/dead/new_player/proc/update_title_screen()
	var/dat = get_title_html()

	src << browse(SStitle.current_title_screen, "file=loading_screen.gif;display=0")
	src << browse(dat, "window=title_browser")

/datum/asset/simple/lobby
	assets = list(
		"FixedsysExcelsior3.01Regular.ttf" = 'html/browser/FixedsysExcelsior3.01Regular.ttf',
	)

/**
 * Removes the titlescreen entirely from a mob.
 */
/mob/dead/new_player/proc/hide_title_screen()
	if(client?.mob)
		winset(client, "title_browser", "is-disabled=true;is-visible=false")

/mob/dead/new_player/proc/play_lobby_button_sound()
	SEND_SOUND(src, sound('modular_skyrat/master_files/sound/effects/save.ogg'))

/**
 * Selects a new job or gives random if unset.
 */
/mob/dead/new_player/proc/select_job(job)
	if(job == "Random")
		var/list/dept_data = list()
		for(var/datum/job_department/department as anything in SSjob.joinable_departments)
			for(var/datum/job/job_datum as anything in department.department_jobs)
				if(IsJobUnavailable(job_datum.title, TRUE) != JOB_AVAILABLE)
					continue
				dept_data += job_datum.title
		var/random = pick(dept_data)
		var/randomjob = "<p><center><a href='byond://?src=[REF(src)];SelectedJob=[random]'>[random]</a></center><center><a href='byond://?src=[REF(src)];SelectedJob=Random'>Reroll</a></center><center><a href='byond://?src=[REF(src)];cancrand=[1]'>Cancel</a></center></p>"
		var/datum/browser/popup = new(src, "randjob", "<div align='center'>Random Job</div>", 200, 150)
		popup.set_window_options("can_close=0")
		popup.set_content(randomjob)
		popup.open(FALSE)
		return

	if(!SSticker?.IsRoundInProgress())
		to_chat(usr, span_danger("The round is either not ready, or has already finished..."))
		return

	if(SSlag_switch.measures[DISABLE_NON_OBSJOBS])
		to_chat(usr, span_notice("There is an administrative lock on entering the game!"))
		return

	//Determines Relevent Population Cap
	var/relevant_cap
	var/hard_popcap = CONFIG_GET(number/hard_popcap)
	var/extreme_popcap = CONFIG_GET(number/extreme_popcap)
	if(hard_popcap && extreme_popcap)
		relevant_cap = min(hard_popcap, extreme_popcap)
	else
		relevant_cap = max(hard_popcap, extreme_popcap)

	if(LAZYLEN(SSticker.queued_players) && !(ckey(key) in GLOB.admin_datums))
		if((living_player_count() >= relevant_cap) || (src != SSticker.queued_players[1]))
			to_chat(usr, span_warning("Server is full."))
			return

	AttemptLateSpawn(job)

/**
 * Allows the player to select a server to join from any loaded servers.
 */
/mob/dead/new_player/proc/server_swap()
	var/list/servers = CONFIG_GET(keyed_list/cross_server)
	if(LAZYLEN(servers) == 1)
		var/server_name = servers[1]
		var/server_ip = servers[server_name]
		var/confirm = tgui_alert(src, "Are you sure you want to swap to [server_name] ([server_ip])?", "Swapping server!", list("Send me there", "Stay here"))
		if(confirm == "Connect me!")
			to_chat_immediate(src, "So long, spaceman.")
			client << link(server_ip)
		return
	var/server_name = tgui_input_list(src, "Please select the server you wish to swap to:", "Swap servers!", servers)
	if(!server_name)
		return
	var/server_ip = servers[server_name]
	var/confirm = tgui_alert(src, "Are you sure you want to swap to [server_name] ([server_ip])?", "Swapping server!", list("Connect me!", "Stay here!"))
	if(confirm == "Connect me!")
		to_chat_immediate(src, "So long, spaceman.")
		src.client << link(server_ip)

/**
 * Shows the player a list of current polls, if any.
 */
/mob/dead/new_player/proc/playerpolls()
	var/output
	if (!SSdbcore.Connect())
		return
	var/isadmin = FALSE
	if(client?.holder)
		isadmin = TRUE
	var/datum/db_query/query_get_new_polls = SSdbcore.NewQuery({"
		SELECT id FROM [format_table_name("poll_question")]
		WHERE (adminonly = 0 OR :isadmin = 1)
		AND Now() BETWEEN starttime AND endtime
		AND deleted = 0
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_vote")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
		AND id NOT IN (
			SELECT pollid FROM [format_table_name("poll_textreply")]
			WHERE ckey = :ckey
			AND deleted = 0
		)
	"}, list("isadmin" = isadmin, "ckey" = ckey))

	if(!query_get_new_polls.Execute())
		qdel(query_get_new_polls)
		return
	if(query_get_new_polls.NextRow())
		output +={"<a class="menu_button menu_newpoll" href='?src=\ref[src];viewpoll=1'>POLLS (NEW)</a>"}
	else
		output +={"<a class="menu_button" href='?src=\ref[src];viewpoll=1'>POLLS</a>"}
	qdel(query_get_new_polls)
	if(QDELETED(src))
		return
	return output
