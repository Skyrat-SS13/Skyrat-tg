/mob/living/silicon/pai/
	/// Whether or not the PAI is subject to range limitations and able to roam freely, off by default
	var/leashed = FALSE

/// Enables or disables the leash, allowing or forbidding the PAI from leaving a specified range
/mob/living/silicon/pai/proc/toggle_leash()
	leashed = !leashed
	to_chat(src, span_warning("Your virtual leash has been [leashed ? "activated" : "deactivated"]!"))
	if(leashed)
		check_distance() // yoink them back

/mob/living/silicon/pai/check_distance()
	if(!leashed)
		return

	return ..()
