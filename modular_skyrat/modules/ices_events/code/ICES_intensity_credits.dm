#define REMOVE_INTENSITY_CREDIT 1
#define ADD_INTENSITY_CREDIT 2
#define STATIC_INTENSITY_CREDIT 3

/**
 * ICES - Intensity Credit Events System
 *
 * This file is used for adjusting intensity credits.
 * Can be called on its own, or part of a timer.
 */

/datum/round_event_control
	/// Whether this event is intense enough to need special processing rules
	var/intensity_restriction = FALSE

/// Changes the round's intensity credit pool. Can be called as part of a timer or on its own.
/// Arguments: credit_action: number, credit_amount: number, check_timer: boolean, reset_timer: boolean, notify_admins: boolean
/datum/controller/subsystem/events/proc/change_intensity_credits(credit_action = 0, credit_amount = 0, check_timer = FALSE, reset_timer = FALSE, notify_admins = TRUE)
	if(check_timer && world.time - intensity_credit_last_time < intensity_credit_rate)
		if(notify_admins)
			message_admins("ICES: Request for Intensity Credit rejected due to precondition check. Reason: [world.time - intensity_credit_last_time] is less than [intensity_credit_rate]. Current intensity credits: [GLOB.intense_event_credits]")
		log_game("ICES: Request for Intensity Credit rejected due to precondition check. Reason: [world.time - intensity_credit_last_time] is less than [intensity_credit_rate]. Current intensity credits: [GLOB.intense_event_credits]")
		return FALSE

	switch(credit_action)
		if(ADD_INTENSITY_CREDIT)
			GLOB.intense_event_credits = GLOB.intense_event_credits + credit_amount
			log_game("ICES: Adding intensity credit to events system. Current intensity credits: [GLOB.intense_event_credits]")
			if(notify_admins)
				message_admins("ICES: Adding intensity credit to events system. Current intensity credits: [GLOB.intense_event_credits]")
		if(REMOVE_INTENSITY_CREDIT)
			GLOB.intense_event_credits = GLOB.intense_event_credits - credit_amount
			log_game("ICES: Removing intensity credit from events system. Current intensity credits: [GLOB.intense_event_credits]")
			if(notify_admins)
				message_admins("ICES: Removing intensity credit from events system. Current intensity credits: [GLOB.intense_event_credits]")
		if(STATIC_INTENSITY_CREDIT)
			GLOB.intense_event_credits = credit_amount
			log_game("ICES: Setting intensity credits to value. Current intensity credits: [GLOB.intense_event_credits]")
			if(notify_admins)
				message_admins("ICES: Setting intensity credits to value. Current intensity credits: [GLOB.intense_event_credits]")
		else
			return FALSE

	if(reset_timer)
		log_game("ICES: Intensity Credit timer reset to [world.time]")
		intensity_credit_last_time = world.time

	return TRUE

#undef REMOVE_INTENSITY_CREDIT
#undef ADD_INTENSITY_CREDIT
#undef STATIC_INTENSITY_CREDIT
