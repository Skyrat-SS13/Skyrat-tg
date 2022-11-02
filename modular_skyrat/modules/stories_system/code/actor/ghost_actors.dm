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
	var/obj/landmark
	for(var/obj/effect/landmark/ghost_story_participant/actor_spawn in GLOB.landmarks_list)
		if(actor_spawn.actor_id != actor_spawn_id)
			continue
		landmark = actor_spawn
		break
	// Handling for reserving a new area
	if(!landmark)
		var/datum/map_template/actor_spawn/new_actor = new
		var/datum/turf_reservation/reservation_area = SSmapping.RequestBlockReservation(new_actor.width, new_actor.height, SSmapping.transit.z_value, /datum/turf_reservation/transit)
		if(!reservation_area)
			CRASH("failed to reserve an area for actor spawning")
		var/turf/bottom_left = TURF_FROM_COORDS_LIST(reservation_area.bottom_left_coords)
		new_actor.load(bottom_left, centered = FALSE)
		var/list/affected = new_actor.get_affected_turfs(bottom_left, centered=FALSE)
		for(var/turf/affected_turf as anything in affected)
			for(var/obj/effect/landmark/ghost_story_participant/actor_spawn in affected_turf)
				actor_spawn.actor_id = actor_spawn_id
		for(var/obj/effect/landmark/ghost_story_participant/actor_spawn in GLOB.landmarks_list)
			if(actor_spawn.actor_id != actor_spawn_id)
				continue
			landmark = actor_spawn
			break
		if(!landmark)
			CRASH("failed to find an actor spawn ID landmark after making a template that should've assigned one!")
	// Spawning the actor
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

/datum/story_actor/ghost/centcom_inspector/syndicate
	name = "Syndicate Centcom Inspector"
	actor_outfits = list(
		/datum/outfit/syndicate_inspector/nuke_core,
		/datum/outfit/syndicate_inspector/sm_sliver,
		/datum/outfit/syndicate_inspector/rd_server,
	)
	actor_info = "You are a Syndicate agent who assumed the identity of a CentCom inspector. You have a goal to steal %ITEM%, and have been equipped with a radio implant, storage implant, and a box of equipment depending on what you need to steal. Keep things calm and try not to blow your cover while doing your objective."
	actor_goal = "Steal %ITEM% while maintaining your cover as a CentCom inspector."
	/// Outfit we're going to use, used for %ITEM% replacetext
	var/actor_picked_outfit

/datum/story_actor/ghost/centcom_inspector/syndicate/handle_spawning(mob/picked_spawner, datum/story_type/current_story)
	actor_picked_outfit = pick(actor_outfits)
	var/datum/outfit/syndicate_inspector/initial_datum = actor_picked_outfit
	actor_info = replacetext(actor_info, "%ITEM%", initial(initial_datum.steal_item))
	actor_goal = replacetext(actor_goal, "%ITEM%", initial(initial_datum.steal_item))
	return ..()

/datum/story_actor/ghost/centcom_inspector/syndicate/send_them_in(mob/living/carbon/human/to_send_human)
	to_send_human.client?.prefs?.safe_transfer_prefs_to(to_send_human)
	to_send_human.equipOutfit(actor_picked_outfit)
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
	actor_goal = "Extort %NAME% out of the 20,000 credits they owe."

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

/datum/story_actor/ghost/spawn_in_arrivals
	name = "Spawn In Arrivals template"

/datum/story_actor/ghost/spawn_in_arrivals/send_them_in(mob/living/carbon/human/to_send_human)
	to_send_human.client?.prefs?.safe_transfer_prefs_to(to_send_human)
	. = ..()
	SSjob.get_last_resort_spawn_points().JoinPlayerHere(to_send_human, TRUE) // This will drop them on the arrivals shuttle, hopefully buckled to a chair. Worst case, they go to the error room.

/datum/story_actor/ghost/spawn_in_arrivals/tourist
	name = "Obnoxious Tourist"
	actor_outfits = list(
		/datum/outfit/tourist/blue,
		/datum/outfit/tourist/green,
		/datum/outfit/tourist/orange,
		/datum/outfit/tourist/purple,
	)
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times!"

/datum/story_actor/ghost/spawn_in_arrivals/tourist/syndicate
	name = "\"Tourist\""
	actor_info = "To the station, you're just another jackass tourist with a photocamera and a fat stack of cash. In reality, you're an agent of the Syndicate, sent to gather \
	intelligence on the crew and what they're working on to pass to your corporate overlords after you depart."
	actor_goal = "Find and photograph sensitive Nanotrasen equipment and documents. Interrogate the crew for classified details about their research and work. \
	Be a shifty character who asks too many questions, but try not to get caught."

/datum/story_actor/ghost/spawn_in_arrivals/tourist/broke
	name = "Broke Tourist"
	actor_outfits = list(
		/datum/outfit/tourist/broke/blue,
		/datum/outfit/tourist/broke/green,
		/datum/outfit/tourist/broke/orange,
		/datum/outfit/tourist/broke/purple,
	)
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!\n\n\
	At least, that's what you would be saying, if you hadn't lost most of your money at that casino last night. Unfortunately for you, you're dirt broke. However, \
	Nanotrasen has a low tolerance for broke tourists. Do your best to conceal your lack of wealth while still flaunting how rich and touristy you are!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times! Don't get caught being broke! Flaunt your wealth that you don't actually have!"

/datum/story_actor/ghost/spawn_in_arrivals/tourist/wealthy
	name = "Wealthy Tourist"
	actor_outfits = list(
		/datum/outfit/tourist/wealthy/blue,
		/datum/outfit/tourist/wealthy/green,
		/datum/outfit/tourist/wealthy/orange,
		/datum/outfit/tourist/wealthy/purple,
	)
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!\n\n\
	The best part? You won the lottery recently and walked away with a solid 10 grand in credits! As a newly filthy rich tourist, it's your solemn duty to \
	be obnoxiously rich. Purchase expensive liquors. Flaunt your wealth, and be an obnoxious braggart about how lucky you are to have so much cash!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times! Flaunt your excessive wealth! Brag about how rich and powerful you are! Face the consequences of being an annoying rich dickwad!"

/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual
	name = "Monolingual Tourist"
	actor_info = "After saving up your hard earned money, you're so excited to be here on the frontier as a tourist! You've dreamed of being out here for years, and now you can \
	finally make it happen. You're coming into the station on the arrivals shuttle now, so get ready for the vacation day of a lifetime!\n\n\
	However, there's one small hitch. You didn't bother to learn anything about the local language in this sector of space, like, at all. Clearly, this isn't a problem for you, \
	it's a problem for the locals to resolve for you. Perhaps if you speak slowly and louder whenever they don't understand you? It's not your fault they don't know your language!"
	actor_goal = "Explore the station! Partake in the sights! Be an annoying tourist who takes photos of everything! Ask the crew stupid repetitive questions they've heard \
	thousands of times! Cause problems with your language barrier! Be an obnoxious tourist who didn't learn anything about the language before coming here! Blame the crew \
	for not accomodating to your inability to speak their language!\n\n\
	NOTE: Common will be removed from your character when you spawn on the station. Have a backup language selected that you will be using as your primary language to communicate with."

/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual/send_them_in(mob/living/carbon/human/to_send_human)
	. = ..()
	to_send_human.remove_language(/datum/language/common) // good luck

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_drinking_with_boss
	name = "Salaryman"
	actor_outfits = list(/datum/outfit/salaryman)
	actor_info = "After a long 14 hour shift at the company, it's time to go out for after-shift drinks with your coworkers and the Boss, %BOSS_NAME%. \
	It's part of the job. To not drink with your boss would be a massive faux pas, and could result in disciplinary action at work. Your boss decided that he wants \
	drinks at this ramdom fringe station, so you and your coworkers are tagging along as is required. Maybe you can find a nice gift for your significant other here \
	to bring home and apologize for the long hours you've been working recently."
	actor_goal = "Hang out with your boss and coworkers at the bar. Drink heavily, but keep pace with the boss, %BOSS_NAME%'s drinking. If he drinks, you drink. \
	If he leaves, you leave. It's not a great life, but it's the life you have. Try to get some stress relief in. Commiserate with your coworkers on the situation without \
	offending the boss. Find a nice gift to bring back to your significant other when you leave."

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_drinking_with_boss/send_them_in(mob/picked_spawner, datum/story_type/current_story)
	. = ..()
	var/datum/story_type/unimpactful/drinking_with_the_boss/drinking_with_the_boss = involved_story
	actor_info = replacetext(actor_info, "%BOSS_NAME%", drinking_with_the_boss?.boss?.real_name)
	actor_goal = replacetext(actor_goal, "%BOSS_NAME%", drinking_with_the_boss?.boss?.real_name)

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_boss
	name = "Salaryman's Boss"
	actor_outfits = list(/datum/outfit/salaryman)
	actor_info = "After a short 14 hour shift at the company, it's time to go out for after-shift drinks with your subordinates, as is tradition for the company. \
	This classic team building exercise you commit every night with your employees is an important part of the corporate lifestyle, and it's important that you hold up \
	this tradition to set an example for your subordinates. Tonight you will drink, be merry, and be jovial, all while reminding your employees who they work for and who \
	signs their checks. The staff at this location are here to serve you, and if they give you shit, remind them of the respect you deserve as a high level executive of \
	a Fortune 500 company in the Spinward Stellar Coalition."
	actor_goal = "Drink with your subordinates at the bar, and consume good food. When you drink, they will drink as well. Deviation from this tradition is to be frowned upon. \
	Remind your employees how much they should be respecting you for this opportunity. Demand the staff of the station treat you with the same level of respect. Be an annoying \
	boss. Establish your authority as the most important person in the room at all times."

/datum/story_actor/ghost/spawn_in_arrivals/salaryman_boss/send_them_in(mob/living/carbon/human/to_send_human)
	. = ..()
	var/datum/story_type/unimpactful/drinking_with_the_boss/drinking_story = involved_story
	drinking_story.boss = to_send_human

/datum/story_actor/ghost/spawn_in_arrivals/shore_leave
	name = "Shore Leave Sailor"
	actor_outfits = list(/datum/outfit/centcom/naval/ensign)
	actor_info = "You've been working on a ship for the last year with no shore leave. Finally, your ship's docked at a NT station and you and your buddies finally have some \
	well deserved shore leave. Find some good booze, find some good food, and get some R&R in with the boys. Cut loose, let off some steam, and be a proud navy man!"
	actor_goal = "Get drunk with the boys. Have some good fucking food at the kitchen. Be rowdy and merry. Get into fights, be a nuisance, be obnoxious to the station. \
	Avoid getting thrown in the brig so that your commanding officer doesn't have to bail you out."
