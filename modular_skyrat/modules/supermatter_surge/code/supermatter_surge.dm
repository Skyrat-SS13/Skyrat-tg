#define SUPERMATTER_SURGE_POWER_LIMIT_UPPER 4000
#define SUPERMATTER_SURGE_POWER_LIMIT_LOWER 200

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
	earliest_start = 10 MINUTES

/datum/round_event_control/supermatter_surge/canSpawnEvent()
	if(!GLOB.main_supermatter_engine?.has_been_powered) // We don't want to cause a deadly delam if the engineers haven't started the engine yet.
		return FALSE
	return ..()

/datum/round_event/supermatter_surge
	announceWhen = 1
	/// How powerful is the supermatter surge going to be? Set in setup.
	var/surge_power = SUPERMATTER_SURGE_POWER_LIMIT_LOWER

/datum/round_event/supermatter_surge/setup()
	surge_power = rand(SUPERMATTER_SURGE_POWER_LIMIT_LOWER, SUPERMATTER_SURGE_POWER_LIMIT_UPPER)

/datum/round_event/supermatter_surge/announce()
	if(surge_power > 800 || prob(round(surge_power/8)))
		priority_announce("Class [round(surge_power/500) + 1] supermatter surge detected. Intervention may be required.", "Anomaly Alert", ANNOUNCER_KLAXON)

/datum/round_event/supermatter_surge/start()
	GLOB.main_supermatter_engine?.matter_power += surge_power

#undef SUPERMATTER_SURGE_POWER_LIMIT_UPPER
#undef SUPERMATTER_SURGE_POWER_LIMIT_LOWER
