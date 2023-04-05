/datum/status_effect/ropebunny
	id = "ropebunny"
	tick_interval = 10
	duration = INFINITE
	alert_type = null

/datum/status_effect/ropebunny/on_apply()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.add_mood_event("ropebunny", /datum/mood_event/ropebunny)

/datum/status_effect/ropebunny/on_remove()
	. = ..()
	var/mob/living/carbon/human/target = owner
	target.clear_mood_event("ropebunny")

/datum/mood_event/ropebunny
	description = span_purple("I'm tied! Cannot move! These ropes... Ah!~")
	mood_change = 0 // I don't want to doom the station to sonic-speed perverts, but still want to keep this as mood modifier.
