/// Each tick lasts two seconds.
#define MINUTES_IN_TICKS 30
#define METEOR_WAVE_MIN_NOTICE 7 * MINUTES_IN_TICKS
#define METEOR_WAVE_MAX_NOTICE 9 * MINUTES_IN_TICKS
#define METEOR_WAVE_DURATION 1.25 * MINUTES_IN_TICKS
#define METEOR_TICKS_BETWEEN_WAVES 3
#define METEORS_PER_WAVE 5

/datum/round_event_control/meteor_wave
	admin_setup = /datum/event_admin_setup/meteor_wave
	///Where will the meteors be coming from? -- Established in admin_setup, passed down to round_event
	var/start_side

/datum/event_admin_setup/meteor_wave
	///Where will the meteors be coming from? -- Established in admin_setup, passed down to round_event
	var/start_side

/datum/round_event/meteor_wave
	///Which direction the storm will come from.
	var/start_side

/datum/round_event/meteor_wave/New()
	. = ..()
	start_when = rand(METEOR_WAVE_MIN_NOTICE, METEOR_WAVE_MAX_NOTICE)
	end_when = start_when + METEOR_WAVE_DURATION

/datum/event_admin_setup/meteor_wave/prompt_admins()
	var/force_dir = tgui_alert(usr, "Choose a side to throw rocks at?", "Interrupt some ERP?", list("Yes", "No", "Cancel"))

	if(force_dir == "Yes")
		var/chosen_direction = tgui_input_list(usr, "Pick one!","Plausible Deniability.", list("North", "South", "East", "West"))
		switch(chosen_direction)
			if("North")
				start_side = NORTH
			if("South")
				start_side = SOUTH
			if("East")
				start_side = EAST
			if("West")
				start_side = WEST
			else
				return ADMIN_CANCEL_EVENT

	else if(force_dir == "No")
		start_side = pick(GLOB.cardinals)
		return

	else
		return ADMIN_CANCEL_EVENT


/datum/event_admin_setup/meteor_wave/apply_to_event(datum/round_event/meteor_wave/event)
	event.start_side = start_side

/datum/round_event/meteor_wave/announce(fake)
	if(!start_side)
		start_side = pick(GLOB.cardinals)
	var/start_side_text = "an unknown"

	if(prob(85))
		switch(start_side)
			if(NORTH)
				start_side_text = "the fore"
			if(SOUTH)
				start_side_text = "the aft"
			if(EAST)
				start_side_text = "the starboard"
			if(WEST)
				start_side_text = "the port"
			else
				stack_trace("Meteor event given [start_side] as unrecognized direction. Cancelling event...")
				kill()
				return

	priority_announce("Meteors have been detected on collision course with the station. The energy field generator is disabled or missing. First collision in approximately [start_when * 2] seconds from [start_side_text] side of the station. Ensure all sensitive areas and equipment are shielded.", "Meteor Alert", ANNOUNCER_METEORS)


/datum/round_event/meteor_wave/tick()
	if(ISMULTIPLE(activeFor, METEOR_TICKS_BETWEEN_WAVES))
		spawn_meteors(METEORS_PER_WAVE, wave_type, start_side) //meteor list types defined in gamemode/meteor/meteors.dm

#undef MINUTES_IN_TICKS
#undef METEOR_WAVE_MIN_NOTICE
#undef METEOR_WAVE_MAX_NOTICE
#undef METEOR_WAVE_DURATION
#undef METEOR_TICKS_BETWEEN_WAVES
#undef METEORS_PER_WAVE
