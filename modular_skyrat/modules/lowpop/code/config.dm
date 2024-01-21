// When enabled, turns the lowpop system on
/datum/config_entry/flag/lowpop_measures_enabled
	default = FALSE

// The threshold for lowpop systems to be enabled.
/datum/config_entry/number/lowpop_threshold
	default = 10

// How often the subsystem should fire.
/datum/config_entry/number/lowpop_subsystem_fire
	default = 10 MINUTES
