/client
	var/pointstacks = 3

/client/New()
	. = ..()
	RegisterSignal(src, COMSIG_MOB_POINTED, /client.proc/point_cooldown)

/client/proc/point_cooldown()
	SIGNAL_HANDLER
	if(pointstacks)
		pointstacks--
	addtimer(VARSET_CALLBACK(src, pointstacks, 3), 10 SECONDS, TIMER_OVERRIDE)

/mob/pointed()
	if(client.pointstacks)
		. = ..()
		SEND_SIGNAL(client, COMSIG_MOB_POINTED)
	else
		to_chat(usr, "You are pointing too hard!")
		SEND_SIGNAL(client, COMSIG_MOB_POINTED)
	// Let's send it here too, because there ARE apparantly mob mechanics that rely on pointing signals.
