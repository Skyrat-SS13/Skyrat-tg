// Because the orginal procs never call their parents... enjoy this copypasta mess.
// We also could use sprites for unique effects, so that sharing isn't needed!
/datum/status_effect/incapacitating/stun/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)
/datum/status_effect/incapacitating/stun/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/knockdown/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/knockdown/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/immobilized/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/immobilized/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/paralyzed/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/paralyzed/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/incapacitated/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/incapacitated/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/unconscious/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/unconscious/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/sleeping/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/incapacitating/sleeping/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/grouped/stasis/on_apply()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)

/datum/status_effect/grouped/stasis/on_remove()
	. = ..()
	SEND_SIGNAL(owner, COMSIG_CARBON_HEALTH_UPDATE, /mob/living/.proc/status_sanity)
