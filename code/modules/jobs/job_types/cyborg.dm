/datum/job/cyborg
	title = "Cyborg"
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	faction = "Station"
	total_positions = 3	// SKYRAT EDIT: Original value (0)
	spawn_positions = 3	// SKYRAT EDIT: Original value (1)
	supervisors = "your laws and the AI" //Nodrak
	selection_color = "#ddffdd"
	minimal_player_age = 21
	exp_requirements = 120
	exp_type = EXP_TYPE_CREW

	display_order = JOB_DISPLAY_ORDER_CYBORG
	departments = DEPARTMENT_SILICON
	random_spawns_possible = FALSE

/datum/job/cyborg/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source = null)
	if(visualsOnly)
		CRASH("dynamic preview is unsupported")
	return H.Robotize(FALSE, latejoin)

/datum/job/cyborg/after_spawn(mob/living/silicon/robot/R, mob/M)
	R.updatename(M.client)
	R.gender = NEUTER
	for(var/mob/living/silicon/ai/AI in GLOB.silicon_mobs) // SKYRAT EDIT ADDITION START - LATEJOIN LINK
		if(AI.z == 3)
			if(!(R.connected_ai))
				R.set_connected_ai(AI)
	R.show_laws() // SKYRAT EDIT ADDITION END

/datum/job/cyborg/radio_help_message(mob/M)
	to_chat(M, "<b>Prefix your message with :b to speak with other cyborgs and AI.</b>")
