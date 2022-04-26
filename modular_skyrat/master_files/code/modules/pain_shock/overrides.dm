/datum/status_effect/incapacitating/stun/on_apply()
	. = ..()
	owner.add_status_indicator("stunned") // SKYRAT EDIT ADDITION: Status indicators

/datum/status_effect/incapacitating/stun/on_remove()
	. = ..()
	owner.remove_status_indicator("stunned") // SKYRAT EDIT ADDITION: Status indicators


/datum/status_effect/incapacitating/knockdown/on_apply()
	. = ..()
	owner.add_status_indicator("weakened") // SKYRAT EDIT ADDITION: Status indicators

/datum/status_effect/incapacitating/knockdown/on_remove()
	. = ..()
	if(id != STAT_TRAIT)
		owner.remove_status_indicator("weakened") // SKYRAT EDIT ADDITION: Status indicators

/datum/status_effect/incapacitating/immobilized/on_apply()
	. = ..()
	owner.add_status_indicator("weakened")
/datum/status_effect/incapacitating/immobilized/on_remove()
	. = ..()
	if(id != STAT_TRAIT)
		owner.remove_status_indicator("weakened") // SKYRAT EDIT ADDITION: Status indicators

/datum/status_effect/incapacitating/paralyzed/on_apply()
	. = ..()
	owner.add_status_indicator("paralysis") // SKYRAT EDIT ADDITION: Status indicators

/datum/status_effect/incapacitating/paralyzed/on_remove()
	. = ..()
	owner.remove_status_indicator("paralysis") // SKYRAT EDIT ADDITION: Status indicators


/* */

/datum/status_effect/incapacitating/incapacitated/on_apply()
	. = ..()
	owner.add_status_indicator("weakened") // SKYRAT EDIT ADDITION: Status indicators



/datum/status_effect/incapacitating/incapacitated/on_remove()
	. = ..()
	owner.remove_status_indicator("weakened") // SKYRAT EDIT ADDITION: Status indicators


/datum/status_effect/incapacitating/unconscious/on_apply()
	. = ..()
	owner.add_status_indicator("sleeping") // SKYRAT EDIT ADDITION: Status indicators

/datum/status_effect/incapacitating/unconscious/on_remove()
	. = ..()
	owner.remove_status_indicator("sleeping") // SKYRAT EDIT ADDITION: Status indicators





/*
/datum/status_effect/incapacitating/sleeping/on_apply()
	. = ..()
	if(!HAS_TRAIT(owner, TRAIT_SLEEPIMMUNE))
		owner.add_status_indicator("sleeping") // SKYRAT EDIT ADDITION: Status indicators
/datum/status_effect/incapacitating/sleeping/on_remove()
	. = ..()
	if(!HAS_TRAIT(owner, TRAIT_SLEEPIMMUNE))
		owner.remove_status_indicator("sleeping") // SKYRAT EDIT ADDITION: Status indicators
*/


/datum/status_effect/grouped/stasis/on_apply()
	. = ..()
	owner.add_status_indicator("paralysis") // SKYRAT EDIT ADDITION: Status indicators
/datum/status_effect/grouped/stasis/on_remove()
	. = ..()
	owner.remove_status_indicator("paralysis") // SKYRAT EDIT ADDITION: Status indicators
