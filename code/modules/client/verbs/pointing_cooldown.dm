#define POINT_STACK_LIMIT 3
/client
	/// Your clients allowed pointing stacks.
	var/point_stacks = POINT_STACK_LIMIT

/client/New()
	. = ..()
	RegisterSignal(src, COMSIG_MOB_POINTED, /client.proc/point_cooldown)
/**
 * Increments the allowed pointing stacks and resets the pointer cooldown.
 */
/client/proc/point_cooldown()
	SIGNAL_HANDLER
	if(point_stacks)
		point_stacks--
	addtimer(VARSET_CALLBACK(src, point_stacks, POINT_STACK_LIMIT), 10 SECONDS, TIMER_UNIQUE)

/mob/pointed()
	if(client?.point_stacks)
		. = ..()
		SEND_SIGNAL(client, COMSIG_MOB_POINTED)
	else
		balloon_alert(usr, "can't point yet!")
		SEND_SIGNAL(client, COMSIG_MOB_POINTED)
	// Let's send it here too, because there ARE apparantly mob mechanics that rely on pointing signals.
#undef POINT_STACK_LIMIT
