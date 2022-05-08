/datum/round_event_control
	/// Do we override the votable component? (For events that just end the round)
	var/votable = TRUE

	var/chaos_level = EVENT_CHAOS_DISABLED

/datum/round_event_control/cme/armageddon
	votable = FALSE

/datum/round_event_control/anomaly
	votable = FALSE

/datum/round_event_control/preset
	name = "ERROR"
	typepath = "error"
	votable = FALSE
	max_occurrences = 0
	weight = 0
	chaos_level = EVENT_CHAOS_DISABLED // We are abstract

	/// What chaos levels can this preset choose from, empty is abstract.
	var/selectable_chaos_level

	/// A list of possible events for us to select from. Cached the first time it's run.
	var/list/possible_events = list()

/datum/round_event_control/preset/runEvent(random)
	log_game("Preset Event Triggering: [name] ([typepath])")
	if(random)
		deadchat_broadcast(" has just been [random ? "randomly " : ""]triggered!", "<b>[name] preset</b>", message_type=DEADCHAT_ANNOUNCEMENT)
	if(!LAZYLEN(possible_events)) // List hasn't been populated yet, let's do it now.
		for(var/datum/round_event_control/iterating_event in SSevents.control)
			if(!iterating_event.votable)
				continue
			if(iterating_event.chaos_level == selectable_chaos_level)
				possible_events += iterating_event

	SSevents.previously_run += src

	var/datum/round_event_control/event_to_run = pick(possible_events)

	event_to_run.runEvent()

	occurrences++

/datum/round_event_control/preset/low
	name = "Disruptive Random Event"
	earliest_start = 0
	max_occurrences = 100
	selectable_chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/preset/moderate
	name = "Highly Disruptive Random Event"
	max_occurrences = 10
	earliest_start = 10 MINUTES
	selectable_chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/preset/high
	name = "Catastrophic Random Event"
	max_occurrences = 10
	earliest_start = 30 MINUTES
	selectable_chaos_level = EVENT_CHAOS_HIGH
	min_players = 70

/**
 * EVENT CHAOS DECLARES
 */

// LOW CHAOS EVENTS

/datum/round_event_control/cortical_borer
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/cme/minimal
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/stray_cargo
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/stray_cargo/syndicate
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/wisdomcow
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/wormholes
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/sentience
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/shuttle_catastrophe
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/shuttle_insurance
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/shuttle_loan
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/grey_tide
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/processor_overload
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/grid_check
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/ion_storm
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/meteor_wave/major_dust
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/market_crash
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/mass_hallucination
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/mice_migration
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/electrical_storm
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/bureaucratic_error
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/camera_failure
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/carp_migration
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/communications_blackout
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/obsessed
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/disease_outbreak
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/anomaly/anomaly_grav/high
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/morph
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/supermatter_surge
	chaos_level = EVENT_CHAOS_LOW

// MODERATE CHAOS PRESETS

/datum/round_event_control/cme/moderate
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/space_ninja
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/portal_storm_syndicate
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/nightmare
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/meteor_wave/meaty
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/meteor_wave/threatening
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/meteor_wave
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/immovable_rod
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/fugitives
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/sandstorm
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/brand_intelligence
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/abductor
	chaos_level = EVENT_CHAOS_MED

/datum/round_event_control/revenant
	chaos_level = EVENT_CHAOS_MED

///////////////////////
// HIGH CHAOS EVENTS //
///////////////////////

/datum/round_event_control/slaughter
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/alien_infestation
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/blob
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/pirates
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/space_dragon
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/resonance_cascade
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/spacevine
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/mold
	chaos_level = EVENT_CHAOS_HIGH

/datum/round_event_control/cme/extreme
	chaos_level = EVENT_CHAOS_HIGH


// RANDOM EVENTS
/datum/round_event_control/anomaly/anomaly_flux
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/anomaly/anomaly_bluespace
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/anomaly/anomaly_grav
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/anomaly/anomaly_pyro
	chaos_level = EVENT_CHAOS_LOW

/datum/round_event_control/anomaly/anomaly_vortex
	chaos_level = EVENT_CHAOS_LOW


///////////////////////////
// EVENT CHAOS OVERRIDES //
//     FOR SUBTYPES      //
///////////////////////////
/datum/round_event_control/pirates/enclave
	chaos_level = EVENT_CHAOS_DISABLED

/datum/round_event_control/pirates/dutchman
	chaos_level = EVENT_CHAOS_DISABLED

/datum/round_event_control/pirates/silverscales
	chaos_level = EVENT_CHAOS_DISABLED

/datum/round_event_control/pirates/rogues
	chaos_level = EVENT_CHAOS_DISABLED
