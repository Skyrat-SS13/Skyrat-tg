/datum/controller/subsystem/events/reschedule()
	var/filter_threshold = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)

	if(!SSticker.HasRoundStarted()) // Roundstart
		intensity_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * intensity_multiplier)
		log_game("ICES: Event timer initialising for roundstart at [intensity_multiplier]x")
		message_admins("ICES: Event timer initialising for roundstart at [intensity_multiplier]x")
		return
	else if(filter_threshold < EVENT_LOWPOP_THRESHOLD) // Lowpop gets events less often
		intensity_multiplier = EVENT_LOWPOP_TIMER_MULTIPLIER
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * intensity_multiplier)
		log_game("ICES: Event timer multiplier is [intensity_multiplier]x (LOWPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [intensity_multiplier]x (LOWPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")
	else if(filter_threshold < EVENT_MIDPOP_THRESHOLD) // Midpop gets events less often
		intensity_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * intensity_multiplier)
		log_game("ICES: Event timer multiplier is [intensity_multiplier]x (MIDPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [intensity_multiplier]x (MIDPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")
	else
		intensity_multiplier = EVENT_HIGHPOP_TIMER_MULTIPLIER
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * intensity_multiplier)
		log_game("ICES: Event timer multiplier is [EVENT_HIGHPOP_TIMER_MULTIPLIER]x (HIGHPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [intensity_multiplier]x (HIGHPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")

	log_game("ICES: Reschedule proc calling for timed intensity credit")
	change_intensity_credits(2, 1, TRUE, TRUE, FALSE)
