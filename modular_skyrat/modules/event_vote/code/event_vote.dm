/**
 * A simple voting system to replace the current random events, if no votes are recieved, it will be random.
 */

/// How long does the vote last?
#define EVENT_VOTE_TIME 1 MINUTES

/datum/controller/subsystem/events
	/// List of current events and votes
	var/list/votes = list()
	/// Is the current vote admin only?
	var/admin_only = TRUE
	/// If we are not admin only, do we show the votes and vote outcome?
	var/show_votes = FALSE
	/// Is there currently a vote in progress?
	var/vote_in_progress = FALSE
	/// When the vote will end
	var/vote_end_time = 0
	/// Our current timer ID.
	var/timer_id
	/// A reference to our generated actions, for deletion later.
	var/generated_actions = list()

/// Starts a vote.
/datum/controller/subsystem/events/proc/start_vote()
	if(!LAZYLEN(GLOB.admins)) // If there are no admins online, just revert to the normal system.
		spawnEvent()
		return
	if(vote_in_progress) // We don't want two votes at once.
		message_admins("EVENT: Attempted to start a vote while one was already in progress.")
		return

	// Direct chat link is good.
	message_admins("EVENT: Vote started for next event! (<a href='?src=[REF(src)];[HrefToken()];open_panel=1'>Vote!</a>)")

	for(var/client/admin_client in GLOB.admins)
		var/datum/action/vote_event/event_action = new
		admin_client.player_details.player_actions += event_action
		event_action.Grant(admin_client.mob)
		generated_actions += event_action
		if(admin_client?.prefs?.toggles & SOUND_ADMINHELP)
			SEND_SOUND(admin_client.mob, sound('sound/misc/bloop.ogg')) // Admins need a little boop.

	timer_id = addtimer(CALLBACK(src, .proc/end_vote), EVENT_VOTE_TIME, TIMER_STOPPABLE)
	vote_in_progress = TRUE
	vote_end_time = world.time + EVENT_VOTE_TIME

/datum/controller/subsystem/events/proc/start_player_vote(mob/user)
	if(vote_in_progress) // We don't want two votes at once.
		message_admins("EVENT: Attempted to start a vote while one was already in progress.")
		return

	var/alert_vote = tgui_alert(user, "Do you want to show the vote outcome?", "Vote outcome", list("Yes", "No"))

	if(alert_vote == "Yes")
		show_votes = TRUE
	else
		show_votes = FALSE

	// Direct chat link is good.
	for(var/mob/iterating_user in GLOB.player_list)
		to_chat(iterating_user, span_infoplain(span_purple("<b>EVENT: Vote started for next event! (<a href='?src=[REF(src)];open_panel=1'>Vote!</a>)</b>")))
		SEND_SOUND(iterating_user, sound('sound/misc/bloop.ogg')) // a little boop.

	for(var/client/iterating_client in GLOB.clients)
		var/datum/action/vote_event/event_action = new
		iterating_client.player_details.player_actions += event_action
		event_action.Grant(iterating_client.mob)
		generated_actions += event_action

	timer_id = addtimer(CALLBACK(src, .proc/end_vote), EVENT_VOTE_TIME)
	vote_in_progress = TRUE
	admin_only = FALSE
	vote_end_time = world.time + EVENT_VOTE_TIME

/// Cancels a vote outright, and does not execute the event.
/datum/controller/subsystem/events/proc/cancel_vote(mob/user)
	if(!vote_in_progress)
		return
	message_admins("EVENT: [key_name_admin(user)] cancelled the current vote.")
	reset()

/// Ends the vote there and then, and executes the event.
/datum/controller/subsystem/events/proc/end_vote()
	if(!LAZYLEN(votes))
		message_admins("EVENT: No votes cast, spawning random event!")
		if(show_votes && !admin_only)
			for(var/mob/iterating_user in GLOB.player_list)
				to_chat(iterating_user, span_infoplain(span_purple("<b>EVENT: No votes cast, spawning random event!</b>")))
		reset()
		spawnEvent()
		return

	var/list/event_weighted_list = list() //We convert the list of votes into a weighted list.

	for(var/iterating_event in votes)
		event_weighted_list[iterating_event] = LAZYLEN(votes[iterating_event])

	var/highest_weight = 0
	var/list/tying_results = list() // If we have a tie, pick a random one from the tie.
	var/datum/round_event_control/winner
	for(var/iterating_event in event_weighted_list)
		if(event_weighted_list[iterating_event] > highest_weight)
			highest_weight = event_weighted_list[iterating_event]
			winner = iterating_event
			tying_results = list() // Clear the tying results if there's a higher winner
		if(event_weighted_list[iterating_event] == highest_weight)
			tying_results += iterating_event

	if(LAZYLEN(tying_results) > 1) // If there's a tie, we need to pick a random one.
		to_chat(world, "tied vote")
		winner = pick(tying_results)

	if(!winner) //If for whatever reason the algorithm breaks, we still want an event.
		message_admins("EVENT: Vote error, spawning random event!")
		if(show_votes && !admin_only)
			for(var/mob/iterating_user in GLOB.player_list)
				to_chat(iterating_user, span_infoplain(span_purple("<b>EVENT: Vote error, spawning random event!</b>")))
		reset()
		spawnEvent()
		return

	message_admins("EVENT: Vote ended! Winning Event: [winner.name]")
	if(show_votes && !admin_only)
		for(var/mob/iterating_user in GLOB.player_list)
			to_chat(iterating_user, span_infoplain(span_purple("<b>EVENT: Vote ended! Winning Event: [winner.name]</b>")))
	winner.runEvent(TRUE)
	reset()

/// Proc to reset the vote system to be ready for a new vote.
/datum/controller/subsystem/events/proc/reset()
	remove_action_buttons()
	vote_in_progress = FALSE
	vote_end_time = 0
	admin_only = TRUE
	show_votes = FALSE
	votes = list()
	if(timer_id)
		deltimer(timer_id)
		timer_id = null

/// Simply registeres someones vote.
/datum/controller/subsystem/events/proc/register_vote(mob/user, datum/round_event_control/event)
	if(!(event in votes))
		votes[event] = list()

	var/true_ckey = ckey(user.ckey)

	if(true_ckey in votes[event])
		return

	for(var/iterating_event in votes) // We first check if the user has already voted for something
		if(true_ckey in votes[iterating_event])
			votes[iterating_event] -= true_ckey // If they have, we remove that vote

	votes[event] += true_ckey // Then we add the new vote

	for(var/iterating_event in votes) // We have to check if the votes have nothing in them AFTER we have added the clients vote
		if(LAZYLEN(votes[iterating_event]) <= 0)
			votes -= iterating_event

/// Checks what someone has voted for, if anything.
/datum/controller/subsystem/events/proc/check_vote(ckey)
	var/true_ckey = ckey(ckey)
	for(var/datum/round_event_control/iterating_event in votes)
		if(true_ckey in votes[iterating_event])
			return iterating_event.type
	return FALSE

/// Event can_spawn for the event voting system.
/datum/round_event_control/proc/can_spawn_vote(players_amt)
	if(earliest_start >= world.time-SSticker.round_start_time)
		return FALSE
	if(wizardevent != SSevents.wizardmode)
		return FALSE
	if(players_amt < min_players)
		return FALSE
	if(holidayID && (!SSevents.holidays || !SSevents.holidays[holidayID]))
		return FALSE
	if(EMERGENCY_ESCAPED_OR_ENDGAMED)
		return FALSE
	if(ispath(typepath, /datum/round_event/ghost_role) && !(GLOB.ghost_role_flags & GHOSTROLE_MIDROUND_EVENT))
		return FALSE

	var/datum/game_mode/dynamic/dynamic = SSticker.mode
	if (istype(dynamic) && dynamic_should_hijack && dynamic.random_event_hijacked != HIJACKED_NOTHING)
		return FALSE

	return TRUE

/datum/controller/subsystem/events/proc/remove_action_buttons()
	for(var/datum/action/vote_event/iterating_action in generated_actions)
		if(!QDELETED(iterating_action))
			iterating_action.remove_from_client()
			iterating_action.Remove(iterating_action.owner)
	generated_actions = list()

/datum/controller/subsystem/events/proc/reschedule_custom(time)
	if(!time)
		scheduled = world.time + rand(frequency_lower, max(frequency_lower,frequency_upper))
	else
		scheduled = world.time + time

/datum/controller/subsystem/events/Topic(href, list/href_list)
	..()
	if(admin_only && !check_rights(R_ADMIN, FALSE))
		return
	if(href_list["open_panel"])
		ui_interact(usr)

/datum/controller/subsystem/events/ui_interact(mob/user, datum/tgui/ui)
	if(admin_only && !check_rights_for(user.client, R_ADMIN))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EventPanel")
		ui.open()

/datum/controller/subsystem/events/ui_state(mob/user)
	return GLOB.always_state

/datum/controller/subsystem/events/ui_data(mob/user)
	if(admin_only && !check_rights_for(user.client, R_ADMIN))
		return
	var/list/data = list()

	data["end_time"] = (vote_end_time - world.time) / 10

	data["vote_in_progress"] = vote_in_progress

	data["admin_mode"] = check_rights_for(user.client, R_ADMIN)

	data["next_vote_time"] = (scheduled - world.time) / 10

	data["show_votes"] = show_votes

	data["previous_events"] = list()

	for(var/datum/round_event_control/iterating_event in previously_run)
		data["previous_events"] += iterating_event.name

	data["votes"] = list()

	for(var/datum/round_event_control/iterating_event in votes)
		data["votes"] += list(list(
			"name" = iterating_event.name,
			"votes" = LAZYLEN(votes[iterating_event]),
			"ref" = REF(iterating_event),
		))

	// Build a list of runnable events.
	data["event_list"] = list()
	for(var/datum/round_event_control/iterating_event in SSevents.control)
		if(!iterating_event.can_spawn_vote(get_active_player_count(TRUE, TRUE, TRUE)))
			continue

		var/self_selected = istype(iterating_event, check_vote(user.ckey)) ? TRUE : FALSE

		data["event_list"] += list(list(
			"name" = iterating_event.name,
			"ref" = REF(iterating_event),
			"self_vote" = self_selected
		))

	return data

/datum/controller/subsystem/events/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(admin_only && !check_rights(R_ADMIN, FALSE))
		return

	switch(action)
		if("register_vote")
			var/selected_event = locate(params["event_ref"]) in SSevents.control
			if(!selected_event)
				return
			register_vote(usr, selected_event)
			return
		if("end_vote")
			if(!check_rights(R_PERMISSIONS))
				return
			end_vote(usr)
			return
		if("cancel_vote")
			if(!check_rights(R_PERMISSIONS))
				return
			cancel_vote(usr)
			return
		if("start_vote")
			if(!check_rights(R_PERMISSIONS))
				return
			start_vote()
			return
		if("start_player_vote")
			if(!check_rights(R_PERMISSIONS))
				return
			start_player_vote()
			return
		if("reschedule")
			if(!check_rights(R_PERMISSIONS))
				return
			var/alert = tgui_alert(usr, "Set custom time?", "Custom time", list("Yes", "No"))
			if(!alert)
				return
			var/time
			if(alert == "Yes")
				time = tgui_input_number(usr, "Input custom time in seconds", "Custom time", 60, 6000, 1) * 10
			reschedule_custom(time)
			message_admins("[key_name_admin(usr)] has rescheduled the event system.")
			return

// Panel for admins
/client/proc/event_panel()
	set category = "Admin.Fun"
	set name = "Event Panel"

	SSevents.ui_interact(usr)

// Panel for everyone
/mob/verb/event_vote()
	set category = "OOC"
	set name = "Event Vote"
	if(!SSevents.vote_in_progress)
		to_chat(usr, span_warning("No vote in progress."))
		return
	if(SSevents.admin_only && !check_rights(R_ADMIN, FALSE))
		to_chat(usr, span_warning("You do not have permission to vote."))
		return
	SSevents.ui_interact(usr)

/datum/action/vote_event
	name = "Event Vote!"
	button_icon_state = "vote"

/datum/action/vote_event/Trigger(trigger_flags)
	if(owner)
		owner.event_vote()
		remove_from_client()
		Remove(owner)

/datum/action/vote_event/IsAvailable()
	return TRUE

/datum/action/vote_event/proc/remove_from_client()
	if(!owner)
		return
	if(owner.client)
		owner.client.player_details.player_actions -= src
	else if(owner.ckey)
		var/datum/player_details/player_deets = GLOB.player_details[owner.ckey]
		if(player_deets)
			player_deets.player_actions -= src
