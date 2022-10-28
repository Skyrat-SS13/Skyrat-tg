/datum/story_type
	/// Name of the story
	var/name = "Parent Story"
	/// A rough description of the story and what it does
	var/desc = "Parent story description"
	/// How impactful the story is (and how much budget it costs)
	var/impact = STORY_UNIMPACTFUL
	/// How many ghosts are involved with the story
	var/ghosts_involved = 0
	/// What outfits will ghost roles pick from
	var/list/ghost_outfits = list()
	/// How many in-round players are involved with the story
	var/players_involved = 0
	/// What to tell the players, if they should be told anything at all.
	var/player_text = ""

/// The general proc That Does Things, may get split later
/datum/story_type/proc/execute_story()
	var/list/involved_ghosts = list()
	if(ghosts_involved)
		involved_ghosts = get_ghosts()
		if(!involved_ghosts)
			return FALSE
	handle_the_ghosts(involved_ghosts)
	var/list/involved_players = list()
	if(players_involved)
		involved_players = get_players()
		if(!involved_players)
			return FALSE
	handle_the_players(involved_players)
	return TRUE

/// A proc for getting a list of ghosts and returning an equal amount to `ghosts_involved`
/datum/story_type/proc/get_ghosts()
	. = list()
	var/list/candidates = poll_ghost_candidates("Do you want to participate in a story?", ROLE_STORY_PARTICIPANT, FALSE, 15 SECONDS, POLL_IGNORE_STORY_ROLE)

	if(!length(candidates))
		message_admins("Story type [src] didn't have any ghost candidates, cancelling.")
		return FALSE

	for(var/i in 1 to ghosts_involved)
		if(!length(candidates))
			message_admins("Story type [src] didn't have maximum ghost candidates, executing anyway (Wanted [ghosts_involved], got [i])")
			break
		. += pick_n_take(candidates)

	return .

/// A proc for getting a list of players and returning an equal amount to `players_involved`
/datum/story_type/proc/get_players()
	. = list()
	var/list/to_ask_players = list()

	for(var/datum/mind/crew_mind as anything in get_crewmember_minds())
		var/mob/living/carbon/human/current_crew = crew_mind.current

		if(!ishuman(current_crew))
			continue
		if(current_crew.stat == DEAD)
			continue

		to_ask_players += current_crew

	var/list/candidates = poll_candidates("Do you want to participate in a story?", ROLE_STORY_PARTICIPANT, FALSE, 15 SECONDS, POLL_IGNORE_STORY_ROLE, FALSE, to_ask_players)
	if(!length(candidates))
		message_admins("Story type [src] didn't have any crew candidates, cancelling.")
		return FALSE

	for(var/i in 1 to players_involved)
		if(!length(candidates))
			message_admins("Story type [src] didn't have maximum crew candidates, executing anyway (Wanted [ghosts_involved], got [i])")
			break
		. += pick_n_take(candidates)

	return .


/// Per-story handling for ghosts
/datum/story_type/proc/handle_the_ghosts(list/ghost_list)
	return

/// Per-story handling for players
/datum/story_type/proc/handle_the_players(list/player_list)
	SHOULD_CALL_PARENT(TRUE)
	if(player_text)
		for(var/mob/player as anything in player_list)
			INVOKE_ASYNC(GLOBAL_PROC, /proc/tgui_alert, player, "You are a Story Participant! See your chat for more information.", "Story Participation")
			to_chat(player, span_boldnotice(player_text))
