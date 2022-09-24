#define POINT_TIMER 0.5 SECONDS
/client
	/// Your clients allowed pointing stacks.
	var/pointing_on_timer = FALSE

/**
 * Increments the allowed pointing stacks and resets the pointer cooldown.
 */
/client/proc/point_cooldown()

	if(pointing_on_timer)
		mob?.balloon_alert(usr, "can't point yet!")
	pointing_on_timer = TRUE
	addtimer(VARSET_CALLBACK(src, pointing_on_timer, FALSE), POINT_TIMER, TIMER_UNIQUE)

/mob/pointed()
	if(!client?.pointing_on_timer)
		. = ..()
	client.point_cooldown()
#undef POINT_TIMER
