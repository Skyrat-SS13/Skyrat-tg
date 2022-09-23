// Assoc ID:landmark
GLOBAL_LIST_EMPTY(outbound_objective_landmarks)

/obj/effect/landmark/away_objective
	name = "away mission objective landmark"
	/// The range from the objective for it to go away for the user
	var/range_req = 2
	/// Mobs who have yet to trigger the objective
	var/list/untriggered_mobs = list()
	/// Has the thing actually been enabled yet
	var/enabled = FALSE
	/// ID of the landmark
	var/id = "parent"

/obj/effect/landmark/away_objective/Initialize(mapload)
	. = ..()
	GLOB.outbound_objective_landmarks[id] = src

/obj/effect/landmark/away_objective/Destroy()
	GLOB.outbound_objective_landmarks.Remove(id)
	return ..()

/// To enable the objective itself
/obj/effect/landmark/away_objective/proc/enable()
	OUTBOUND_CONTROLLER
	if(!length(untriggered_mobs))
		for(var/mob/not_dead_mob in outbound_controller.participating_mobs)
			if(not_dead_mob.stat == DEAD)
				continue
			untriggered_mobs |= not_dead_mob
	for(var/turf/iterating_turf in range(range_req, src))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/trigger, override = TRUE)
	enabled = TRUE

/obj/effect/landmark/away_objective/proc/disable()
	for(var/turf/iterating_turf in range(range_req, src))
		UnregisterSignal(iterating_turf, COMSIG_ATOM_ENTERED)
	enabled = FALSE

/// To get rid of the popup when someone with the objective gets near
/obj/effect/landmark/away_objective/proc/trigger(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER
	OUTBOUND_CONTROLLER

	if(!enabled || !isliving(entered_atom) || !(entered_atom in untriggered_mobs))
		return

	var/mob/living/entered_mob = entered_atom

	var/datum/status_effect/agent_pinpointer/away_objective/obj_pinpoint = entered_mob.has_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	if(!obj_pinpoint)
		return
	if(obj_pinpoint.scan_target == src)
		outbound_controller.clear_objective(entered_mob)
	untriggered_mobs -= entered_mob
	if(!length(untriggered_mobs))
		disable()
	return TRUE

// actual landmarks here

/obj/effect/landmark/away_objective/talk_person
	id = "talk_person"

/obj/effect/landmark/away_objective/cryo
	id = "cryo"

/obj/effect/landmark/away_objective/bridge_radio
	id = "bridge_radio"
	/// If the computer has talked before this movement
	var/talked_before = FALSE

/obj/effect/landmark/away_objective/bridge_radio/enable()
	. = ..()
	talked_before = FALSE

/obj/effect/landmark/away_objective/bridge_radio/trigger(datum/source, atom/movable/entered_atom)
	. = ..()
	if(!. || talked_before)
		return
	OUTBOUND_CONTROLLER
	var/turf/our_turf = get_turf(src)
	for(var/obj/machinery/computer/outbound_radio/radio in our_turf.contents)
		radio.start_talking(outbound_controller?.current_event.type)
		talked_before = TRUE
		break

/obj/effect/landmark/away_objective/part_fix
	id = "part_fix"
	range_req = 1

// other landmark shit that i might move later
/obj/effect/landmark/objective_update

/obj/effect/landmark/objective_update/Initialize(mapload)
	. = ..()
	RegisterSignal(get_turf(src), COMSIG_ATOM_ENTERED, .proc/on_enter)

/obj/effect/landmark/objective_update/proc/on_enter(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)

/obj/effect/landmark/objective_update/cryo

/obj/effect/landmark/objective_update/cryo/on_enter(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	OUTBOUND_CONTROLLER
	if(!ismob(arrived) || !outbound_controller)
		return
	var/datum/outbound_objective/cryo_obj = outbound_controller.objectives[/datum/outbound_objective/cryo]
	if(outbound_controller.participating_mobs[arrived] == cryo_obj)
		return
	outbound_controller.give_objective(arrived, cryo_obj)

/obj/effect/landmark/objective_update/elevator
	var/static/list/all_people_entered = list()

/obj/effect/landmark/objective_update/elevator/on_enter(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	OUTBOUND_CONTROLLER
	if(!ismob(arrived) || !outbound_controller)
		return

	if(length(all_people_entered) >= OUTBOUND_MAXIMUM_PLAYER_COUNT)
		for(var/datum/gateway_destination/point/dest_point in GLOB.gateway_destinations)
			dest_point.target_turfs = list()

	if(outbound_controller.elevator_time == initial(outbound_controller.elevator_time))
		addtimer(CALLBACK(outbound_controller, /datum/away_controller/outbound_expedition.proc/tick_elevator_time), 1 SECONDS)

	var/mob/arrived_mob = arrived
	all_people_entered |= arrived_mob
	arrived_mob?.hud_used?.away_dialogue.set_text("Waiting... ([round(outbound_controller.elevator_time / 10)] seconds remaining)")

/obj/effect/landmark/objective_update/team_addition

/obj/effect/landmark/objective_update/team_addition/on_enter(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	OUTBOUND_CONTROLLER
	if(!isliving(arrived) || !outbound_controller)
		return

	outbound_controller.add_mob(arrived)

/obj/effect/landmark/outbound/ship_center
	name = "Vanguard Corvette Center"

/obj/effect/landmark/outbound/meteor_start
	name = "Meteor Start"

/obj/effect/landmark/outbound/debris_loc
	name = "Debris Location"

/obj/effect/landmark/outbound/scrapper_evac_point
	name = "Scrapper Evacuation Point"

/obj/effect/landmark/outbound/raider_spawn
	name = "Raider Spawn Point"

/obj/effect/landmark/outbound/bridge_center
	name = "Bridge Center"

/obj/effect/landmark/outbound/gateway_portal_spawn
	name = "Gateway Portal Spawn"

/obj/effect/landmark/outbound/ruin_shuttle_interdictor
	name = "Ruin Shuttle Interdictor"

/obj/effect/landmark/outbound/gateway_space_edge
	name = "Gateway Space Edge"
