/datum/ai_controller/basic_controller
	movement_delay = 0.4 SECONDS

/datum/ai_controller/basic_controller/TryPossessPawn(atom/new_pawn)
	if(!isbasicmob(new_pawn))
		return AI_CONTROLLER_INCOMPATIBLE
	var/mob/living/basic/basic_mob = new_pawn

	update_speed(basic_mob)

	RegisterSignals(basic_mob, list(POST_BASIC_MOB_UPDATE_VARSPEED, COMSIG_MOB_MOVESPEED_UPDATED), PROC_REF(update_speed))

	return ..() //Run parent at end

<<<<<<< HEAD

/datum/ai_controller/basic_controller/able_to_run()
	. = ..()
	if(!isliving(pawn))
		return
	var/mob/living/living_pawn = pawn
	var/incap_flags = NONE
	if (ai_traits & CAN_ACT_IN_STASIS)
		incap_flags |= IGNORE_STASIS
	if(!(ai_traits & CAN_ACT_WHILE_DEAD) && (living_pawn.incapacitated(incap_flags) || living_pawn.stat))
		return FALSE
=======
/datum/ai_controller/basic_controller/on_stat_changed(mob/living/source, new_stat)
	. = ..()
	update_able_to_run()

/datum/ai_controller/basic_controller/setup_able_to_run()
	. = ..()
	RegisterSignal(pawn, COMSIG_MOB_INCAPACITATE_CHANGED, PROC_REF(update_able_to_run))

/datum/ai_controller/basic_controller/clear_able_to_run()
	UnregisterSignal(pawn, list(COMSIG_MOB_INCAPACITATE_CHANGED, COMSIG_MOB_STATCHANGE))
	return ..()

/datum/ai_controller/basic_controller/get_able_to_run()
	. = ..()
	if(!.)
		return FALSE
	var/mob/living/living_pawn = pawn
	if(!(ai_traits & CAN_ACT_WHILE_DEAD))
		// Unroll for flags here
		if (ai_traits & CAN_ACT_IN_STASIS && (living_pawn.stat || INCAPACITATED_IGNORING(living_pawn, INCAPABLE_STASIS)))
			return FALSE
		else if(IS_DEAD_OR_INCAP(living_pawn))
			return FALSE
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	if(ai_traits & PAUSE_DURING_DO_AFTER && LAZYLEN(living_pawn.do_afters))
		return FALSE

/datum/ai_controller/basic_controller/proc/update_speed(mob/living/basic/basic_mob)
	SIGNAL_HANDLER
	movement_delay = basic_mob.cached_multiplicative_slowdown
