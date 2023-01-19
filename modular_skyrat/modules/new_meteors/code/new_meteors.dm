#define METEOR_WAVE_MIN_NOTICE 210
#define METEOR_WAVE_MAX_NOTICE 240
#define METEOR_WAVE_DURATION 37

/datum/round_event_control/meteor_wave
	///Where will the meteors be coming from? -- Established in admin_setup, passed down to round_event
	var/start_side

/datum/round_event/meteor_wave
	///Which direction the storm will come from.
	var/start_side

/datum/round_event/meteor_wave/New()
	..()
	start_when = rand(METEOR_WAVE_MIN_NOTICE, METEOR_WAVE_MAX_NOTICE)
	end_when = start_when + METEOR_WAVE_DURATION

/datum/round_event_control/meteor_wave/admin_setup()
	if(!check_rights(R_FUN))
		return ADMIN_CANCEL_EVENT

	if(tgui_alert(usr, "Choose a side to throw rocks at?", "Interrupt some ERP.", list("Yes", "No")) == "Yes")
		var/chosen_direction = tgui_input_list(usr, "Pick one!","Make things interesting.", list("North", "South", "East", "West"))
		switch(chosen_direction)
			if("North")
				start_side = NORTH
			if("South")
				start_side = SOUTH
			if("East")
				start_side = EAST
			if("West")
				start_side = WEST

/datum/round_event/meteor_wave/announce(fake)
	var/datum/round_event_control/meteor_wave/meteor_event = control
	if(meteor_event.start_side)
		start_side = meteor_event.start_side
	else
		start_side = pick(GLOB.cardinals)

	priority_announce("Meteors have been detected on collision course with the station. The early warning system estimates first collision in approximately [start_when * 2] seconds, coming from the [dir2text(start_side)]. Ensure all sensitive areas and equipment are shielded.", "Meteor Alert", ANNOUNCER_METEORS)

/datum/round_event/meteor_wave/tick()
	if(ISMULTIPLE(activeFor, 3))
		spawn_meteors(5, wave_type, start_side) //meteor list types defined in gamemode/meteor/meteors.dm

#undef METEOR_WAVE_MIN_NOTICE
#undef METEOR_WAVE_MAX_NOTICE
#undef METEOR_WAVE_DURATION
