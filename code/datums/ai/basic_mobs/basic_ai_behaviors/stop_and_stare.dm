/// Makes a mob simply stop and stare at a movable... yea...
/datum/ai_behavior/stop_and_stare
	behavior_flags = AI_BEHAVIOR_MOVE_AND_PERFORM

/datum/ai_behavior/stop_and_stare/setup(datum/ai_controller/controller, target_key)
	. = ..()
	var/atom/movable/target = controller.blackboard[target_key]
	return ismovable(target) && isturf(target.loc) && ismob(controller.pawn)

/datum/ai_behavior/stop_and_stare/perform(seconds_per_tick, datum/ai_controller/controller, target_key)
<<<<<<< HEAD
	// i don't really like doing this but we wanna make sure that the cooldown is pertinent to what we need for this specific controller before we invoke parent
	action_cooldown = controller.blackboard[BB_STATIONARY_COOLDOWN]
	. = ..()
=======
>>>>>>> 1e78db84714 (Refactors how basic ais do their success/failures (#82643))
	var/atom/movable/target = controller.blackboard[target_key]
	if(!ismovable(target) || !isturf(target.loc)) // just to make sure that nothing funky happened between setup and perform
		return AI_BEHAVIOR_DELAY

	var/mob/pawn_mob = controller.pawn
	var/turf/pawn_turf = get_turf(pawn_mob)

	pawn_mob.face_atom(target)
	pawn_mob.balloon_alert_to_viewers("stops and stares...")
	set_movement_target(controller, pawn_turf, /datum/ai_movement/complete_stop)

	if(controller.blackboard[BB_STATIONARY_MOVE_TO_TARGET])
		addtimer(CALLBACK(src, PROC_REF(set_movement_target), controller, target, initial(controller.ai_movement)), (controller.blackboard[BB_STATIONARY_SECONDS] + 1 SECONDS))
	return AI_BEHAVIOR_DELAY
