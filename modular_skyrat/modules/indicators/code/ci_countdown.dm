/obj/effect/countdown/ci_timeout_period
	invisibility = INVISIBILITY_NONE

	/// The world.time in which we expire. Set on start.
	var/time_end
	var/mob/living/holder

/obj/effect/countdown/ci_timeout_period/Initialize(mapload)
	if (!isliving(loc))
		stack_trace("a ci timeout countdown was incorrectly applied!")
		qdel(src)
		return

	holder = loc
	return ..()

/obj/effect/countdown/ci_timeout_period/Destroy()
	holder.timeout_countdown = null
	holder = null

	return ..()

/obj/effect/countdown/ci_timeout_period/start()
	var/duration = CONFIG_GET(number/combat_indicator_timeout_period) SECONDS
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

