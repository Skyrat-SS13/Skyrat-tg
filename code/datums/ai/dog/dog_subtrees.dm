/// Find someone we don't like and annoy them
/datum/ai_planning_subtree/dog_harassment

/datum/ai_planning_subtree/dog_harassment/SelectBehaviors(datum/ai_controller/controller, delta_time)
	if(!DT_PROB(10, delta_time))
		return
	controller.queue_behavior(/datum/ai_behavior/find_hated_dog_target, BB_DOG_HARASS_TARGET, BB_PET_TARGETTING_DATUM)
	var/datum/weakref/weak_target = controller.blackboard[BB_DOG_HARASS_TARGET]
	var/atom/harass_target = weak_target?.resolve()
	if (isnull(harass_target))
		return

<<<<<<< HEAD
	// if we're not already carrying something and we have a fetch target (and we're not already doing something with it), see if we can eat/equip it
	if(!controller.blackboard[BB_SIMPLE_CARRY_ITEM] && controller.blackboard[BB_FETCH_TARGET])
		var/atom/movable/interact_target = controller.blackboard[BB_FETCH_TARGET]
		if(in_range(living_pawn, interact_target) && (isturf(interact_target.loc)))
			controller.set_movement_target(interact_target)
			if(IS_EDIBLE(interact_target))
				controller.queue_behavior(/datum/ai_behavior/eat_snack)
			else if(isitem(interact_target))
				controller.queue_behavior(/datum/ai_behavior/simple_equip)
			else
				controller.blackboard[BB_FETCH_TARGET] = null
				controller.blackboard[BB_FETCH_DELIVER_TO] = null
			return

	// if we're carrying something and we have a destination to deliver it, do that
	if(controller.blackboard[BB_SIMPLE_CARRY_ITEM] && controller.blackboard[BB_FETCH_DELIVER_TO])
		var/atom/return_target = controller.blackboard[BB_FETCH_DELIVER_TO]
		if(!can_see(controller.pawn, return_target, length=AI_DOG_VISION_RANGE))
			// if the return target isn't in sight, we'll just forget about it and carry the thing around
			controller.blackboard[BB_FETCH_DELIVER_TO] = null
			return
		controller.set_movement_target(return_target)
		controller.queue_behavior(/datum/ai_behavior/deliver_item)
		return
=======
	controller.queue_behavior(/datum/ai_behavior/basic_melee_attack/dog, BB_DOG_HARASS_TARGET, BB_PET_TARGETTING_DATUM)
	return SUBTREE_RETURN_FINISH_PLANNING

/datum/ai_behavior/find_hated_dog_target

/datum/ai_behavior/find_hated_dog_target/setup(datum/ai_controller/controller, target_key, targetting_datum_key)
	. = ..()
	var/mob/living/dog = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	for(var/mob/living/iter_living in oview(2, dog))
		if(iter_living.stat != CONSCIOUS || !HAS_TRAIT(iter_living, TRAIT_HATED_BY_DOGS))
			continue
		if(!targetting_datum.can_attack(dog, iter_living))
			continue

		dog.audible_message(span_warning("[dog] growls at [iter_living], seemingly annoyed by [iter_living.p_their()] presence."), hearing_distance = COMBAT_MESSAGE_RANGE)
		controller.blackboard[target_key] = WEAKREF(iter_living)
		controller.blackboard[BB_DOG_HARASS_HARM] = FALSE
		return TRUE

	controller.blackboard[target_key] = null

/datum/ai_behavior/find_hated_dog_target/perform(delta_time, datum/ai_controller/controller, target_key)
	. = ..()
	finish_action(controller, TRUE)
>>>>>>> eb6c0eb37c0 (Dogs use the Pet Command system (#72045))
