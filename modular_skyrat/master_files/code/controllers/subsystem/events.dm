/datum/controller/subsystem/events/reschedule()
	var/filter_threshold = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)

	if(filter_threshold < EVENT_LOWPOP_THRESHOLD) // Lowpop gets events less often
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * EVENT_LOWPOP_TIMER_MULTIPLIER)
		log_game("Event timer multiplier set to [EVENT_LOWPOP_TIMER_MULTIPLIER]x (LOWPOP) for [filter_threshold] players")
	else if(filter_threshold < EVENT_MIDPOP_THRESHOLD) // Midpop gets events less often
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * EVENT_MIDPOP_TIMER_MULTIPLIER)
		log_game("Event timer multiplier set to [EVENT_MIDPOP_TIMER_MULTIPLIER]x (MIDPOP) for [filter_threshold] players")
	else
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * EVENT_HIGHPOP_TIMER_MULTIPLIER)
		log_game("Event timer multiplier set to [EVENT_HIGHPOP_TIMER_MULTIPLIER]x (HIGHPOP) for [filter_threshold] players")

	change_intensity_credits(2, 1, TRUE, TRUE, FALSE)
