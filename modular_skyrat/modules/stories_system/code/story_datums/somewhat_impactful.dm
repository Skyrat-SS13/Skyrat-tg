/datum/story_type/somewhat_impactful
	impact = STORY_SOMEWHAT_IMPACTFUL


/datum/story_type/somewhat_impactful/centcom_inspector
	name = "Central Command Inspector"
	desc = "A Central Command inspector has come to make sure the station is in... if not good shape, a shape."
	ghosts_involved = 1
	ghost_outfits = list(/datum/outfit/centcom_inspector)

/datum/story_type/somewhat_impactful/centcom_inspector/handle_the_ghosts(list/ghost_list)
	var/list/mind_list = list()
	for(var/mob/dead/observer/ghost as anything in ghost_list)
		INVOKE_ASYNC(GLOBAL_PROC, /proc/tgui_alert, ghost, "You are a Story Participant! See your chat for more information.", "Story Participation")
		to_chat(ghost, span_info("You are going to be a Central Command inspector, sent to the station to make sure things are in some sort of shape."))
		to_chat(ghost, span_info("You will be spawned in within 5 minutes with your currently selected character. Make sure all your preferences are set!"))
		to_chat(ghost, span_info(span_bold("Until then, you will be teleported to an area to set up your character and coordinate with other story participants.")))
		var/obj/landmark = locate(/obj/effect/landmark/ghost_story_participant) in GLOB.landmarks_list
		var/mob/living/carbon/human/temporary_human = new(get_turf(landmark))
		temporary_human.key = ghost.key
		temporary_human.client?.prefs?.safe_transfer_prefs_to(temporary_human)
		mind_list += temporary_human.mind
	addtimer(CALLBACK(src, .proc/inform_station), 0.3 MINUTES)
	addtimer(CALLBACK(src, .proc/spawn_inspectors, mind_list), 0.5 MINUTES)
	return TRUE

/datum/story_type/somewhat_impactful/centcom_inspector/proc/inform_station()
	print_command_report("Hello, an inspector will be arriving shortly for a surprise inspection, ensure they have a pleasant report.", announce = TRUE)

/datum/story_type/somewhat_impactful/centcom_inspector/proc/spawn_inspectors(list/inspector_list)
	var/area/station/command/bridge/bridge_area = GLOB.areas_by_type[/area/station/command/bridge]
	var/list/bridge_tiles = list()
	for(var/turf/open/floor/floor_tile in bridge_area)
		bridge_tiles += floor_tile
	for(var/datum/mind/ghost as anything in inspector_list)
		if(ishuman(ghost.current))
			qdel(ghost.current)
		var/mob/living/carbon/human/inspector = new
		inspector.key = ghost.key
		inspector.client?.prefs?.safe_transfer_prefs_to(inspector)
		podspawn(list(
			"target" = pick(bridge_tiles),
			"style" = STYLE_CENTCOM,
			"spawn" = inspector,
		))
		inspector.equipOutfit(pick(ghost_outfits))

///////

/datum/story_type/somewhat_impactful/mob_money
	name = "Mob Money"
	desc = "Some crewman's gotten themselves involved in organized crime, and now owes 20k to some mafiosos."
	ghosts_involved = 1
	ghost_outfits = list(/datum/outfit/mobster) //Temporary-ish
	players_involved = 0
	player_text = "Looks like you somehow got into a sizable debt with the mafia, might want to collect your dues in case any of them come knocking..."

/datum/story_type/somewhat_impactful/mob_money/handle_the_ghosts(list/ghost_list)
	var/list/mind_list = list()
	for(var/mob/dead/observer/ghost as anything in ghost_list)
		INVOKE_ASYNC(GLOBAL_PROC, /proc/tgui_alert, ghost, "You are a Story Participant! See your chat for more information.", "Story Participation")
		to_chat(ghost, span_info(""))
		to_chat(ghost, span_info("You will be spawned in within 5 minutes with your currently selected character. Make sure all your preferences are set!"))
		to_chat(ghost, span_info(span_bold("Until then, you will be teleported to an area to set up your character and coordinate with other story participants.")))
		var/obj/landmark = locate(/obj/effect/landmark/ghost_story_participant) in GLOB.landmarks_list
		var/mob/living/carbon/human/temporary_human = new(get_turf(landmark))
		temporary_human.key = ghost.key
		temporary_human.client?.prefs?.safe_transfer_prefs_to(temporary_human)
		mind_list += temporary_human.mind
	addtimer(CALLBACK(src, .proc/spawn_mobsters, mind_list), 0.5 MINUTES)
	return TRUE

/datum/story_type/somewhat_impactful/mob_money/proc/spawn_mobsters(list/mobster_list)
	var/list/possible_spawns = list()
	for(var/turf/turf_spawn as anything in GLOB.xeno_spawn)
		if(istype(turf_spawn.loc, /area/station/maintenance))
			possible_spawns += turf_spawn
	if(!length(possible_spawns))
		return
	var/turf/picked_spawn = pick(possible_spawns)
	for(var/datum/mind/ghost as anything in mobster_list)
		if(ishuman(ghost.current))
			qdel(ghost.current)
		var/mob/living/carbon/human/mobster = new(picked_spawn)
		mobster.key = ghost.key
		mobster.client?.prefs?.safe_transfer_prefs_to(mobster)
		mobster.equipOutfit(pick(ghost_outfits))
	new /obj/item/storage/toolbox/syndicate(picked_spawn) // So they can get out of the maint hole
