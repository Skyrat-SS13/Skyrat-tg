#define VERY_HIGH_EVENT_FREQ 64
#define HIGH_EVENT_FREQ 32
#define MED_EVENT_FREQ 16
#define LOW_EVENT_FREQ 8
#define VERY_LOW_EVENT_FREQ 4
#define MIN_EVENT_FREQ 2

/**
 * This file is used to denote weight and frequency
 * and any custom procs/modifications to events.
 */

/**
 * Event subsystem
 *
 * Overriden min and max start times
 * to accomodate for much longer rounds
 */
/datum/controller/subsystem/events
	frequency_lower = 7 MINUTES
	frequency_upper = 14 MINUTES

/**
 * Abductors
 */
/datum/round_event_control/abductor
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/**
 * Alien Infestation
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/alien_infestation
	max_occurrences = 0

/**
 * Anomalies
 */
/datum/round_event_control/anomaly/anomaly_bioscrambler
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_bluespace
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_dimensional
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_ectoplasm
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_flux
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

// We have other intensities
/datum/round_event_control/anomaly/anomaly_grav
	max_occurrences = 0

/datum/round_event_control/anomaly/anomaly_grav/high
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_hallucination
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_pyro
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/anomaly/anomaly_vortex
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Aurora Caelus
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/aurora_caelus
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/**
 * Blob
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/blob
	max_occurrences = 0

/**
 * Brain Trauma
 *
 * Disabled: Interrupting scenes and preventing roleplay by interaction with medba
 */
/datum/round_event_control/brain_trauma
	max_occurrences = 0

/**
 * Brand Intelligence
 */
/datum/round_event_control/brand_intelligence
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Bureaucratic Error
 *
 * Disabled: Too intrusive and should be staff-onl
 */
/datum/round_event_control/bureaucratic_error
	max_occurrences = 0

/**
 * Camera Failure
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/camera_failure
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/**
 * Carp Migration
 */
/datum/round_event_control/carp_migration
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Cortical Borers
 */
/datum/round_event_control/cortical_borer
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Changeling
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/changeling
	max_occurrences = 0

/**
 * CME (Coronal Mass Ejection)
 *
 * Combined weight: 56
 */
/datum/round_event_control/cme/minimal
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/cme/moderate
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/cme/extreme
	max_occurrences = 1
	weight = LOW_EVENT_FREQ
	earliest_start = 105 MINUTES

/datum/round_event_control/cme/unknown
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Communications
 *
 * Combined weight: 16
 */
/datum/round_event_control/communications_blackout
	max_occurrences = 2
	weight = LOW_EVENT_FREQ

/datum/round_event_control/processor_overload
	max_occurrences = 2
	weight = LOW_EVENT_FREQ

/**
 * Obsessed
 */
/datum/round_event_control/obsessed
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/**
 * Medical
 *
 * Combined weight: 44
 */
/datum/round_event_control/disease_outbreak
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/disease_outbreak/advanced
	weight = HIGH_EVENT_FREQ
	max_occurrences = 2

/datum/round_event_control/fake_virus
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/heart_attack
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/sentient_disease
	max_occurrences = 0

/**
 * Electricity Events
 *
 * Combined weight: 32
 */
/datum/round_event_control/electrical_storm
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/datum/round_event_control/grid_check
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * False Alarm
 */
/datum/round_event_control/falsealarm
	max_occurrences = 4
	weight = LOW_EVENT_FREQ

/**
 * Fugitives
 */
/datum/round_event_control/fugitives
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Gravity Generator Blackout
 */
/datum/round_event_control/gravity_generator_blackout
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Grey Tide
 */
/datum/round_event_control/grey_tide
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Ion Storm
 */
/datum/round_event_control/ion_storm
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Immovable Rod
 */
/datum/round_event_control/immovable_rod
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Market Crash
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/market_crash
	max_occurrences = 1
	weight = MIN_EVENT_FREQ

/**
 * Mass Hallucination
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/mass_hallucination
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Meteors / Space Dust
 *
 * Combined weight: 62
 */
/datum/round_event_control/meteor_wave
	weight = MED_EVENT_FREQ
	max_occurrences = 1

// Only highpop
/datum/round_event_control/meteor_wave/threatening
	weight = LOW_EVENT_FREQ
	max_occurrences = 1
	min_players = 75
	earliest_start = 105 MINUTES

// Nope
/datum/round_event_control/meteor_wave/catastrophic
	max_occurrences = 0

/datum/round_event_control/meteor_wave/meaty
	max_occurrences = 1
	weight = MIN_EVENT_FREQ

/datum/round_event_control/stray_meteor
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/space_dust
	max_occurrences = 0

/datum/round_event_control/space_dust/major_dust
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/sandstorm
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Mice Migration
 */
/datum/round_event_control/mice_migration
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Moldies
 */
/datum/round_event_control/mold
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Morph
 */
/datum/round_event_control/morph
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Nightmare
 */
/datum/round_event_control/nightmare
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Lone op
 *
 * Disabled: Does not have policy. Will re-add if/when policy is added
 */
/datum/round_event_control/operative
	max_occurrences = 0

/**
 * Pirates
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/pirates
	max_occurrences = 0

/**
 * Syndicate Portal Storm
 */
/datum/round_event_control/portal_storm_syndicate
	max_occurrences = 3
	weight = MED_EVENT_FREQ

/**
 * Radiation
 *
 * Disabled: Unintutivie design and incompatibility with this server
 */
/datum/round_event_control/radiation_leak
	max_occurrences = 0

/datum/round_event_control/radiation_storm
	max_occurrences = 0

/**
 * Revenant
 */
/datum/round_event_control/revenant
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Scrubber Clogs
 *
 * Combined weight: 32
 */
/datum/round_event_control/scrubber_clog
	max_occurrences = 0

/datum/round_event_control/scrubber_clog/major
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/scrubber_clog/critical
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/datum/round_event_control/scrubber_clog/strange
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/**
 * Scrubber Overflow
 *
 * Combined weight: 24
 */
/datum/round_event_control/scrubber_overflow
	max_occurrences = 0

/datum/round_event_control/scrubber_overflow/threatening
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/datum/round_event_control/scrubber_overflow/catastrophic
	max_occurrences = 1
	weight = VERY_LOW_EVENT_FREQ

/**
 * Human-level Intelligence
 */
/datum/round_event_control/sentience
	max_occurrences = 2
	weight = LOW_EVENT_FREQ

/**
 * Shuttle Events
 *
 * Combined weight: 24
 */
/datum/round_event_control/shuttle_catastrophe
	max_occurrences = 1
	weight = LOW_EVENT_FREQ

/datum/round_event_control/shuttle_insurance
	max_occurrences = 0

/datum/round_event_control/shuttle_loan
	max_occurrences = 2
	weight = MED_EVENT_FREQ

/**
 * Slaughter Demon
 */
/datum/round_event_control/slaughter
	max_occurrences = 0

/**
 * Spess Dragon
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/space_dragon
	max_occurrences = 0

/**
 * Spess Ninja
 *
 * Disabled: Controlled by Dynamic
 */
/datum/round_event_control/space_ninja
	max_occurrences = 0

/**
 * Spess Vines
 *
 * Disabled: Needs rebalancing
 */
/datum/round_event_control/spacevine
	max_occurrences = 0
/**
 * Spiders
 *
 * Disabled: Needs rebalancing
 */
/datum/round_event_control/spider_infestation
	max_occurrences = 0

/**
 * Stray Cargo Pods
 *
 * Combined weight: 24
 */
/datum/round_event_control/stray_cargo
	max_occurrences = 3
	weight = LOW_EVENT_FREQ

/datum/round_event_control/stray_cargo/syndicate
	max_occurrences = 3
	weight = MED_EVENT_FREQ

/**
 * Supermatter Surge
 */
/datum/round_event_control/supermatter_surge
	max_occurrences = 1
	weight = MED_EVENT_FREQ

/**
 * Tram Malfunction
 *
 * Only runs on Tramstation, otherwise rolls a different event.
 */
/datum/round_event_control/tram_malfunction
	max_occurrences = 2
	weight = VERY_HIGH_EVENT_FREQ

/**
 * Wisdom Cow
 *
 * TODO: Make it not consume an event slot
 */
/datum/round_event_control/wisdomcow
	max_occurrences = 1
	weight = MIN_EVENT_FREQ

/**
 * Wormholes
 */
/datum/round_event_control/wormholes
	max_occurrences = 2
	weight = MED_EVENT_FREQ

#undef VERY_HIGH_EVENT_FREQ
#undef HIGH_EVENT_FREQ
#undef MED_EVENT_FREQ
#undef LOW_EVENT_FREQ
#undef VERY_LOW_EVENT_FREQ
#undef MIN_EVENT_FREQ
