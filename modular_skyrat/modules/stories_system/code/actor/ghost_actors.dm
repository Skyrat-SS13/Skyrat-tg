/datum/story_actor/ghost
	ghost_actor = TRUE
	/// Delay between getting ghosts spawned in the setup box and going in
	var/delay_time = 5 MINUTES

/datum/story_actor/ghost/handle_spawning(mob/picked_spawner, datum/story_type/current_story)
	. = ..()
	if(!.)
		return FALSE
	to_chat(picked_spawner, span_info("You will be spawned in within [delay_time / 600] minutes with your currently selected character. Make sure all your preferences are set!"))
	to_chat(picked_spawner, span_info(span_bold("Until then, you will be teleported to an area to set up your character and coordinate with other story participants. This area is OOC, but do not grief.")))
	var/obj/landmark = locate(/obj/effect/landmark/ghost_story_participant) in GLOB.landmarks_list
	var/mob/living/carbon/human/temporary_human = new(get_turf(landmark))
	temporary_human.key = picked_spawner.key
	temporary_human.client?.prefs?.safe_transfer_prefs_to(temporary_human)
	current_story.mind_actor_list[temporary_human.mind] = src
	info_button = new(src)
	info_button.Grant(temporary_human)
	addtimer(CALLBACK(src, .proc/send_them_in, temporary_human), delay_time)

/// Ghost ones are delayed by a few minutes to ensure that the ghosts have time to choose a character and for crew actors to get settled a bit
/datum/story_actor/ghost/proc/send_them_in(mob/living/carbon/human/to_send_human)
	to_send_human.equipOutfit(pick(actor_outfits))



/datum/story_actor/ghost/centcom_inspector
	name = "Central Command Inspector"
	actor_outfits = list(/datum/outfit/centcom_inspector)
	actor_info = "You are an inspector from Central Command on a surprise inspection of the station. Inspect things, pick out issues, and make a good report for CentCom."
	actor_goal = "Inspect the station, make a report, and send it to CentCom when done."

/datum/story_actor/ghost/centcom_inspector/send_them_in(mob/living/carbon/human/to_send_human)
	to_send_human.client?.prefs?.safe_transfer_prefs_to(to_send_human)
	. = ..()
	var/area/station/command/bridge/bridge_area = GLOB.areas_by_type[/area/station/command/bridge]
	var/list/bridge_tiles = list()
	for(var/turf/open/floor/floor_tile in bridge_area)
		bridge_tiles += floor_tile
	to_send_human.revive(full_heal = TRUE, admin_revive = TRUE)
	podspawn(list(
		"target" = pick(bridge_tiles),
		"style" = STYLE_CENTCOM,
		"spawn" = to_send_human,
	))


/datum/story_actor/ghost/mafioso
	name = "Mafioso"
	actor_outfits = list(/datum/outfit/mafioso)
	actor_info = "Nyeh, see? Looks like some two-bit small-timer over on this 'ere station owes the boss some money, so shake %NAME% up for the twenty big ones they owe."
	actor_goal = "Extort %NAME% out of the 20k they owe."

/datum/story_actor/ghost/mafioso/handle_spawning(mob/picked_spawner, datum/story_type/current_story)
	var/datum/story_type/somewhat_impactful/mob_money/mob_story = involved_story
	actor_info = replacetext(actor_info, "%NAME%", mob_story?.poor_sod?.real_name)
	actor_goal = replacetext(actor_goal, "%NAME%", mob_story?.poor_sod?.real_name)
	return ..()

/datum/story_actor/ghost/mafioso/send_them_in(mob/living/carbon/human/to_send_human)
	to_send_human.client?.prefs?.safe_transfer_prefs_to(to_send_human)
	. = ..()
	var/list/possible_spawns = list()
	for(var/turf/turf_spawn as anything in GLOB.xeno_spawn)
		if(istype(turf_spawn.loc, /area/station/maintenance))
			possible_spawns += turf_spawn
	if(!length(possible_spawns))
		return
	to_send_human.forceMove(pick(possible_spawns))

