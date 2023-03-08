/datum/round_event_control/anomaly/anomaly_dimensional
	name = "Anomaly: Dimensional"
	typepath = /datum/round_event/anomaly/anomaly_dimensional

	min_players = 10
	max_occurrences = 5
	weight = 20
	description = "This anomaly replaces the materials of the surrounding area."
<<<<<<< HEAD
=======
	min_wizard_trigger_potency = 0
	max_wizard_trigger_potency = 2
	admin_setup = list(/datum/event_admin_setup/set_location/anomaly, /datum/event_admin_setup/listed_options/anomaly_dimensional)
>>>>>>> 105dff50583 (Refactors admin event setup (again) (#73801))

/datum/round_event/anomaly/anomaly_dimensional
	start_when = 10
	announce_when = 3
	anomaly_path = /obj/effect/anomaly/dimensional

/datum/round_event/anomaly/anomaly_dimensional/announce(fake)
	priority_announce("Localized dimensional instability detected on long range scanners. Expected location: [impact_area.name].", "Anomaly Alert")
<<<<<<< HEAD
=======

/datum/event_admin_setup/listed_options/anomaly_dimensional
	input_text = "Select a dimensional anomaly theme?"
	normal_run_option = "Random Theme"

/datum/event_admin_setup/listed_options/anomaly_dimensional/get_list()
	return subtypesof(/datum/dimension_theme)

/datum/event_admin_setup/listed_options/anomaly_dimensional/apply_to_event(datum/round_event/anomaly/anomaly_dimensional/event)
	event.anomaly_theme = chosen
>>>>>>> 105dff50583 (Refactors admin event setup (again) (#73801))
