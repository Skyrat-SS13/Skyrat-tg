#define SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_UPPER 300
#define SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER 100
#define SUPERMATTER_SURGE_TIME_UPPER 360 * 0.5
#define SUPERMATTER_SURGE_TIME_LOWER 180 * 0.5
#define SUPERMATTER_SURGE_ANNOUNCE_THRESHOLD 25
#define LOWER_SURGE_LIMIT 100 to 150
#define MIDDLE_SURGE_LIMIT 151 to 200
#define UPPER_SURGE_LIMIT 201 to 250
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
	category = EVENT_CATEGORY_ENGINEERING
	max_occurrences = 4
	earliest_start = 30 MINUTES

/datum/round_event/supermatter_surge
	announce_when = 1
	end_when = SUPERMATTER_SURGE_TIME_LOWER
	/// How powerful is the supermatter surge going to be? Set in setup.
	var/surge_power = SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER
	var/starting_surge_power = 0
	/// Typecasted reference to the supermatter chosen at the events start. Prevents the engine from going AWOL if it changes for some reason.
	var/obj/machinery/power/supermatter_crystal/our_main_engine

/datum/round_event/supermatter_surge/setup()
	our_main_engine = GLOB.main_supermatter_engine
	surge_power = rand(SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER, SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_UPPER)
	starting_surge_power = our_main_engine.bullet_energy
	end_when = rand(SUPERMATTER_SURGE_TIME_LOWER, SUPERMATTER_SURGE_TIME_UPPER)

/datum/round_event/supermatter_surge/announce()
	if(surge_power > SUPERMATTER_SURGE_ANNOUNCE_THRESHOLD || prob(round(surge_power)))
		priority_announce("Class [get_surge_level()] supermatter surge detected. Intervention may be required.", "Anomaly Alert", ANNOUNCER_KLAXON)

/datum/round_event/supermatter_surge/proc/get_surge_level()
	switch(surge_power)
		if(LOWER_SURGE_LIMIT)
			return 4
		if(MIDDLE_SURGE_LIMIT)
			return 3
		if(UPPER_SURGE_LIMIT)
			return 2
		else
			return 1

/datum/round_event/supermatter_surge/start()
	our_main_engine?.bullet_energy *= surge_power

/datum/round_event/supermatter_surge/end()
	our_main_engine?.bullet_energy = starting_surge_power
	priority_announce("The supermatter surge has dissipated.", "Anomaly Cleared")
	our_main_engine = null

#undef SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_UPPER
#undef SUPERMATTER_SURGE_BULLET_ENERGY_FACTOR_LOWER
#undef SUPERMATTER_SURGE_TIME_UPPER
#undef SUPERMATTER_SURGE_TIME_LOWER
#undef SUPERMATTER_SURGE_ANNOUNCE_THRESHOLD
#undef LOWER_SURGE_LIMIT
#undef MIDDLE_SURGE_LIMIT
#undef UPPER_SURGE_LIMIT
