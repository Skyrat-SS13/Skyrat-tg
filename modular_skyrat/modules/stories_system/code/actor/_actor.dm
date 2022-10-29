/datum/story_actor
	/// Name of the actor role
	var/name = "Actor Name"
	/// Ref to the mind that's being the actor
	var/datum/mind/actor_ref //temporarily unused
	/// Ref to the story that we're a part of
	var/datum/story_type/involved_story
	/// Is this a ghost or human actor
	var/ghost_actor = FALSE
	/// An outfit to give the actor, will pick from a list
	var/list/actor_outfits = list()
	/// What to tell the actor, if anything (will not trigger if unchanged)
	var/actor_info = ""
	/// Do we tell the actor that they are in fact an actor or not
	var/inform_player = TRUE

/datum/story_actor/Destroy(force, ...)
	actor_ref = null
	involved_story = null
	return ..()

/// How to actually spawn the actor
/datum/story_actor/proc/handle_spawning(mob/picked_spawner)
	SHOULD_CALL_PARENT(TRUE)
	if(inform_player)
		INVOKE_ASYNC(GLOBAL_PROC, /proc/tgui_alert, picked_spawner, "You are a Story Participant! See your chat for more information.", "Story Participation")
	if(actor_info)
		to_chat(picked_spawner, span_boldnotice(actor_info))
	return TRUE
