/obj/effect/landmark/away_objective
	name = "away mission objective landmark"
	/// The range from the objective for it to go away for the user
	var/range_req = 2
	/// Mobs who have yet to trigger the objective
	var/list/untriggered_mobs = list()
	/// Has the thing actually been enabled yet
	var/enabled = FALSE

/obj/effect/landmark/away_objective/Initialize(mapload)
	. = ..()
	OUTBOUND_CONTROLLER
	for(var/mob/not_dead_mob in outbound_controller.participating_mobs)
		if(not_dead_mob.stat == DEAD)
			continue
		untriggered_mobs |= not_dead_mob

/// To enable the objective itself
/obj/effect/landmark/away_objective/proc/enable()
	for(var/turf/iterating_turf in range(range_req, src))
		RegisterSignal(iterating_turf, COMSIG_ATOM_ENTERED, .proc/trigger)

/// To get rid of the popup when someone with the objective gets near
/obj/effect/landmark/away_objective/proc/trigger(datum/source, atom/movable/entered_atom)
	SIGNAL_HANDLER
	OUTBOUND_CONTROLLER

	if(!isliving(entered_atom))
		return

	var/mob/living/entered_mob = entered_atom

	var/datum/status_effect/agent_pinpointer/away_objective/obj_pinpoint = entered_mob.has_status_effect(/datum/status_effect/agent_pinpointer/away_objective)
	if(!obj_pinpoint)
		return
	if(obj_pinpoint.scan_target == src)
		outbound_controller.clear_objective(entered_mob)
	if(!length(untriggered_mobs))
		qdel(src)

