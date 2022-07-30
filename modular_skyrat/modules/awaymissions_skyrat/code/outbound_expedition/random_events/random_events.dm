/datum/outbound_random_event
	/// What is the event name
	var/name
	/// What kind of event is it?
	var/event_tier
	/// What is the weight of the event within its tier?
	var/weight = 1

/// What occurs when the event is selected
/datum/outbound_random_event/proc/on_select()
	return

/datum/outbound_random_event/harmless
	event_tier = AWAY_EVENT_HARMLESS

/datum/outbound_random_event/harmful
	event_tier = AWAY_EVENT_HARMFUL

/datum/outbound_random_event/mob_harmful
	event_tier = AWAY_EVENT_MOB_HARMFUL

/datum/outbound_random_event/story
	event_tier = AWAY_EVENT_STORY
