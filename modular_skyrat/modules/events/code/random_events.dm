#define VERY_HIGH_EVENT_FREQ 64
#define HIGH_EVENT_FREQ 32
#define MED_EVENT_FREQ 16
#define LOW_EVENT_FREQ 8
#define VERY_LOW_EVENT_FREQ 4
#define MIN_EVENT_FREQ 2

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
	frequency_lower = 7 MINUTES
	frequency_upper = 14 MINUTES

/datum/round_event_control/abductor
	weight = VERY_LOW_EVENT_FREQ

// Disabled: Part of dynamic.
/datum/round_event_control/alien_infestation
	max_occurrences = 0

/datum/round_event_control/anomaly/anomaly_flux
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_bluespace
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_ectoplasm
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_grav
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_grav/high
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_pyro
	weight = HIGH_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_vortex
	weight = MED_EVENT_FREQ

/datum/round_event_control/aurora_caelus
	weight = MIN_EVENT_FREQ

// Disabled: Part of dynamic.
/datum/round_event_control/blob
	max_occurrences = 0

// Disabled: Interrupting scenes and preventing roleplay by interaction with medbay.
/datum/round_event_control/brain_trauma
	max_occurrences = 0

/datum/round_event_control/brand_intelligence
	weight = MED_EVENT_FREQ

// Disabled: Too intrusive and should be staff-only.
/datum/round_event_control/bureaucratic_error
	max_occurrences = 0

/datum/round_event_control/camera_failure
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/carp_migration
	weight = MED_EVENT_FREQ

/datum/round_event_control/cortical_borer
	weight = MED_EVENT_FREQ

// Disabled: Part of dynamic.
/datum/round_event_control/changeling
	max_occurrences = 0

/datum/round_event_control/cme/minimal
	weight = MED_EVENT_FREQ

/datum/round_event_control/cme/moderate
	weight = MED_EVENT_FREQ

/datum/round_event_control/cme/extreme
	weight = MIN_EVENT_FREQ

/datum/round_event_control/cme/unknown
	weight = LOW_EVENT_FREQ

/datum/round_event_control/communications_blackout
	weight = LOW_EVENT_FREQ

/datum/round_event_control/obsessed
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/disease_outbreak
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/disease_outbreak/advanced
	weight = HIGH_EVENT_FREQ
	max_occurrences = 2

/datum/round_event_control/space_dust
	weight = LOW_EVENT_FREQ

/datum/round_event_control/space_dust/major_dust
	weight = MED_EVENT_FREQ

/datum/round_event_control/electrical_storm
	weight = MED_EVENT_FREQ

/datum/round_event_control/fake_virus
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/falsealarm
	weight = LOW_EVENT_FREQ

/datum/round_event_control/fugitives
	weight = LOW_EVENT_FREQ

/datum/round_event_control/gravity_generator_blackout
	weight = MED_EVENT_FREQ

/datum/round_event_control/grey_tide
	weight = MED_EVENT_FREQ

/datum/round_event_control/grid_check
	weight = MED_EVENT_FREQ

/datum/round_event_control/heart_attack
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/ion_storm
	weight = MED_EVENT_FREQ

/datum/round_event_control/immovable_rod
	weight = MED_EVENT_FREQ

/datum/round_event_control/market_crash
	weight = MIN_EVENT_FREQ

/datum/round_event_control/mass_hallucination
	weight = LOW_EVENT_FREQ

// Weight decrease to see less of this event - causes too much destruction.
// Max occurances decreased so it can only happen once. No catastrophic meteor waves.
/datum/round_event_control/meteor_wave
	weight = MED_EVENT_FREQ
	max_occurrences = 1

/datum/round_event_control/meteor_wave/threatening
	weight = LOW_EVENT_FREQ
	max_occurrences = 1
	min_players = 90

/datum/round_event_control/meteor_wave/catastrophic
	max_occurrences = 0

/datum/round_event_control/meteor_wave/meaty
	weight = MIN_EVENT_FREQ

/datum/round_event_control/mice_migration
	weight = LOW_EVENT_FREQ

/datum/round_event_control/mold
	weight = MED_EVENT_FREQ

/datum/round_event_control/morph
	weight = LOW_EVENT_FREQ

/datum/round_event_control/nightmare
	weight = MED_EVENT_FREQ

// Disabled: Does not have policy. Will re-add if/when policy is added.
/datum/round_event_control/operative
	max_occurrences = 0

/datum/round_event_control/pirates
	max_occurrences = 0

/datum/round_event_control/portal_storm_syndicate
	weight = MED_EVENT_FREQ

/datum/round_event_control/processor_overload
	weight = MED_EVENT_FREQ

// Disabled: Unintutivie design and incompatibility with this server.
/datum/round_event_control/radiation_leak
	max_occurrences = 0

// Disabled: Unintutivie design and incompatibility with this server.
/datum/round_event_control/radiation_storm
	max_occurrences = 0

/datum/round_event_control/revenant
	weight = LOW_EVENT_FREQ

/datum/round_event_control/sandstorm
	weight = MED_EVENT_FREQ

// Disabled: Other severities are enough.
/datum/round_event_control/scrubber_clog
	max_occurrences = 0

/datum/round_event_control/scrubber_clog/major
	weight = MED_EVENT_FREQ

/datum/round_event_control/scrubber_clog/critical
	weight = MED_EVENT_FREQ

/datum/round_event_control/scrubber_clog/strange
	weight = LOW_EVENT_FREQ

/datum/round_event_control/scrubber_overflow
	weight = MIN_EVENT_FREQ

/datum/round_event_control/scrubber_overflow/threatening
	weight = MED_EVENT_FREQ

/datum/round_event_control/scrubber_overflow/catastrophic
	weight = LOW_EVENT_FREQ

/datum/round_event_control/sentience
	weight = LOW_EVENT_FREQ

// Disabled: Causes too many casualities on high pop.
/datum/round_event_control/sentient_disease
	max_occurrences = 0

/datum/round_event_control/shuttle_catastrophe
	weight = LOW_EVENT_FREQ

/datum/round_event_control/shuttle_insurance
	weight = MED_EVENT_FREQ

/datum/round_event_control/shuttle_loan
	weight = MED_EVENT_FREQ

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
	weight = LOW_EVENT_FREQ

/datum/round_event_control/stray_cargo/syndicate
	weight = MED_EVENT_FREQ

/datum/round_event_control/stray_meteor
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/supermatter_surge
	weight = MED_EVENT_FREQ

/datum/round_event_control/tram_malfunction
	weight = VERY_HIGH_EVENT_FREQ

/datum/round_event_control/wisdomcow
	weight = MIN_EVENT_FREQ

/datum/round_event_control/wormholes
	weight = MED_EVENT_FREQ

#undef VERY_HIGH_EVENT_FREQ
#undef HIGH_EVENT_FREQ
#undef MED_EVENT_FREQ
#undef LOW_EVENT_FREQ
#undef VERY_LOW_EVENT_FREQ
#undef MIN_EVENT_FREQ
