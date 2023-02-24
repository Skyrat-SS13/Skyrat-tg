#define MAX_FREQ 64
#define HIGH_FREQ 32
#define MED_FREQ 16
#define LOW_FREQ 8
#define VERY_LOW_FREQ 4
#define MIN_FREQ 2

/**
 * This file is used to denote event weight and occurence.
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

/datum/round_event_control/abductor
	weight = VERY_LOW_FREQ

// Disabled: Part of dynamic.
/datum/round_event_control/alien_infestation
	max_occurrences = 0

/datum/round_event_control/anomaly/anomaly_flux
	weight = HIGH_FREQ

/datum/round_event_control/anomaly/anomaly_bluespace
	weight = MED_FREQ

/datum/round_event_control/anomaly/anomaly_grav
	weight = HIGH_FREQ

/datum/round_event_control/anomaly/anomaly_grav/high
	weight = HIGH_FREQ

/datum/round_event_control/anomaly/anomaly_pyro
	weight = HIGH_FREQ

/datum/round_event_control/anomaly/anomaly_vortex
	weight = MED_FREQ

/datum/round_event_control/aurora_caelus
	weight = MIN_FREQ

// Disabled: Part of dynamic.
/datum/round_event_control/blob
	max_occurrences = 0

// Disabled: Interrupting scenes and preventing roleplay by interaction with medbay.
/datum/round_event_control/brain_trauma
	max_occurrences = 0

/datum/round_event_control/brand_intelligence
	weight = LOW_FREQ

// Disabled: Too intrusive and should be staff-only.
/datum/round_event_control/bureaucratic_error
	max_occurrences = 0

/datum/round_event_control/camera_failure
	weight = MAX_FREQ

/datum/round_event_control/cortical_borer
	weight = MED_FREQ

/datum/round_event_control/carp_migration
	weight = MED_FREQ

/datum/round_event_control/cme/minimal
	weight = LOW_FREQ

/datum/round_event_control/cme/moderate
	weight = MED_FREQ

/datum/round_event_control/cme/extreme
	weight = MIN_FREQ

/datum/round_event_control/cme/unknown
	weight = VERY_LOW_FREQ

/datum/round_event_control/communications_blackout
	weight = MED_FREQ

/datum/round_event_control/obsessed
	weight = MED_FREQ

/datum/round_event_control/disease_outbreak
	weight = VERY_LOW_FREQ

/datum/round_event_control/disease_outbreak/advanced
	weight = HIGH_FREQ

/datum/round_event_control/space_dust
	weight = MAX_FREQ

/datum/round_event_control/space_dust/major_dust
	weight = MED_FREQ

/datum/round_event_control/electrical_storm
	weight = HIGH_FREQ

/datum/round_event_control/fake_virus
	weight = MED_FREQ

/datum/round_event_control/falsealarm
	weight = HIGH_FREQ

/datum/round_event_control/fugitives
	weight = VERY_LOW_FREQ

/datum/round_event_control/gravity_generator_blackout
	weight = HIGH_FREQ

/datum/round_event_control/grey_tide
	weight = MED_FREQ

/datum/round_event_control/grid_check
	weight = MED_FREQ

/datum/round_event_control/heart_attack
	weight = HIGH_FREQ

/datum/round_event_control/ion_storm
	weight = HIGH_FREQ

/datum/round_event_control/immovable_rod
	weight = VERY_LOW_FREQ

/datum/round_event_control/market_crash
	weight = MED_FREQ

/datum/round_event_control/mass_hallucination
	weight = MED_FREQ

// Weight decrease to see less of this event - causes too much destruction.
// Max occurances decreased so it can only happen once. No catastrophic meteor waves.
/datum/round_event_control/meteor_wave
	weight = VERY_LOW_FREQ
	max_occurrences = 1

/datum/round_event_control/meteor_wave/threatening
	weight = MIN_FREQ
	max_occurrences = 1

/datum/round_event_control/meteor_wave/catastrophic
	max_occurrences = 0

/datum/round_event_control/meteor_wave/meaty
	weight = MIN_FREQ

/datum/round_event_control/mice_migration
	weight = MED_FREQ

/datum/round_event_control/mold
	weight = VERY_LOW_FREQ

/datum/round_event_control/morph
	weight = LOW_FREQ

/datum/round_event_control/nightmare
	weight = LOW_FREQ

// Disabled: Does not have policy. Will re-add if/when policy is added.
/datum/round_event_control/operative
	max_occurrences = 0

/datum/round_event_control/pirates
	weight = VERY_LOW_FREQ

/datum/round_event_control/portal_storm_syndicate
	weight = VERY_LOW_FREQ

/datum/round_event_control/processor_overload
	weight = HIGH_FREQ

// Disabled: Unintutivie design and incompatibility with this server.
/datum/round_event_control/radiation_leak
	max_occurrences = 0

// Disabled: Unintutivie design and incompatibility with this server.
/datum/round_event_control/radiation_storm
	max_occurrences = 0

/datum/round_event_control/revenant
	weight = VERY_LOW_FREQ

/datum/round_event_control/sandstorm
	weight = MED_FREQ

/datum/round_event_control/scrubber_clog
	weight = LOW_FREQ

/datum/round_event_control/scrubber_clog/major
	weight = MED_FREQ

/datum/round_event_control/scrubber_clog/critical
	weight = MED_FREQ

/datum/round_event_control/scrubber_clog/strange
	weight = LOW_FREQ

/datum/round_event_control/scrubber_overflow
	weight = MED_FREQ

/datum/round_event_control/scrubber_overflow/threatening
	weight = LOW_FREQ

/datum/round_event_control/scrubber_overflow/catastrophic
	weight = VERY_LOW_FREQ

/datum/round_event_control/sentience
	weight = MED_FREQ

// Disabled: Causes too many casualities on high pop.
/datum/round_event_control/sentient_disease
	max_occurrences = 0

/datum/round_event_control/shuttle_catastrophe
	weight = MED_FREQ

/datum/round_event_control/shuttle_insurance
	weight = MED_FREQ

/datum/round_event_control/shuttle_loan
	weight = MED_FREQ

// Disabled.
/datum/round_event_control/slaughter
	max_occurrences = 0

// Disabled: Part of dynamic.
/datum/round_event_control/space_dragon
	max_occurrences = 0

// Disabled: Part of dynamic.
/datum/round_event_control/space_ninja
	max_occurrences = 0

//Disabled: Temporarily until balancing can be redone for them, as there's a rather serious issue.
/datum/round_event_control/spacevine
	max_occurrences = 0

//Disabled: Temporarily until balancing can be redone for them, as there's a rather serious issue.
/datum/round_event_control/spider_infestation
	// min_players = 70
	max_occurrences = 0

/datum/round_event_control/stray_cargo
	weight = HIGH_FREQ

/datum/round_event_control/stray_cargo/syndicate
	weight = MED_FREQ

/datum/round_event_control/stray_meteor
	weight = MED_FREQ

/datum/round_event_control/supermatter_surge
	weight = MED_FREQ

/datum/round_event_control/tram_malfunction
	weight = MAX_FREQ

/datum/round_event_control/wisdomcow
	weight = MED_FREQ

/datum/round_event_control/wormholes
	weight = VERY_LOW_FREQ

#undef MAX_FREQ
#undef HIGH_FREQ
#undef MED_FREQ
#undef LOW_FREQ
#undef VERY_LOW_FREQ
#undef MIN_FREQ
