/obj/effect/countdown/ci_timeout_period
	invisibility = INVISIBILITY_NONE

	/// The world.time in which we expire. Set on start.
	var/time_end

/obj/effect/countdown/ci_timeout_period/start()
	var/duration = CONFIG_GET(number/combat_indicator_timeout_period) SECONDS
	time_end = world.time + duration

	displayed_text = duration
	return ..()

/obj/effect/countdown/ci_timeout_period/process()
	. = ..()

	if (displayed_text <= 0)
		if (isliving(attached_to))
			attached_to.balloon_alert_to_viewers("ci timeout expired!")
			var/mob/living/living_attached = attached_to
			living_attached.log_message("ci timeout expired", LOG_ATTACK, color="red")
		qdel(src)

/obj/effect/countdown/ci_timeout_period/get_value()
	return ((time_end - world.time) * 0.1)

