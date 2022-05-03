#define SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_UPPER 20
#define SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER 10
#define SUPERMATTER_SURGE_TIME_UPPER 360 * 0.5
#define SUPERMATTER_SURGE_TIME_LOWER 180 * 0.5
#define SUPERMATTER_SURGE_ANNOUNCE_THRESHOLD 12

/**
 * Supermatter Surge
 *
 * A very simple event designed to give engineering a challenge. It simply increases the supermatters power by a set amount, and announces it.
 *
 * This should be entirely fine for a powerful setup, but will require intervention on a lower power setup.
 */

/datum/round_event_control/supermatter_surge
	name = "Supermatter Surge"
	typepath = /datum/round_event/supermatter_surge
	weight = 20
	max_occurrences = 4
	earliest_start = 20 MINUTES

/datum/round_event_control/supermatter_surge/canSpawnEvent()
	if(!GLOB.main_supermatter_engine?.has_been_powered) // We don't want to cause a deadly delam if the engineers haven't started the engine yet.
		return FALSE
	return ..()

/datum/round_event/supermatter_surge
	announceWhen = 1
	endWhen = SUPERMATTER_SURGE_TIME_LOWER
	/// How powerful is the supermatter surge going to be? Set in setup.
	var/surge_power = SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER
	var/starting_surge_power = 0

/datum/round_event/supermatter_surge/setup()
	surge_power = rand(SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER, SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_UPPER)
	starting_surge_power = GLOB.main_supermatter_engine?.bullet_energy
	endWhen = rand(SUPERMATTER_SURGE_TIME_LOWER, SUPERMATTER_SURGE_TIME_UPPER)

/datum/round_event/supermatter_surge/announce()
	if(surge_power > SUPERMATTER_SURGE_ANNOUNCE_THRESHOLD || prob(round(surge_power)))
		priority_announce("Class [surge_power] supermatter surge detected. Intervention may be required.", "Anomaly Alert", ANNOUNCER_KLAXON)

/datum/round_event/supermatter_surge/start()
	GLOB.main_supermatter_engine?.bullet_energy *= surge_power

/datum/round_event/supermatter_surge/end()
	GLOB.main_supermatter_engine?.bullet_energy = starting_surge_power

#undef SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_UPPER
#undef SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER
#undef SUPERMATTER_SURGE_TIME_UPPER
#undef SUPERMATTER_SURGE_TIME_LOWER
#undef SUPERMATTER_SURGE_ANNOUNCE_THRESHOLD
