/datum/round_event_control/can_spawn_event(players_amt, allow_magic = FALSE)
	SHOULD_CALL_PARENT(TRUE)
	. = ..()
	if(intensity_restriction && !GLOB.intense_event_credits)
		return FALSE

/datum/round_event_control/runEvent(random = FALSE, announce_chance_override = null, admin_forced = FALSE)
	. = ..()
	if(intensity_restriction && GLOB.intense_event_credits)
		GLOB.intense_event_credits--
		log_game("[src.name] consumed an intensity credit. There are now [GLOB.intense_event_credits] credits")
	else if(intensity_restriction)
		log_game("[src.name] should consume an intensity credit, but didn't! Maybe it was admin forced. There are now [GLOB.intense_event_credits] credits")
	else
		log_game("[src.name] does not need an intensity credit. There are now [GLOB.intense_event_credits] credits")
