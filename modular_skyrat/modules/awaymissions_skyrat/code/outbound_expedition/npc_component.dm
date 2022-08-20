#define TIME_PER_MESSAGE 2.5 SECONDS
// A very simple component meant to create NPC characters that react in specific ways (usually talking) to people being near
// Please expand upon this if you need more functionality

/datum/component/npc
	/// A list of text strings for the NPC to say
	var/list/say_strings = list()
	/// If they've started talking before
	var/started_trigger = FALSE

/datum/component/npc/Initialize(list/text_strings, activation_range)
	. = ..()
	if(!isliving(parent))
		return COMPONENT_INCOMPATIBLE
	say_strings = text_strings.Copy()
	for(var/turf/iterating_turf in range(activation_range, parent))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/trigger)

/// When someone walks into range of the NPC
/datum/component/npc/proc/trigger()
	SIGNAL_HANDLER
	if(started_trigger)
		return
	started_trigger = TRUE
	addtimer(CALLBACK(src, .proc/start_blabbing), 2 SECONDS)

/// The signal for the NPC to start talking
/datum/component/npc/proc/start_blabbing()
	var/curr_time = 0
	for(var/string in say_strings)
		curr_time += TIME_PER_MESSAGE
		addtimer(CALLBACK(parent, /atom/movable.proc/say, string), curr_time)

#undef TIME_PER_MESSAGE
