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
	frequency_lower = 8 MINUTES
	frequency_upper = 15 MINUTES

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
 * Min players:
 * Raised to accomodate for lower population not being able to cope with the blob.
 */
/datum/round_event_control/blob
	min_players = 60

/**
 * Radiation storm
 *
 * Removed for:
 * Unintutivie design and incompatibility with this server.
 */
/datum/round_event_control/radiation_storm
	max_occurrences = 0

/**
 * Spider infestation
 *
 * Min players:
 * Upped to ensure lowpop steamroll does not happen
 */
/datum/round_event_control/spider_infestation
	min_players = 70
