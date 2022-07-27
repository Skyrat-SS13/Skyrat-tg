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
	for(var/mob/not_dead_mob in outbound_controller.participating_mobs)
		if(not_dead_mob.stat == DEAD)
			continue
		untriggered_mobs |= not_dead_mob
	for(var/turf/iterating_turf in range(range_req, src))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/trigger)
	enabled = TRUE

/// To get rid of the popup when someone with the objective gets near
/obj/effect/landmark/away_objective/proc/trigger(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER
	OUTBOUND_CONTROLLER

	if(!isliving(entered_atom) || !(entered_atom in untriggered_mobs))
		return

	var/mob/living/entered_mob = entered_atom

	var/datum/status_effect/agent_pinpointer/away_objective/obj_pinpoint = entered_mob.has_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	if(!obj_pinpoint)
		return
	if(obj_pinpoint.scan_target == src)
		outbound_controller.clear_objective(entered_mob)
	untriggered_mobs -= entered_mob
	if(!length(untriggered_mobs))
		qdel(src)


// actual landmarks here

/obj/effect/landmark/away_objective/talk_person
	id = "talk_person"

/obj/effect/landmark/away_objective/talk_person/trigger(datum/source, atom/movable/entered_atom)
	. = ..()
	// add custom code here

/obj/effect/landmark/away_objective/cryo
	id = "cryo"


// other landmark shit that i might move later
/obj/effect/landmark/objective_update/cryo

/obj/effect/landmark/objective_update/cryo/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	OUTBOUND_CONTROLLER
	if(!ismob(arrived))
		return
	//finish later i've been at this for like five hours
	var/datum/outbound_objective/cryo_obj = outbound_controller.objectives[/datum/outbound_objective/cryo]
	if(outbound_controller.participating_mobs[arrived] == cryo_obj)
		return
	outbound_controller.give_objective(arrived, cryo_obj)
