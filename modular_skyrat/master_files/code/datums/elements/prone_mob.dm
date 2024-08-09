/datum/element/prone_mob
	var/mob/living/pronemob

/datum/element/prone_mob/Attach(datum/target)
	. = ..()
	if(!isliving(target))
		return ELEMENT_INCOMPATIBLE
	pronemob = target
	pronemob.add_traits(list(TRAIT_PRONE, TRAIT_FLOORED, TRAIT_NO_THROWING), type)
	passtable_on(pronemob)
	pronemob.layer = PROJECTILE_HIT_THRESHHOLD_LAYER
	RegisterSignals(target, list(COMSIG_MOVABLE_REMOVE_PRONE_STATE, COMSIG_LIVING_GET_PULLED), PROC_REF(Detach))
	RegisterSignals(target, list(COMSIG_MOB_ATTACK_HAND, COMSIG_MOB_ITEM_ATTACK), PROC_REF(check_attack))
	RegisterSignal(target, COMSIG_LIVING_TRY_PULL, PROC_REF(check_pull))

/datum/element/prone_mob/Detach(datum/source)

	pronemob.remove_traits(list(TRAIT_PRONE, TRAIT_FLOORED, TRAIT_NO_THROWING), type)
	if(!istype(pronemob, /mob/living/basic/cortical_borer))
		passtable_off(pronemob)
	UnregisterSignal(source, list(
		COMSIG_LIVING_GET_PULLED,
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ITEM_ATTACK,
		COMSIG_LIVING_GET_PULLED,
		COMSIG_LIVING_TRY_PULL
		))
	pronemob.layer = MOB_LAYER
	return ..()

/datum/element/prone_mob/proc/check_attack(mob/living/source)
	SIGNAL_HANDLER
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/element/prone_mob/proc/check_pull(mob/living/source)
	SIGNAL_HANDLER
	return COMSIG_LIVING_CANCEL_PULL
