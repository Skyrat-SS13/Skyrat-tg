/datum/status_effect/incapacitating/stun/on_apply()
	. = ..()
	owner.add_status_indicator(STUNNED)

/datum/status_effect/incapacitating/stun/on_remove()
	. = ..()
	owner.remove_status_indicator(STUNNED)


/datum/status_effect/incapacitating/knockdown/on_apply()
	. = ..()
	owner.add_status_indicator(WEAKEN)

/datum/status_effect/incapacitating/knockdown/on_remove()
	. = ..()
	if(id != STAT_TRAIT)
		owner.remove_status_indicator(WEAKEN)

/datum/status_effect/incapacitating/immobilized/on_apply()
	. = ..()
	owner.add_status_indicator(WEAKEN)
/datum/status_effect/incapacitating/immobilized/on_remove()
	. = ..()
	if(id != STAT_TRAIT)
		owner.remove_status_indicator(WEAKEN)

/datum/status_effect/incapacitating/paralyzed/on_apply()
	. = ..()
	owner.add_status_indicator(PARALYSIS)

/datum/status_effect/incapacitating/paralyzed/on_remove()
	. = ..()
	owner.remove_status_indicator(PARALYSIS)

/datum/status_effect/incapacitating/incapacitated/on_apply()
	. = ..()
	owner.add_status_indicator(WEAKEN)

/datum/status_effect/incapacitating/incapacitated/on_remove()
	. = ..()
	owner.remove_status_indicator(WEAKEN)

/datum/status_effect/incapacitating/unconscious/on_apply()
	. = ..()
	owner.add_status_indicator(SLEEPING)

/datum/status_effect/incapacitating/unconscious/on_remove()
	. = ..()
	owner.remove_status_indicator(SLEEPING)

/datum/status_effect/incapacitating/sleeping/on_apply()
	. = ..()
	if(!HAS_TRAIT(owner, TRAIT_SLEEPIMMUNE))
		owner.add_status_indicator(SLEEPING)
/datum/status_effect/incapacitating/sleeping/on_remove()
	. = ..()
	owner.remove_status_indicator(SLEEPING)

/datum/status_effect/grouped/stasis/on_apply()
	. = ..()
	owner.add_status_indicator(PARALYSIS)
/datum/status_effect/grouped/stasis/on_remove()
	. = ..()
	owner.remove_status_indicator(PARALYSIS)
