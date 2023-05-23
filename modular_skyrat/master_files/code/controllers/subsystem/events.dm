/// Check if we have an upcoming transfer vote, or we're already evacuating.
/datum/controller/subsystem/events/checkEvent()
	if(scheduled <= world.time)
		if(SSautotransfer.can_fire == TRUE && ((SSautotransfer.targettime - world.realtime) <= 15 MINUTES + CONFIG_GET(number/vote_period)))
			log_game("ICES: Event cancelled due to precondition check. Reason: Pending autotransfer vote.")
			log_game("ICES: Info: AT [(SSautotransfer.targettime - world.realtime)] | VP [(15 MINUTES + CONFIG_GET(number/vote_period))]")
			message_admins("ICES: Event cancelled due to precondition check. Reason: Pending autotransfer vote.")
			reschedule()
			return
		if(world.time - SSticker.round_start_time >= CONFIG_GET(number/shuttle_refuel_delay) && SSshuttle.canEvac() != TRUE)
			log_game("ICES: Event cancelled due to precondition check. Reason: [SSshuttle.canEvac() ? "shuttle refuelling" : "[SSshuttle.canEvac()]"]")
			log_game("ICES: Info: RT [(world.time - SSticker.round_start_time)] | SD [CONFIG_GET(number/shuttle_refuel_delay)]")
			message_admins("ICES: Event cancelled due to precondition check. Reason: [SSshuttle.canEvac() ? "shuttle refuelling" : "[SSshuttle.canEvac()]"]")
			reschedule()
			return
		spawnEvent()
		reschedule()

/datum/controller/subsystem/events/reschedule()
	var/filter_threshold = get_active_player_count(alive_check = TRUE, afk_check = TRUE, human_check = TRUE)

	if(!SSticker.HasRoundStarted()) // Roundstart
		active_intensity_multiplier = EVENT_MIDPOP_TIMER_MULTIPLIER
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer initialising for roundstart at [active_intensity_multiplier]x")
		message_admins("ICES: Event timer initialising for roundstart at [active_intensity_multiplier]x")
		return
	else if(filter_threshold < intensity_low_players) // Lowpop gets events less often
		active_intensity_multiplier = intensity_low_multiplier
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer multiplier is [active_intensity_multiplier]x (LOWPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [active_intensity_multiplier]x (LOWPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")
	else if(filter_threshold < intensity_mid_players) // Midpop gets events less often
		active_intensity_multiplier = intensity_mid_multiplier
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer multiplier is [active_intensity_multiplier]x (MIDPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [active_intensity_multiplier]x (MIDPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")
	else
		active_intensity_multiplier = intensity_high_multiplier
		scheduled = world.time + (rand(frequency_lower, max(frequency_lower,frequency_upper)) * active_intensity_multiplier)
		log_game("ICES: Event timer multiplier is [active_intensity_multiplier]x (HIGHPOP) for [filter_threshold] players. Next run at [scheduled] in [DisplayTimeText(scheduled - world.time, 1)]")
		message_admins("ICES: Event timer multiplier is [active_intensity_multiplier]x (HIGHPOP) for [filter_threshold] players. Next run in [DisplayTimeText(scheduled - world.time, 60)]")

	log_game("ICES: Reschedule proc calling for timed intensity credit")
	change_intensity_credits(2, 1, TRUE, TRUE, FALSE)
