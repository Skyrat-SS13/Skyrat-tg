#define SUPERMATTER_SURGE_TIME_UPPER 360 EVENT_SECONDS
#define SUPERMATTER_SURGE_TIME_LOWER 180 EVENT_SECONDS
#define SUPERMATTER_SURGE_CLASS_UPPER 4
#define SUPERMATTER_SURGE_CLASS_LOWER 1
#define SUPERMATTER_SURGE_BULLET_ENERGY_ADDITION 7
#define SUPERMATTER_SURGE_POWERLOSS_INHIBITION 0.3125
#define SUPERMATTER_SURGE_HEAT_MODIFIER 0.5
/**
 * Supermatter Surge
 *
 * A very simple event designed to give engineering a challenge.
 * It increases the supermatter's powerloss inhibition (energy decay) and generates a bit more heat.
 */

/datum/round_event_control/supermatter_surge
	name = "Supermatter Surge"
	typepath = /datum/round_event/supermatter_surge
	category = EVENT_CATEGORY_ENGINEERING
	max_occurrences = 1
	earliest_start = 30 MINUTES
	description = "The supermatter will increase in power and heat by a random amount, and announce it."
	admin_setup = list(
		/datum/event_admin_setup/input_number/surge_spiciness,
	)

/datum/round_event/supermatter_surge
	announce_when = 1
	end_when = SUPERMATTER_SURGE_TIME_LOWER
	/// How powerful is the supermatter surge going to be? Set in setup.
	var/surge_class = SUPERMATTER_SURGE_CLASS_LOWER
	var/starting_bullet_energy = 2
	var/starting_heat_modifier = -2.5
	/// Typecasted reference to the supermatter chosen at the events start. Prevents the engine from going AWOL if it changes for some reason.
	var/obj/machinery/power/supermatter_crystal/our_main_engine
	var/datum/sm_gas/nitrogen/our_sm_gas

/datum/event_admin_setup/input_number/surge_spiciness
	input_text = "Set surge intensity. (Higher is more severe.)"
	min_value = 1
	max_value = 4

/datum/event_admin_setup/input_number/surge_spiciness/prompt_admins()
	default_value = rand(1, 4)
	return ..()

/datum/event_admin_setup/input_number/surge_spiciness/apply_to_event(datum/round_event/supermatter_surge/event)
	event.surge_class = chosen_value

/datum/round_event/supermatter_surge/setup()
	our_sm_gas = LAZYACCESS(GLOB.sm_gas_behavior, /datum/gas/nitrogen)
	our_main_engine = GLOB.main_supermatter_engine
	starting_bullet_energy = our_main_engine.bullet_energy
	starting_heat_modifier = our_sm_gas.heat_modifier
	if(isnull(surge_class))
		surge_class = rand(SUPERMATTER_SURGE_CLASS_LOWER, SUPERMATTER_SURGE_CLASS_UPPER)
	end_when = rand(SUPERMATTER_SURGE_TIME_LOWER + (surge_class * 45 EVENT_SECONDS), SUPERMATTER_SURGE_TIME_UPPER)

/datum/round_event/supermatter_surge/announce() // Yes internally class 4 is the most powerful, but the players are used to 1 being most severe
	priority_announce("Class [5 - surge_class] supermatter surge detected. Engineering intervention may be required.", "Anomaly Alert", ANNOUNCER_KLAXON)

/datum/round_event/supermatter_surge/start()
	our_main_engine?.bullet_energy = SUPERMATTER_SURGE_BULLET_ENERGY_ADDITION + surge_class
	our_sm_gas?.heat_modifier += clamp(SUPERMATTER_SURGE_HEAT_MODIFIER * surge_class, 0.5, 2)
	our_sm_gas?.powerloss_inhibition = SUPERMATTER_SURGE_POWERLOSS_INHIBITION * surge_class

/datum/round_event/supermatter_surge/end()
	our_main_engine?.bullet_energy = starting_bullet_energy
	our_sm_gas?.heat_modifier = starting_heat_modifier
	our_sm_gas?.powerloss_inhibition = 0
	priority_announce("The supermatter surge has dissipated.", "Anomaly Cleared")
	our_main_engine = null
	our_sm_gas = null

#undef SUPERMATTER_SURGE_TIME_UPPER
#undef SUPERMATTER_SURGE_TIME_LOWER
#undef SUPERMATTER_SURGE_CLASS_UPPER
#undef SUPERMATTER_SURGE_CLASS_LOWER
#undef SUPERMATTER_SURGE_BULLET_ENERGY_ADDITION
#undef SUPERMATTER_SURGE_POWERLOSS_INHIBITION
#undef SUPERMATTER_SURGE_HEAT_MODIFIER
