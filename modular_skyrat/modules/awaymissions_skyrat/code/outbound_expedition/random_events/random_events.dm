/datum/outbound_random_event
	/// What is the event name
	var/name
	/// What kind of event is it?
	var/event_tier
	/// What is the weight of the event within its tier?
	var/weight = 1
	/// What the comms terminal printout name should be
	var/printout_title = ""
	/// What the contents of the comms message/printout should be
	var/list/printout_strings = list()

/// What occurs when the event is selected
/datum/outbound_random_event/proc/on_select()
	return

/// What happens when the objective's removed
/datum/outbound_random_event/proc/clear_objective()
	return

/// What happens when a person's listened to the bridge radio
/datum/outbound_random_event/proc/on_radio()
	return

/datum/outbound_random_event/harmless
	event_tier = AWAY_EVENT_HARMLESS

/datum/outbound_random_event/harmful
	event_tier = AWAY_EVENT_HARMFUL

/datum/outbound_random_event/ruin
	event_tier = AWAY_EVENT_RUIN

/datum/outbound_random_event/story
	event_tier = AWAY_EVENT_STORY
