/datum/job/cyborg
	title = JOB_CYBORG
	description = "Assist the crew, follow your laws, obey your AI."
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	faction = FACTION_STATION
	total_positions = 3	// SKYRAT EDIT: Original value (0)
	spawn_positions = 3	// SKYRAT EDIT: Original value (1)
	supervisors = "your laws and the AI" //Nodrak
	selection_color = "#ddffdd"
	spawn_type = /mob/living/silicon/robot
	minimal_player_age = 21
	exp_requirements = 120
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CYBORG"

	display_order = JOB_DISPLAY_ORDER_CYBORG

	departments_list = list(
		/datum/job_department/silicon,
		)
	random_spawns_possible = FALSE
	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK


/datum/job/cyborg/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	if(!iscyborg(spawned))
		return
	spawned.gender = NEUTER
	var/mob/living/silicon/robot/robot_spawn = spawned
	robot_spawn.notify_ai(AI_NOTIFICATION_NEW_BORG)
	//SKYRAT EDIT START
	var/list/malf_ais = list()
	var/list/regular_ais = list()
	for(var/mob/living/silicon/ai/ai_possible as anything in GLOB.ai_list)
		if(ai_possible.mind?.has_antag_datum(/datum/antagonist/malf_ai))
			malf_ais |= ai_possible
			continue
		regular_ais |= ai_possible
	var/mob/selected_ai
	if(length(malf_ais))
		selected_ai = pick(malf_ais)
	if(length(regular_ais) && !selected_ai)
		selected_ai = pick(regular_ais)
	if(selected_ai)
		robot_spawn.set_connected_ai(selected_ai)
		log_combat(selected_ai, robot_spawn, "synced cyborg [ADMIN_LOOKUP(robot_spawn)] to [ADMIN_LOOKUP(selected_ai)] (Cyborg spawn syncage)")
		if(robot_spawn.shell) //somehow?
			robot_spawn.undeploy()
			robot_spawn.notify_ai(AI_NOTIFICATION_AI_SHELL)
		else
			robot_spawn.notify_ai(TRUE)
		robot_spawn.visible_message(span_notice("[robot_spawn] gently chimes."), span_notice("LawSync protocol engaged."))
		robot_spawn.lawsync()
		robot_spawn.lawupdate = TRUE
		robot_spawn.show_laws()
	//SKYRAT EDIT END
	if(!robot_spawn.connected_ai) // Only log if there's no Master AI
		robot_spawn.log_current_laws()

/datum/job/cyborg/radio_help_message(mob/M)
	to_chat(M, "<b>Prefix your message with :b to speak with other cyborgs and AI.</b>")
