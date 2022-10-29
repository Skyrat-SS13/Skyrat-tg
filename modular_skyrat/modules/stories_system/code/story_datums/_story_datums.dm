/datum/story_type
	/// Name of the story
	var/name = "Parent Story"
	/// A rough description of the story and what it does
	var/desc = "Parent story description"
	/// How impactful the story is (and how much budget it costs)
	var/impact = STORY_UNIMPACTFUL
	/// Assoc list of actor datums to create in the form of 'actor typepath:amount'
	var/list/actor_datums_to_make = list()
	/// Assoc list of mind ref:actor ref involved in the story
	var/list/mind_actor_list = list()

/datum/story_type/Destroy(force, ...)
	return ..()

/// General checks to see if we can actually run
/datum/story_type/proc/can_execute()
	SHOULD_CALL_PARENT(TRUE)
	if(impact > SSstories.budget)
		return FALSE
	return TRUE

/// The general proc That Does Things, may get split later
/datum/story_type/proc/execute_story()
	var/involves_ghosts = 0
	var/involves_crew = 0
	for(var/datum/story_actor/actor_path as anything in actor_datums_to_make)
		if(initial(actor_path.ghost_actor))
			involves_ghosts++
		else
			involves_crew++

	var/list/ghost_list
	var/list/player_list
	if(involves_ghosts)
		ghost_list = get_ghosts(involves_ghosts)
	if(involves_crew)
		player_list = get_players(involves_crew)
	if((involves_ghosts && !length(ghost_list)) || (involves_crew && !length(player_list)))
		return FALSE

	for(var/actor_path in actor_datums_to_make)
		var/datum/story_actor/actor_datum = new actor_path(src)
		if(actor_datum.ghost_actor)
			actor_datum.handle_spawning(pick_n_take(ghost_list), src)
		else
			actor_datum.handle_spawning(pick_n_take(player_list), src)

	return TRUE

/// A proc for getting a list of ghosts and returning an equal amount to `ghosts_involved`
/datum/story_type/proc/get_ghosts(ghosts_to_get)
	. = list()
	var/list/candidates = poll_ghost_candidates("Do you want to participate in a story?", ROLE_STORY_PARTICIPANT, FALSE, 15 SECONDS, POLL_IGNORE_STORY_ROLE)

	if(!length(candidates))
		message_admins("Story type [src] didn't have any ghost candidates, cancelling.")
		return FALSE

	for(var/i in 1 to ghosts_to_get)
		if(!length(candidates))
			message_admins("Story type [src] didn't have maximum ghost candidates, executing anyway (Wanted [ghosts_to_get], got [i])")
			break
		. += pick_n_take(candidates)

	return .

/// A proc for getting a list of players and returning an equal amount to `players_involved`
/datum/story_type/proc/get_players(players_to_get)
	. = list()
	var/list/to_ask_players = list()

	for(var/datum/mind/crew_mind as anything in get_crewmember_minds())
		var/mob/living/carbon/human/current_crew = crew_mind.current

		if(!ishuman(current_crew))
			continue
		if(current_crew.stat == DEAD)
			continue
		// Add smth to check if they're in a story already leter

		to_ask_players += current_crew

	var/list/candidates = poll_candidates("Do you want to participate in a story?", ROLE_STORY_PARTICIPANT, FALSE, 15 SECONDS, POLL_IGNORE_STORY_ROLE, FALSE, to_ask_players)
	if(!length(candidates))
		message_admins("Story type [src] didn't have any crew candidates, cancelling.")
		return FALSE

	for(var/i in 1 to players_to_get)
		if(!length(candidates))
			message_admins("Story type [src] didn't have maximum crew candidates, executing anyway (Wanted [players_to_get], got [i])")
			break
		. += pick_n_take(candidates)

	return .

/// Builds the HTML panel entry for the admin verb and round end
/datum/story_type/proc/build_html_panel_entry()
	var/list/story_info = list()
	story_info += "<b>[name]</b>"
	story_info += "<br>[desc]<br>"
	for(var/datum/mind/mind_reference as anything in mind_actor_list)
		var/datum/story_actor/actor_role = mind_actor_list[mind_reference]
		story_info += " - <b>[mind_reference.key]</b> - ([actor_role.name]) "
		story_info += "<a href='?priv_msg=[ckey(mind_reference.key)]'>PM</a> "
		if(mind_reference.current)
			story_info += "<a href='?_src_=holder;[HrefToken()];adminplayerobservefollow=[REF(mind_reference.current)]'>FLW</a> "
			story_info += "<A href='?_src_=holder;[HrefToken()];adminplayeropts=[REF(mind_reference.current)]'>Player Panel</A>"
		if(actor_role.actor_info)
			story_info += "<br> <b>Backstory:</b>"
			story_info += "<br> <i>[actor_role.actor_info]</i>"
		if(actor_role.actor_goal)
			story_info += "<br> <b>Goal:</b>"
			story_info += "<br> <i>[actor_role.actor_goal]</i>"
	return story_info.Join()
