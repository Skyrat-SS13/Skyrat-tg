/**
 * This file is used to denote event weight and occurence overrides.
 *
 * Events can be overriden for a multitude of reasons however each override will have a reason.
 */

/**
 * Event subsystem
 *
 * Overriden min and max start times:
 * To accomodate for much longer rounds.
 */
/datum/controller/subsystem/events
	frequency_lower = 15 MINUTES
	frequency_upper = 25 MINUTES

/**
 * Brain truama
 *
 * Removed for:
 * Interrupting scenes and preventing roleplay by interaction with medbay.
 */
/datum/round_event_control/brain_trauma
	max_occurrences = 0

/**
 * Blob
 *
 * Removed for:
 * Already being handled by dynamic, it shouldn't be spawning from two places at once.
 */
/datum/round_event_control/blob
	max_occurrences = 0

/**
 * Radiation storm
 *
 * Removed for:
 * Unintutivie design and incompatibility with this server.
 */
/datum/round_event_control/radiation_storm
	max_occurrences = 0

/**
 * Spacevines
 *
 * Removed:
 * Temporarily until balancing can be redone for them, as there's a rather serious issue.
 */
/datum/round_event_control/spacevine
	max_occurrences = 0

/**
 * Spider infestation
 *
 * Min players:
 * Upped to ensure lowpop steamroll does not happen
 */
/datum/round_event_control/spider_infestation
	// min_players = 70
	max_occurrences = 0

/**
 * Meteor Waves
 *
 * Weight:
 * Decreased to see less of this event-- causes too much destruction
 * Max Occurances:
 * Decreased so it can only happen once
 */
/datum/round_event_control/meteor_wave
	weight = 3
	max_occurrences = 1

/datum/round_event_control/meteor_wave/threatening
	weight = 2
	max_occurrences = 1

/datum/round_event_control/meteor_wave/catastrophic
	weight = 1
	max_occurrences = 1

/**
 * Sentient Disease
 *
 * Removed:
 * Causes too many casualities on high pop
 */
/datum/round_event_control/sentient_disease
	max_occurrences = 0

/**
 * Lone Ops
 *
 * Removed:
 * Does not have policy. Will re-add if/when policy is added
 */
/datum/round_event_control/operative
	max_occurrences = 0

/**
 * Ninja
 *
 * Removed: It's already apart of dynamic, we don't need it both as an event and as a part of dynamic. Leaving it in dynamic for finer control over how often it rolls.
 *
 */
/datum/round_event_control/space_ninja
	max_occurrences = 0
	weight = 0

/**
 * Space Dragon
 *
 * Removed:
 * Space Dragon should be controlled through dynamic spawns
 */
/datum/round_event_control/space_dragon
	max_occurrences = 0

/**
 * Xenomorphs
 *
 * Removed:
 * Xenomorphs should be controlled through dynamic spawns
 */
/datum/round_event_control/alien_infestation
	max_occurrences = 0
