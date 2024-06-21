/datum/job/ai
	title = JOB_AI
	description = "Assist the crew, follow your laws, coordinate your cyborgs."
	auto_deadmin_role_flags = DEADMIN_POSITION_SILICON
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "your laws"
	spawn_type = /mob/living/silicon/ai
	req_admin_notify = TRUE
	minimal_player_age = 30
	exp_requirements = 180
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SILICON
	exp_granted_type = EXP_TYPE_CREW
	display_order = JOB_DISPLAY_ORDER_AI
	allow_bureaucratic_error = FALSE
	departments_list = list(
		/datum/job_department/silicon,
		)
	random_spawns_possible = FALSE
	job_flags = JOB_NEW_PLAYER_JOINABLE | JOB_EQUIP_RANK | JOB_BOLD_SELECT_TEXT | JOB_CANNOT_OPEN_SLOTS
	config_tag = "AI"


/datum/job/ai/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	/* SKYRAT EDIT REMOVAL START
	//we may have been created after our borg
	if(SSticker.current_state == GAME_STATE_SETTING_UP)
		for(var/mob/living/silicon/robot/R in GLOB.silicon_mobs)
			if(!R.connected_ai)
				R.TryConnectToAI()
	*/ // SKYRAT EDIT REMOVAL END
	var/mob/living/silicon/ai/ai_spawn = spawned
	ai_spawn.log_current_laws()
	// SKYRAT EDIT ADDITION START
	for(var/mob/living/silicon/robot/sync_target in GLOB.silicon_mobs)
		if(!(sync_target.z in SSmapping.levels_by_trait(ZTRAIT_STATION)) || (sync_target.z in SSmapping.levels_by_trait(ZTRAIT_ICE_RUINS_UNDERGROUND))) // Skip ghost cafe, interlink, and other cyborgs.
			continue
		if(sync_target.emagged) // Skip emagged cyborgs, they don't sync up to the AI anyways and emagged borgs are already outed by just looking at a robotics console.
			continue
		if(sync_target.connected_ai)
			continue
		sync_target.notify_ai(AI_NOTIFICATION_CYBORG_DISCONNECTED)
		sync_target.set_connected_ai(ai_spawn)
		log_combat(ai_spawn, sync_target, "synced cyborg [ADMIN_LOOKUP(sync_target)] to [ADMIN_LOOKUP(ai_spawn)] (AI spawn syncage)")
		if(sync_target.shell)
			sync_target.undeploy()
			sync_target.notify_ai(AI_NOTIFICATION_AI_SHELL)
		else
			sync_target.notify_ai(TRUE)
		sync_target.visible_message(span_notice("[sync_target] gently chimes."), span_notice("LawSync protocol engaged."))
		log_combat(ai_spawn, sync_target, "forcibly synced cyborg laws via spawning in")
		sync_target.lawsync()
		sync_target.lawupdate = TRUE
		sync_target.show_laws()
	// SKYRAT EDIT ADDITION END


/datum/job/ai/get_roundstart_spawn_point()
	return get_latejoin_spawn_point()

/datum/job/ai/get_latejoin_spawn_point()
	for(var/obj/structure/ai_core/latejoin_inactive/inactive_core as anything in GLOB.latejoin_ai_cores)
		if(!inactive_core.is_available())
			continue
		GLOB.latejoin_ai_cores -= inactive_core
		inactive_core.available = FALSE
		var/turf/core_turf = get_turf(inactive_core)
		qdel(inactive_core)
		return core_turf
	var/list/primary_spawn_points = list() // Ideal locations.
	var/list/secondary_spawn_points = list() // Fallback locations.
	for(var/obj/effect/landmark/start/ai/spawn_point in GLOB.landmarks_list)
		if(spawn_point.used)
			secondary_spawn_points += list(spawn_point)
			continue
		if(spawn_point.primary_ai)
			primary_spawn_points = list(spawn_point)
			break // Bingo.
		primary_spawn_points += spawn_point
	var/obj/effect/landmark/start/ai/chosen_spawn_point
	if(length(primary_spawn_points))
		chosen_spawn_point = pick(primary_spawn_points)
	else if(length(secondary_spawn_points))
		chosen_spawn_point = pick(secondary_spawn_points)
	else
		CRASH("Failed to find any AI spawn points.")
	chosen_spawn_point.used = TRUE
	return chosen_spawn_point

/datum/job/ai/special_check_latejoin(client/C)
	for(var/obj/structure/ai_core/latejoin_inactive/latejoin_core as anything in GLOB.latejoin_ai_cores)
		if(latejoin_core.is_available())
			return TRUE
	return FALSE


/datum/job/ai/announce_job(mob/living/joining_mob)
	. = ..()
	if(SSticker.HasRoundStarted())
		minor_announce("[joining_mob] has been downloaded to an empty bluespace-networked AI core at [AREACOORD(joining_mob)].")


/datum/job/ai/config_check()
	return CONFIG_GET(flag/allow_ai)

/datum/job/ai/get_radio_information()
	return "<b>Prefix your message with :b to speak with cyborgs and other AIs.</b>"
