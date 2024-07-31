/// Try to escape from your current target, without performing any other actions.
/datum/ai_planning_subtree/flee_target
	/// Behaviour to execute in order to flee
	var/flee_behaviour = /datum/ai_behavior/run_away_from_target
	/// Blackboard key in which to store selected target
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET
	/// Blackboard key in which to store selected target's hiding place
	var/hiding_place_key = BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION

/datum/ai_planning_subtree/flee_target/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/flee_from = controller.blackboard[target_key]
<<<<<<< HEAD
	if (controller.blackboard[BB_BASIC_MOB_STOP_FLEEING] || QDELETED(flee_from))
=======
	if(!should_flee(controller, flee_from))
>>>>>>> d4bd72800d0e ([NO GBP] Lil' fix to fishing hat PR. (#85459))
		return
	var/flee_distance = controller.blackboard[BB_BASIC_MOB_FLEE_DISTANCE] || DEFAULT_BASIC_FLEE_DISTANCE
	if (get_dist(controller.pawn, flee_from) >= flee_distance)
		return

	controller.queue_behavior(flee_behaviour, target_key, hiding_place_key)
	return SUBTREE_RETURN_FINISH_PLANNING //we gotta get out of here.

/// Try to escape from your current target, without performing any other actions.
/// Reads from some fleeing-specific targeting keys rather than the current mob target.
/datum/ai_planning_subtree/flee_target/from_flee_key
	target_key = BB_BASIC_MOB_FLEE_TARGET
	hiding_place_key = BB_BASIC_MOB_FLEE_TARGET_HIDING_LOCATION
