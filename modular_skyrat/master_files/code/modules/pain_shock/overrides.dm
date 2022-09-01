/mob/living/carbon/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/status_indicator)

/mob/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOB_CLIENT_LOGIN, .proc/apply_status_indicator_pref)
