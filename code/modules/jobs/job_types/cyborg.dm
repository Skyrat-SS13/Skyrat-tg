/datum/job/cyborg
	title = "Cyborg"
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	faction = "Station"
<<<<<<< HEAD
	total_positions = 3		// SKYRAT EDIT: Original value (0)
	spawn_positions = 3		// SKYRAT EDIT: Original value (1)
	supervisors = "your laws and the AI"	//Nodrak
=======
	total_positions = 0
	spawn_positions = 1
	supervisors = "your laws and the AI" //Nodrak
>>>>>>> 0f435d5dff0 (Remove hideous inline tab indentation, and bans it in contributing guidelines (#56912))
	selection_color = "#ddffdd"
	minimal_player_age = 21
	exp_requirements = 120
	exp_type = EXP_TYPE_CREW

	display_order = JOB_DISPLAY_ORDER_CYBORG

/datum/job/cyborg/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source = null)
	if(visualsOnly)
		CRASH("dynamic preview is unsupported")
	return H.Robotize(FALSE, latejoin)

/datum/job/cyborg/after_spawn(mob/living/silicon/robot/R, mob/M)
	R.updatename(M.client)
	R.gender = NEUTER

/datum/job/cyborg/radio_help_message(mob/M)
	to_chat(M, "<b>Prefix your message with :b to speak with other cyborgs and AI.</b>")
