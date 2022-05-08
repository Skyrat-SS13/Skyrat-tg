/// Define to mimic a span macro but for the purple font that vote specifically uses.
#define vote_font(text) ("<font color='purple'>" + text + "</font>")

SUBSYSTEM_DEF(vote)
	name = "Vote"
	wait = 1 SECONDS
	flags = SS_KEEP_TIMING
	runlevels = RUNLEVEL_LOBBY | RUNLEVELS_DEFAULT

	/// A list of all generated action buttons
	var/list/datum/action/generated_actions = list()
	/// All votes that we can possible vote for.
	var/list/datum/vote/possible_votes = list()
	/// The vote we're currently voting on.
	var/datum/vote/current_vote
	/// A list of all ckeys who have voted for the current vote.
	var/list/voted = list()
	/// A list of all ckeys currently voting for the current vote.
	var/list/voting = list()

/datum/controller/subsystem/vote/Initialize(start_timeofday)
	for(var/vote_type in subtypesof(/datum/vote))
		var/datum/vote/vote = new vote_type()
		if(!vote.is_accessible_vote())
			qdel(vote)
			continue

		possible_votes[vote.name] = vote

	return ..()


// Called by master_controller
/datum/controller/subsystem/vote/fire()
	if(!current_vote)
		return
	current_vote.time_remaining = round((current_vote.started_time + CONFIG_GET(number/vote_period) - world.time) / 10)
	if(current_vote.time_remaining < 0)
		process_vote_result()
		SStgui.close_uis(src)
		reset()

/// Resets all of our vars after votes conclude / are cancelled.
/datum/controller/subsystem/vote/proc/reset()
	voted.Cut()
	voting.Cut()

	current_vote?.reset()
	current_vote = null

	for(var/datum/action/vote/voting_action as anything in generated_actions)
		if(QDELETED(voting_action))
			continue
		voting_action.Remove(voting_action.owner)

	generated_actions.Cut()

<<<<<<< HEAD
/datum/controller/subsystem/vote/proc/result()
	. = announce_result()
	var/restart = FALSE
	if(.)
		switch(mode)
			if("restart")
				if(. == "Restart Round")
					restart = TRUE
			if("map")
				SSmapping.changemap(global.config.maplist[.])
				SSmapping.map_voted = TRUE
			//SKYRAT EDIT ADDITION BEGIN
			if("transfer")
				if(. == "Initiate Crew Transfer")
					SSshuttle.autoEnd()
					var/obj/machinery/computer/communications/C = locate() in GLOB.machines
					if(C)
						C.post_status("shuttle")
			//SKYRAT EDIT ADDITION END
	if(restart)
		var/active_admins = FALSE
		for(var/client/C in GLOB.admins + GLOB.deadmins)
			if(!C.is_afk() && check_rights_for(C, R_SERVER))
				active_admins = TRUE
				break
		if(!active_admins)
			// No delay in case the restart is due to lag
			SSticker.Reboot("Restart vote successful.", "restart vote", 1)
		else
			to_chat(world, span_boldannounce("Notice: Restart vote will not restart the server automatically because there are active admins on."))
			message_admins("A restart vote has passed, but there are active admins on with +server, so it has been canceled. If you wish, you may restart the server.")
=======
	SStgui.update_uis(src)
>>>>>>> 6e098e2dbaa (Refactors SSvote, makes votes into datums, also makes vote ui Typescript (#66772))

/**
 * Process the results of the vote.
 * Collects all the winners, breaks any ties that occur,
 * prints the results of the vote to the world,
 * and finally follows through with the effects of the vote.
 */
/datum/controller/subsystem/vote/proc/process_vote_result()

	// First collect all the non-voters we have.
	var/list/non_voters = GLOB.directory.Copy() - voted
	// Remove AFK or clientless non-voters.
	for(var/non_voter_ckey in non_voters)
		var/client/non_voter_client = non_voters[non_voter_ckey]
		if(!non_voter_client || non_voter_client.is_afk())
			non_voters -= non_voter_ckey

	// Now get the result of the vote.
	// This is a list, as we could have a tie (multiple winners).
	var/list/winners = current_vote.get_vote_result(non_voters)

	// Now we should determine who actually won the vote.
	var/final_winner
	// 1 winner? That's the winning option
	if(length(winners) == 1)
		final_winner = winners[1]

	// More than 1 winner? Tiebreaker between all the winners
	else if(length(winners) > 1)
		final_winner = current_vote.tiebreaker(winners)

	// Announce the results of the vote to the world.
	var/to_display = current_vote.get_result_text(winners, final_winner, non_voters)

	log_vote(to_display)
	to_chat(world, span_infoplain(vote_font("\n[to_display]")))

	// Finally, doing any effects on vote completion
	current_vote.finalize_vote(final_winner)

/datum/controller/subsystem/vote/proc/submit_vote(mob/voter, their_vote)
	if(!current_vote)
		return
	if(!voter?.ckey)
		return
	if(CONFIG_GET(flag/no_dead_vote) && voter.stat == DEAD && !voter.client?.holder)
		return

	// If user has already voted, remove their specific vote
	if(voter.ckey in current_vote.choices_by_ckey)
		var/their_old_vote = current_vote.choices_by_ckey[voter.ckey]
		current_vote.choices[their_old_vote]--

	else
		voted += voter.ckey

	current_vote.choices_by_ckey[voter.ckey] = their_vote
	current_vote.choices[their_vote]++
	return TRUE

/**
 * Initiates a vote, allowing all players to vote on something.
 *
 * * vote_type - The type of vote to initiate. Can be a [/datum/vote] typepath, a [/datum/vote] instance, or the name of a vote datum.
 * * vote_initiator_name - The ckey (if player initiated) or name that initiated a vote. Ex: "UristMcAdmin", "the server"
 * * vote_initiator - If a person / mob initiated the vote, this is the mob that did it
 * * forced - Whether we're forcing the vote to go through regardless of existing votes or other circumstances. Note: If the vote is admin created, forced becomes true regardless.
 */
/datum/controller/subsystem/vote/proc/initiate_vote(vote_type, vote_initiator_name, mob/vote_initiator, forced = FALSE)

	// Even if it's forced we can't vote before we're set up
	if(!MC_RUNNING(init_stage))
		if(vote_initiator)
			to_chat(vote_initiator, span_warning("You cannot start vote now, the server is not done initializing."))
		return FALSE

	// Check if we have unlimited voting power.
	// Admin started (or forced) voted will go through even if there's an ongoing vote,
	// if voting is on cooldown, or regardless if a vote is config disabled (in some cases)
	var/unlimited_vote_power = forced || !!GLOB.admin_datums[vote_initiator?.ckey]

<<<<<<< HEAD
		reset()
		switch(vote_type)
			if("restart")
				choices.Add("Restart Round","Continue Playing")
			if("map")
				if(!lower_admin && SSmapping.map_voted)
					to_chat(usr, span_warning("The next map has already been selected."))
					return FALSE
				// Randomizes the list so it isn't always METASTATION
				var/list/maps = list()
				for(var/map in global.config.maplist)
					var/datum/map_config/VM = config.maplist[map]
					if(!VM.votable || (VM.map_name in SSpersistence.blocked_maps) || GLOB.clients.len >= VM.config_max_users || GLOB.clients.len <= VM.config_min_users) //SKYRAT EDIT CHANGE - ORIGINAL: if(!VM.votable || (VM.map_name in SSpersistence.blocked_maps))
						continue
					if (VM.config_min_users > 0 && GLOB.clients.len < VM.config_min_users)
						continue
					if (VM.config_max_users > 0 && GLOB.clients.len > VM.config_max_users)
						continue
					maps += VM.map_name
					shuffle_inplace(maps)
				for(var/valid_map in maps)
					choices.Add(valid_map)
			if("custom")
				question = tgui_input_text(usr, "What is the vote for?", "Custom Vote")
				if(!question)
					return FALSE
				for(var/i in 1 to 10)
					var/option = tgui_input_text(usr, "Please enter an option or hit cancel to finish", "Options", max_length = MAX_NAME_LEN)
					if(!option || mode || !usr.client)
						break
					choices.Add(capitalize(option))
			//SKYRAT EDIT ADDITION BEGIN - AUTOTRANSFER
			if("transfer")
				choices.Add("Initiate Crew Transfer", "Continue Playing")
			//SKYRAT EDIT ADDITION END - AUTOTRANSFER
			else
				return FALSE
		mode = vote_type
		initiator = initiator_key
		started_time = world.time
		var/text = "[capitalize(mode)] vote started by [initiator || "CentCom"]."
		if(mode == "custom")
			text += "\n[question]"
		log_vote(text)
		var/vp = CONFIG_GET(number/vote_period)
		to_chat(world, "\n<span class='infoplain'><font color='purple'><b>[text]</b>\nType <b>vote</b> or click <a href='byond://winset?command=vote'>here</a> to place your votes.\nYou have [DisplayTimeText(vp)] to vote.</font></span>")
		time_remaining = round(vp/10)
		for(var/c in GLOB.clients)
			var/client/C = c
			var/datum/action/vote/V = new
			if(question)
				V.name = "Vote: [question]"
			C.player_details.player_actions += V
			V.Grant(C.mob)
			generated_actions += V
			if(C.prefs.toggles & SOUND_ANNOUNCEMENTS)
			//SKYRAT EDIT START
			/*
				SEND_SOUND(C, sound('sound/misc/bloop.ogg'))
			*/
				SEND_SOUND(C, sound('sound/misc/announce_dig.ogg'))
			//SKYRAT EDIT END
		return TRUE
	return FALSE
=======
	if(current_vote && !unlimited_vote_power)
		if(vote_initiator)
			to_chat(vote_initiator, span_warning("There is already a vote in progress! Please wait for it to finish."))
		return FALSE
>>>>>>> 6e098e2dbaa (Refactors SSvote, makes votes into datums, also makes vote ui Typescript (#66772))

	// Get our actual datum
	var/datum/vote/to_vote
	// If we were passed a path: find the path in possible_votes
	if(ispath(vote_type, /datum/vote))
		var/datum/vote/vote_path = vote_type
		to_vote = possible_votes[initial(vote_path.name)]

	// If we were passed an instance: use the instance
	else if(istype(vote_type, /datum/vote))
		to_vote = vote_type

	// If we got neither a path or an instance, it could be a vote name, but is likely just an error / null
	else
		to_vote = possible_votes[vote_type]
		if(!to_vote)
			stack_trace("Voting initiate_vote was passed an invalid vote type. (Got: [vote_type || "null"])")

	// No valid vote found? No vote
	if(!istype(to_vote))
		if(vote_initiator)
			to_chat(vote_initiator, span_warning("Invalid voting choice."))
		return FALSE

	// Vote can't be initiated in our circumstances? No vote
	if(!to_vote.can_be_initiated(vote_initiator, unlimited_vote_power))
		return FALSE

	// Okay, we're ready to actually create a vote -
	// Do a reset, just to make sure
	reset()

	// Try to create the vote. If the creation fails, no vote
	if(!to_vote.create_vote(vote_initiator))
		return FALSE

	// Okay, the vote's happening now, for real. Set it up.
	current_vote = to_vote

	var/duration = CONFIG_GET(number/vote_period)
	var/to_display = current_vote.initiate_vote(vote_initiator_name, duration)

	log_vote(to_display)
	to_chat(world, span_infoplain(vote_font("\n[span_bold(to_display)]\n\
		Type <b>vote</b> or click <a href='byond://winset?command=vote'>here</a> to place your votes.\n\
		You have [DisplayTimeText(duration)] to vote.")))

	// And now that it's going, give everyone a voter action
	for(var/client/new_voter as anything in GLOB.clients)
		var/datum/action/vote/voting_action = new()
		voting_action.name = "Vote: [current_vote.override_question || current_vote.name]"
		voting_action.Grant(new_voter.mob)

		new_voter.player_details.player_actions += voting_action
		generated_actions += voting_action

		if(current_vote.vote_sound && (new_voter.prefs.toggles & SOUND_ANNOUNCEMENTS))
			SEND_SOUND(new_voter, sound(current_vote.vote_sound))

	return TRUE

/datum/controller/subsystem/vote/ui_state()
	return GLOB.always_state

/datum/controller/subsystem/vote/ui_interact(mob/user, datum/tgui/ui)
	// Tracks who is currently voting
	voting |= user.client?.ckey
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "VotePanel")
		ui.open()

/datum/controller/subsystem/vote/ui_data(mob/user)
	var/list/data = list()

	var/is_lower_admin = !!user.client?.holder
	var/is_upper_admin = check_rights_for(user.client, R_ADMIN)

	data["user"] = list(
		"isLowerAdmin" = is_lower_admin,
		"isUpperAdmin" = is_upper_admin,
		// What the current user has selected in any ongoing votes.
		"selectedChoice" = current_vote?.choices_by_ckey[user.client?.ckey],
	)

	data["voting"]= is_lower_admin ? voting : list()

	var/list/all_vote_data = list()
	for(var/vote_name in possible_votes)
		var/datum/vote/vote = possible_votes[vote_name]
		if(!istype(vote))
			continue

		var/list/vote_data = list(
			"name" = vote_name,
			"canBeInitiated" = vote.can_be_initiated(forced = is_lower_admin),
			"config" = vote.is_config_enabled(),
		)

		if(vote == current_vote)
			var/list/choices = list()
			for(var/key in current_vote.choices)
				choices += list(list(
					"name" = key,
					"votes" = current_vote.choices[key],
				))

			data["currentVote"] = list(
				"name" = current_vote.name,
				"question" = current_vote.override_question,
				"timeRemaining" = current_vote.time_remaining,
				"choices" = choices,
				"vote" = vote_data,
			)

		all_vote_data += list(vote_data)

	data["possibleVotes"] = all_vote_data

	return data

/datum/controller/subsystem/vote/ui_act(action, params)
	. = ..()
	if(.)
		return

	var/mob/voter = usr

	switch(action)
		if("cancel")
<<<<<<< HEAD
			if(usr.client.holder)
				usr.log_message("[key_name_admin(usr)] cancelled a vote.", LOG_ADMIN)
				message_admins("[key_name_admin(usr)] has cancelled the current vote.")
				reset()
		if("toggle_restart")
			if(usr.client.holder && upper_admin)
				CONFIG_SET(flag/allow_vote_restart, !CONFIG_GET(flag/allow_vote_restart))
		if("toggle_map")
			if(usr.client.holder && upper_admin)
				CONFIG_SET(flag/allow_vote_map, !CONFIG_GET(flag/allow_vote_map))
		if("restart")
			if(CONFIG_GET(flag/allow_vote_restart) || usr.client.holder)
				initiate_vote("restart",usr.key)
		if("map")
			if(CONFIG_GET(flag/allow_vote_map) || usr.client.holder)
				initiate_vote("map",usr.key)
		//SKYRAT EDIT ADDITION
		if("mining_map")
			if(CONFIG_GET(flag/allow_vote_map) || usr.client.holder)
				initiate_vote("mining_map",usr.key)
		//SKYRAT EDIT END
		if("custom")
			if(usr.client.holder)
				initiate_vote("custom",usr.key)
		//SKYRAT EDIT ADDITION BEGIN - autotransfer
		if("transfer")
			if(usr.client.holder && upper_admin)
				initiate_vote("transfer",usr.key)
		//SKYRAT EDIT ADDITION END
		if("vote")
			submit_vote(round(text2num(params["index"])))
	return TRUE
=======
			if(!voter.client?.holder)
				return
>>>>>>> 6e098e2dbaa (Refactors SSvote, makes votes into datums, also makes vote ui Typescript (#66772))

			voter.log_message("[key_name_admin(voter)] cancelled a vote.", LOG_ADMIN)
			message_admins("[key_name_admin(voter)] has cancelled the current vote.")
			reset()
			return TRUE

		if("toggleVote")
			var/datum/vote/selected = possible_votes[params["voteName"]]
			if(!istype(selected))
				return

			return selected.toggle_votable(voter)

		if("callVote")
			var/datum/vote/selected = possible_votes[params["voteName"]]
			if(!istype(selected))
				return

			// Whether the user actually can initiate this vote is checked in initiate_vote,
			// meaning you can't spoof initiate a vote you're not supposed to be able to
			return initiate_vote(selected, voter.key, voter)

		if("vote")
			return submit_vote(voter, params["voteOption"])

/datum/controller/subsystem/vote/ui_close(mob/user)
	voting -= user.client?.ckey

/// Mob level verb that allows players to vote on the current vote.
/mob/verb/vote()
	set category = "OOC"
	set name = "Vote"

	SSvote.ui_interact(usr)

/// Datum action given to mobs that allows players to vote on the current vote.
/datum/action/vote
	name = "Vote!"
	button_icon_state = "vote"

/datum/action/vote/IsAvailable()
	return TRUE // Democracy is always available to the free people

/datum/action/vote/Trigger(trigger_flags)
	. = ..()
	if(!.)
		return

	owner.vote()
	Remove(owner)

// We also need to remove our action from the player actions when we're cleaning up.
/datum/action/vote/Remove(mob/removed_from)
	if(removed_from.client)
		removed_from.client?.player_details.player_actions -= src

	else if(removed_from.ckey)
		var/datum/player_details/associated_details = GLOB.player_details[removed_from.ckey]
		associated_details?.player_actions -= src

	return ..()

#undef vote_font
