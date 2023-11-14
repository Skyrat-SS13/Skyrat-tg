/obj/effect/countdown/ci_timeout_period
	invisibility = INVISIBILITY_NONE

	/// The world.time in which we expire. Set on start.
	var/time_end

/obj/effect/countdown/ci_timeout_period/Destroy()
	var/mob/living/attached = attached_to
	attached?.timeout_countdown = null

	return ..()

/obj/effect/countdown/ci_timeout_period/start()
	var/duration = CONFIG_GET(number/combat_indicator_timeout_period)
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

