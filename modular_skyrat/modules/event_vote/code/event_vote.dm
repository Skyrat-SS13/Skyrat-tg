/**
 * A simple voting system to replace the current random events, if no votes are recieved, it will be random.
 */

/// How long does the vote last?
#define EVENT_VOTE_TIME 1 MINUTES

/datum/controller/subsystem/events
	/// List of current events and votes
	var/list/votes = list()

	/// Is there currently a vote in progress?
	var/vote_in_progress = FALSE
	/// When the vote will end
	var/vote_end_time = 0
	/// Our current timer ID.
	var/timer_id

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
		if(admin_client?.prefs?.toggles & SOUND_ADMINHELP)
			SEND_SOUND(admin_client.mob, sound('sound/misc/bloop.ogg')) // Admins need a little boop.

	timer_id = addtimer(CALLBACK(src, .proc/end_vote), EVENT_VOTE_TIME)

	vote_in_progress = TRUE

	vote_end_time = world.time + EVENT_VOTE_TIME

/// Cancels a vote outright, and does not execute the event.
/datum/controller/subsystem/events/proc/cancel_vote(mob/user)
	if(!vote_in_progress)
		return
	message_admins("EVENT: [key_name_admin(user)] cancelled the current vote.")
	deltimer(timer_id)
	timer_id = null
	vote_in_progress = FALSE
	vote_end_time = 0
	votes = list()

/// Ends the vote there and then, and executes the event.
/datum/controller/subsystem/events/proc/end_vote()
	if(!LAZYLEN(votes))
		vote_in_progress = FALSE
		vote_end_time = 0
		votes = list()
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		message_admins("EVENT: No votes cast, spawning random event!")
		spawnEvent()
		return

	var/list/event_weighted_list = list() //We convert the list of votes into a weighted list.

	for(var/iterating_event in votes)
		event_weighted_list[iterating_event] = LAZYLEN(votes[iterating_event])

	var/highest_weight = 0
	var/datum/round_event_control/winner
	for(var/iterating_event in event_weighted_list)
		if(event_weighted_list[iterating_event] > highest_weight)
			highest_weight = event_weighted_list[iterating_event]
			winner = iterating_event

	if(!winner) //If for whatever reason the algorithm breaks, we still want an event.
		message_admins("EVENT: Vote error, spawning random event!")
		vote_in_progress = FALSE
		vote_end_time = 0
		votes = list()
		if(timer_id)
			deltimer(timer_id)
			timer_id = null
		spawnEvent()
		return

	message_admins("EVENT: Vote ended! Winning Event: [winner.name]")

	winner.runEvent(TRUE)

	vote_in_progress = FALSE
	vote_end_time = 0
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

/datum/controller/subsystem/events/Topic(href, list/href_list)
	. = ..()
	if (.)
		return
	if(!check_rights(R_ADMIN))
		return
	if(href_list["open_panel"])
		ui_interact(usr)

/datum/controller/subsystem/events/ui_interact(mob/user, datum/tgui/ui)
	if(!check_rights_for(user.client, R_ADMIN))
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "EventPanel")
		ui.open()

/datum/controller/subsystem/events/ui_state(mob/user)
	return GLOB.always_state

/datum/controller/subsystem/events/ui_data(mob/user)
	var/list/data = list()

	data["end_time"] = (vote_end_time - world.time) / 10

	data["vote_in_progress"] = vote_in_progress

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

	if(!check_rights(R_ADMIN))
		return

	switch(action)
		if("register_vote")
			var/selected_event = locate(params["event_ref"]) in SSevents.control
			if(!selected_event)
				return
			register_vote(usr, selected_event)
			return
		if("end_vote")
			if(!check_rights(R_SERVER))
				return
			end_vote(usr)
			return
		if("cancel_vote")
			if(!check_rights(R_SERVER))
				return
			cancel_vote(usr)
			return
		if("start_vote")
			if(!check_rights(R_SERVER))
				return
			start_vote()
			return

/client/proc/event_panel()
	set category = "Admin.Fun"
	set name = "Event Panel"

	SSevents.ui_interact(usr)
