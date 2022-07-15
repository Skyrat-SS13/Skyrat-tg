/client
	/// Your clients allowed pointing stacks.
	var/point_stacks = 3

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
	addtimer(VARSET_CALLBACK(src, point_stacks, 3), 10 SECONDS, TIMER_UNIQUE)

/mob/pointed()
	if(client?.point_stacks)
		. = ..()
		SEND_SIGNAL(client, COMSIG_MOB_POINTED)
	else
		balloon_alert(usr, "too fast, calm down!")
		SEND_SIGNAL(client, COMSIG_MOB_POINTED)
	// Let's send it here too, because there ARE apparantly mob mechanics that rely on pointing signals.
