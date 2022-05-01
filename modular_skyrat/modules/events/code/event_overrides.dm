/**
 * This file is used to denote event weight and occurence overrides.
 *
 * Events can be overriden for a multitude of reasons however each override will have a reason.
 */


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
 *
 * Weight:
 * Decreased to accomodate for the blob being a bit more difficult.
 */
/datum/round_event_control/blob
	min_players = 60
	weight = 3

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
