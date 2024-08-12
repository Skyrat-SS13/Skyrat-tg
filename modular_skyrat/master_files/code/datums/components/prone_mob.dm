/datum/component/prone_mob
	var/mob/living/pronemob

/datum/component/prone_mob/Initialize(...)
	. = ..()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	pronemob = parent
	pronemob.add_traits(list(TRAIT_PRONE, TRAIT_FLOORED, TRAIT_NO_THROWING), type)
	pronemob.add_traits(list(TRAIT_PRONE, TRAIT_FLOORED, TRAIT_NO_THROWING), type)
	passtable_on(pronemob)
	pronemob.layer = PROJECTILE_HIT_THRESHHOLD_LAYER

/datum/component/prone_mob/RegisterWithParent()
	RegisterSignals(target, list(COMSIG_MOVABLE_REMOVE_PRONE_STATE, COMSIG_LIVING_GET_PULLED), PROC_REF(stop_army_crawl))
	RegisterSignals(parent, list(COMSIG_MOB_ATTACK_HAND, COMSIG_MOB_ITEM_ATTACK), PROC_REF(check_attack))
	RegisterSignal(parent, COMSIG_LIVING_TRY_PULL, PROC_REF(check_pull))

/datum/component/prone_mob/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_LIVING_GET_PULLED,
		COMSIG_MOB_ATTACK_HAND,
		COMSIG_MOB_ITEM_ATTACK,
		COMSIG_LIVING_GET_PULLED,
		COMSIG_LIVING_TRY_PULL
		))
	return ..()

/datum/component/prone_mob/proc/check_attack(mob/living/source)
	SIGNAL_HANDLER
	return COMPONENT_CANCEL_ATTACK_CHAIN

/datum/component/prone_mob/proc/check_pull(mob/living/source)
	SIGNAL_HANDLER
	return COMSIG_LIVING_CANCEL_PULL

/datum/component/prone_mob/proc/stop_army_crawl(mob/living/source)
	SIGNAL_HANDLER
	pronemob.remove_traits(list(TRAIT_PRONE, TRAIT_FLOORED, TRAIT_NO_THROWING), type)
	if(!istype(pronemob, /mob/living/basic/cortical_borer))
		passtable_off(pronemob)
	pronemob.layer = MOB_LAYER
	pronemob = null
	qdel(src)
