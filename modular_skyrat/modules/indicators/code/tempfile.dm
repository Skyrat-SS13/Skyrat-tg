/mob/living

/obj/effect/countdown/ci_timeout_period
	invisibility = INVISIBILITY_NONE

	var/time_end

	var/duration = 5 SECONDS

/obj/effect/countdown/ci_timeout_period/Destroy()
	var/mob/living/attached = attached_to
	attached?.timeout_countdown = null

	return ..()

/obj/effect/countdown/ci_timeout_period/start()
	time_end = world.time + duration

	displayed_text = duration
	return ..()

/obj/effect/countdown/ci_timeout_period/process()
	. = ..()

	if (displayed_text <= 0)
		attached_to.balloon_alert_to_viewers("ci timeout expired!")
		qdel(src)

/obj/effect/countdown/ci_timeout_period/get_value()
	return ((time_end - world.time) * 0.1)

