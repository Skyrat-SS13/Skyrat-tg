// When enabled, turns the lowpop system on
/datum/config_entry/flag/lowpop_measures_enabled
	default = FALSE

// The thresholsd for lowpop systems to be enabled/disabled.
/datum/config_entry/number/lowpop_threshold_disable
	default = 12

/datum/config_entry/number/lowpop_threshold_enable
	default = 9

// How often the subsystem should fire.
/datum/config_entry/number/lowpop_subsystem_fire
	default = 5 MINUTES
