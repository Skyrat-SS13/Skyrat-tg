/datum/controller/subsystem/events/reschedule()
	var/filter_threshold = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)

	if(!SSticker.HasRoundStarted()) // Roundstart
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * EVENT_MIDPOP_TIMER_MULTIPLIER)
		log_game("ICES: Event timer initialising for roundstart at [EVENT_MIDPOP_TIMER_MULTIPLIER]x")
		message_admins("ICES: Event timer initialising for roundstart at [EVENT_MIDPOP_TIMER_MULTIPLIER]x")
		return
	else if(filter_threshold < EVENT_LOWPOP_THRESHOLD) // Lowpop gets events less often
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * EVENT_LOWPOP_TIMER_MULTIPLIER)
		log_game("ICES: Event timer multiplier is [EVENT_LOWPOP_TIMER_MULTIPLIER]x (LOWPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time)]")
		message_admins("ICES: Event timer multiplier is [EVENT_LOWPOP_TIMER_MULTIPLIER]x (LOWPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time)]")
	else if(filter_threshold < EVENT_MIDPOP_THRESHOLD) // Midpop gets events less often
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * EVENT_MIDPOP_TIMER_MULTIPLIER)
		log_game("ICES: Event timer multiplier is [EVENT_MIDPOP_TIMER_MULTIPLIER]x (MIDPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time)]")
		message_admins("ICES: Event timer multiplier is [EVENT_MIDPOP_TIMER_MULTIPLIER]x (MIDPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time)]")
	else
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * EVENT_HIGHPOP_TIMER_MULTIPLIER)
		log_game("ICES: Event timer multiplier is [EVENT_HIGHPOP_TIMER_MULTIPLIER]x (HIGHPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time)]")
		message_admins("ICES: Event timer multiplier is [EVENT_HIGHPOP_TIMER_MULTIPLIER]x (HIGHPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time)]")

	log_game("ICES: Reschedule proc calling for timed intensity credit")
	change_intensity_credits(2, 1, TRUE, TRUE, TRUE)
