/datum/round_event_control/anomaly
	name = "Anomaly: Energetic Flux"
	typepath = /datum/round_event/anomaly

	min_players = 1
	max_occurrences = 0 //This one probably shouldn't occur! It'd work, but it wouldn't be very fun.
	weight = 15
	category = EVENT_CATEGORY_ANOMALIES
	description = "This anomaly shocks and explodes. This is the base type."
	///The admin-chosen spawn location.
	var/turf/spawn_location

/datum/round_event_control/anomaly/admin_setup(mob/admin)
	. = ..()

	if(!check_rights(R_FUN))
		return ADMIN_CANCEL_EVENT

	if(tgui_alert(usr, "Spawn anomaly at your current location?", "Anomaly Alert", list("Yes", "No")) == "Yes")
		spawn_location = get_turf(usr)

/datum/round_event/anomaly
	var/area/impact_area
	var/datum/anomaly_placer/placer = new()
	var/obj/effect/anomaly/anomaly_path = /obj/effect/anomaly/flux
	announce_when = 1

/datum/round_event/anomaly/setup()

	end_when = start_when + 1 //Admin vars are cleared on end(), so we make sure the anomaly spawns before then.

	var/datum/round_event_control/anomaly/anomaly_event = control
	if(anomaly_event.spawn_location)
		impact_area = get_area(anomaly_event.spawn_location)
	else
		impact_area = placer.findValidArea()

/datum/round_event/anomaly/announce(fake)
	priority_announce("Localized energetic flux wave detected on long range scanners. Expected location of impact: [impact_area.name].", "Anomaly Alert")

/datum/round_event/anomaly/start()
	var/turf/anomaly_turf

	var/datum/round_event_control/anomaly/anomaly_event = control
	if(anomaly_event.spawn_location)
		anomaly_turf = anomaly_event.spawn_location
	else
		anomaly_turf = placer.findValidTurf(impact_area)

	var/newAnomaly
	if(anomaly_turf)
		newAnomaly = new anomaly_path(anomaly_turf)
	if (newAnomaly)
		apply_anomaly_properties(newAnomaly)
		announce_to_ghosts(newAnomaly)

<<<<<<< HEAD
/datum/round_event/anomaly/end()
	var/datum/round_event_control/anomaly/anomaly_event = control
	anomaly_event.spawn_location = null
=======
/// Make any further post-creation modifications to the anomaly
/datum/round_event/anomaly/proc/apply_anomaly_properties(obj/effect/anomaly/new_anomaly)
	return

/datum/event_admin_setup/anomaly
	///The admin-chosen spawn location.
	var/turf/spawn_location

/datum/event_admin_setup/anomaly/prompt_admins()
	if(tgui_alert(usr, "Spawn anomaly at your current location?", "Anomaly Alert", list("Yes", "No")) == "Yes")
		spawn_location = get_turf(usr)

/datum/event_admin_setup/anomaly/apply_to_event(datum/round_event/anomaly/event)
	event.spawn_location = spawn_location
>>>>>>> 2ff892757fd (Correct instances of destroying baseturfs in ChangeTurf & Select dimensional anomaly theme (#73177))
