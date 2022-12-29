<<<<<<< HEAD
/datum/ai_behavior/battle_screech/dog
	screeches = list("barks","howls")

/// Fetching makes the pawn chase after whatever it's targeting and pick it up when it's in range, with the dog_equip behavior
/datum/ai_behavior/fetch
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/fetch/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/living_pawn = controller.pawn
	var/obj/item/fetch_thing = controller.blackboard[BB_FETCH_TARGET]

	//either we can't pick it up, or we'd rather eat it, so stop trying.
	if(fetch_thing.anchored || !isturf(fetch_thing.loc) || IS_EDIBLE(fetch_thing) || !living_pawn.CanReach(fetch_thing))
		finish_action(controller, FALSE)
		return

	finish_action(controller, TRUE)

/datum/ai_behavior/fetch/finish_action(datum/ai_controller/controller, success)
	. = ..()

	if(!success) //Don't try again on this item if we failed
		var/obj/item/target = controller.blackboard[BB_FETCH_TARGET]
		if(target)
			controller.blackboard[BB_FETCH_IGNORE_LIST][WEAKREF(target)] = TRUE
		controller.blackboard[BB_FETCH_TARGET] = null
		controller.blackboard[BB_FETCH_DELIVER_TO] = null


/// This is simply a behaviour to pick up a fetch target
/datum/ai_behavior/simple_equip/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/obj/item/fetch_target = controller.blackboard[BB_FETCH_TARGET]
	if(!isturf(fetch_target?.loc) || !isitem(fetch_target)) // someone picked it up, something happened to it, or it wasn't an item anyway
		finish_action(controller, FALSE)
		return

	if(in_range(controller.pawn, fetch_target))
		pickup_item(controller, fetch_target)
		finish_action(controller, TRUE)
	else
		finish_action(controller, FALSE)

/datum/ai_behavior/simple_equip/finish_action(datum/ai_controller/controller, success)
	. = ..()
	controller.blackboard[BB_FETCH_TARGET] = null
	if(!success)
		controller.blackboard[BB_FETCH_DELIVER_TO] = null

/datum/ai_behavior/simple_equip/proc/pickup_item(datum/ai_controller/controller, obj/item/target)
	var/atom/pawn = controller.pawn
	drop_item(controller)
	pawn.visible_message(span_notice("[pawn] picks up [target] in [pawn.p_their()] mouth."))
	target.forceMove(pawn)
	controller.blackboard[BB_SIMPLE_CARRY_ITEM] = target
	return TRUE

/datum/ai_behavior/simple_equip/proc/drop_item(datum/ai_controller/controller)
	var/obj/item/carried_item = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	if(!carried_item)
		return

	var/atom/pawn = controller.pawn
	pawn.visible_message(span_notice("[pawn] drops [carried_item]."))
	carried_item.forceMove(get_turf(pawn))
	controller.blackboard[BB_SIMPLE_CARRY_ITEM] = null
	return TRUE



/// This behavior involves dropping off a carried item to a specified person (or place)
/datum/ai_behavior/deliver_item
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/deliver_item/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/return_target = controller.blackboard[BB_FETCH_DELIVER_TO]
	if(!return_target)
		finish_action(controller, FALSE)
	if(in_range(controller.pawn, return_target))
		deliver_item(controller)
		finish_action(controller, TRUE)

/datum/ai_behavior/deliver_item/finish_action(datum/ai_controller/controller, success)
	. = ..()
	controller.blackboard[BB_FETCH_TARGET] = null
	controller.blackboard[BB_FETCH_DELIVER_TO] = null

/// Actually drop the fetched item to the target
/datum/ai_behavior/deliver_item/proc/deliver_item(datum/ai_controller/controller)
	var/obj/item/carried_item = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	var/atom/movable/return_target = controller.blackboard[BB_FETCH_DELIVER_TO]
	if(!carried_item || !return_target)
		finish_action(controller, FALSE)
		return

	if(ismob(return_target))
		controller.pawn.visible_message(span_notice("[controller.pawn] delivers [carried_item] at [return_target]'s feet."))
	else // not sure how to best phrase this
		controller.pawn.visible_message(span_notice("[controller.pawn] delivers [carried_item] to [return_target]."))

	carried_item.forceMove(get_turf(return_target))
	controller.blackboard[BB_SIMPLE_CARRY_ITEM] = null
	return TRUE

/// This behavior involves either eating a snack we can reach, or begging someone holding a snack
/datum/ai_behavior/eat_snack
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT

/datum/ai_behavior/eat_snack/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/obj/item/snack = controller.current_movement_target
	if(!istype(snack) || !IS_EDIBLE(snack) || !(isturf(snack.loc) || ishuman(snack.loc)))
		finish_action(controller, FALSE)

	var/mob/living/living_pawn = controller.pawn
	if(!in_range(living_pawn, snack))
		return

	if(isturf(snack.loc))
		snack.attack_animal(living_pawn) // snack attack!
	else if(iscarbon(snack.loc) && DT_PROB(10, delta_time))
		living_pawn.manual_emote("stares at [snack.loc]'s [snack.name] with a sad puppy-face.")

	if(QDELETED(snack)) // we ate it!
		finish_action(controller, TRUE)


/// This behavior involves either eating a snack we can reach, or begging someone holding a snack
/datum/ai_behavior/play_dead
	behavior_flags = NONE

/datum/ai_behavior/play_dead/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/mob/living/basic/simple_pawn = controller.pawn
	if(!istype(simple_pawn))
		return

	if(!controller.blackboard[BB_DOG_PLAYING_DEAD])
		controller.blackboard[BB_DOG_PLAYING_DEAD] = TRUE
		simple_pawn.emote("deathgasp", intentional=FALSE)
		simple_pawn.icon_state = simple_pawn.icon_dead
		if(simple_pawn.flip_on_death)
			simple_pawn.transform = simple_pawn.transform.Turn(180)
		simple_pawn.set_density(FALSE)

	if(DT_PROB(10, delta_time))
		finish_action(controller, TRUE)

/datum/ai_behavior/play_dead/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	var/mob/living/basic/simple_pawn = controller.pawn
	if(!istype(simple_pawn) || simple_pawn.stat) // imagine actually dying while playing dead. hell, imagine being the kid waiting for your pup to get back up :(
		return
	controller.blackboard[BB_DOG_PLAYING_DEAD] = FALSE
	simple_pawn.visible_message(span_notice("[simple_pawn] springs to [simple_pawn.p_their()] feet, panting excitedly!"))
	simple_pawn.icon_state = simple_pawn.icon_living
	if(simple_pawn.flip_on_death)
		simple_pawn.transform = simple_pawn.transform.Turn(180)
	simple_pawn.set_density(initial(simple_pawn.density))

/// This behavior involves either eating a snack we can reach, or begging someone holding a snack
/datum/ai_behavior/harass
=======
/**
 * Pursue the target, growl if we're close, and bite if we're adjacent
 * Dogs are actually not very aggressive and won't attack unless you approach them
 * Adds a floor to the melee damage of the dog, as most pet dogs don't actually have any melee strength
 */
/datum/ai_behavior/basic_melee_attack/dog
	action_cooldown = 0.8 SECONDS
>>>>>>> eb6c0eb37c0 (Dogs use the Pet Command system (#72045))
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM
	required_distance = 1

/datum/ai_behavior/basic_melee_attack/dog/perform(delta_time, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	controller.behavior_cooldowns[src] = world.time + action_cooldown
	var/mob/living/living_pawn = controller.pawn
	if(!(isturf(living_pawn.loc) || HAS_TRAIT(living_pawn, TRAIT_AI_BAGATTACK))) // Void puppies can attack from inside bags
		finish_action(controller, FALSE, target_key, targetting_datum_key, hiding_location_key)
		return

	// Unfortunately going to repeat this check in parent call but what can you do
	var/datum/weakref/weak_target = controller.blackboard[target_key]
	var/atom/target = weak_target?.resolve()
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]
	if (!targetting_datum.can_attack(living_pawn, target))
		finish_action(controller, FALSE, target_key, targetting_datum_key, hiding_location_key)
		return

	if (!in_range(living_pawn, target))
		growl_at(living_pawn, target, delta_time)
		return

	if(!controller.blackboard[BB_DOG_HARASS_HARM])
		paw_harmlessly(living_pawn, target, delta_time)
		return

	// Give Ian some teeth
	var/old_melee_lower = living_pawn.melee_damage_lower
	var/old_melee_upper = living_pawn.melee_damage_upper
	living_pawn.melee_damage_lower = max(5, old_melee_lower)
	living_pawn.melee_damage_upper = max(10, old_melee_upper)

	. = ..() // Bite time

	living_pawn.melee_damage_lower = old_melee_lower
	living_pawn.melee_damage_upper = old_melee_upper

/// Swat at someone we don't like but won't hurt
/datum/ai_behavior/basic_melee_attack/dog/proc/paw_harmlessly(mob/living/living_pawn, atom/target, delta_time)
	if(!DT_PROB(20, delta_time))
		return
	living_pawn.do_attack_animation(target, ATTACK_EFFECT_DISARM)
	playsound(target, 'sound/weapons/thudswoosh.ogg', 50, TRUE, -1)
	target.visible_message(span_danger("[living_pawn] paws ineffectually at [target]!"), span_danger("[living_pawn] paws ineffectually at you!"))

/// Let them know we mean business
/datum/ai_behavior/basic_melee_attack/dog/proc/growl_at(mob/living/living_pawn, atom/target, delta_time)
	if(!DT_PROB(15, delta_time))
		return
<<<<<<< HEAD

	controller.blackboard[BB_DOG_HARASS_FRUSTRATION] = world.time

	// make sure the pawn gets some temporary strength boost to actually attack the target instead of pathetically nuzzling them.
	var/old_melee_lower = living_pawn.melee_damage_lower
	var/old_melee_upper = living_pawn.melee_damage_upper
	living_pawn.melee_damage_lower = max(5, old_melee_lower)
	living_pawn.melee_damage_upper = max(10, old_melee_upper)

	living_pawn.UnarmedAttack(living_target, FALSE)

	living_pawn.melee_damage_lower = old_melee_lower
	living_pawn.melee_damage_upper = old_melee_upper
=======
	living_pawn.manual_emote("[pick("barks", "growls", "stares")] menacingly at [target]!")
	if(!DT_PROB(40, delta_time))
		return
	playsound(living_pawn, pick('sound/creatures/dog/growl1.ogg', 'sound/creatures/dog/growl2.ogg'), 50, TRUE, -1)
>>>>>>> eb6c0eb37c0 (Dogs use the Pet Command system (#72045))
