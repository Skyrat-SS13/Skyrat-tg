#define REMOVE_INTENSITY_CREDIT 1
#define ADD_INTENSITY_CREDIT 2
#define STATIC_INTENSITY_CREDIT 3

/datum/round_event_control
	/// Whether this event is intense enough to need special processing rules
	var/intensity_restriction = FALSE

/datum/controller/subsystem/events
	/// Rate at which we add intensity credits
	var/intensity_credit_rate = 27000
	/// Last world time we added an intensity credit
	var/intensity_credit_last_time = 27000

/// Changes the round's intensity credit pool. Can be called as part of a timer or on its own.
/// Arguments: credit_action: number, credit_amount: number, check_timer: boolean, reset_timer: boolean, notify_admins: boolean
/datum/controller/subsystem/events/proc/change_intensity_credits(credit_action = 0, credit_amount = 0, check_timer = FALSE, reset_timer = FALSE, notify_admins = TRUE)
	if(check_timer && world.time - intensity_credit_last_time < intensity_credit_rate)
		if(notify_admins)
			message_admins("Intensity credit operation failed due to timer check. Current intensity credits: [GLOB.intense_event_credits]")
		return FALSE

	switch(credit_action)
		if(ADD_INTENSITY_CREDIT)
			GLOB.intense_event_credits = GLOB.intense_event_credits + credit_amount
			log_game("Adding intensity credit to events system. Current intensity credits: [GLOB.intense_event_credits]")
			if(notify_admins)
				message_admins("Adding intensity credit to events system. Current intensity credits: [GLOB.intense_event_credits]")
		if(REMOVE_INTENSITY_CREDIT)
			GLOB.intense_event_credits = GLOB.intense_event_credits - credit_amount
			log_game("Removing intensity credit from events system. Current intensity credits: [GLOB.intense_event_credits]")
			if(notify_admins)
				message_admins("Removing intensity credit from events system. Current intensity credits: [GLOB.intense_event_credits]")
		if(STATIC_INTENSITY_CREDIT)
			GLOB.intense_event_credits = credit_amount
			log_game("Setting intensity credits to value. Current intensity credits: [GLOB.intense_event_credits]")
			if(notify_admins)
				message_admins("Setting intensity credits to value. Current intensity credits: [GLOB.intense_event_credits]")
		else
			return FALSE

	if(reset_timer)
		intensity_credit_last_time = world.time

	return TRUE

#undef REMOVE_INTENSITY_CREDIT
#undef ADD_INTENSITY_CREDIT
#undef STATIC_INTENSITY_CREDIT
