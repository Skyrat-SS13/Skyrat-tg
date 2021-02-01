GLOBAL_LIST_EMPTY(assaultops_targets)

/datum/game_mode/assaultops
	name = "assaultops" //DO NOT CHANGE THIS, "assaultops"
	config_tag = "assaultops"
	report_type = "assaultops"
	false_report_weight = 10
	required_players = 30 // 30 players - 3 players to be the nuke ops = 27 players remaining
	required_enemies = 2
	recommended_enemies = 7
	antag_flag = ROLE_ASSAULTOPS
	enemy_minimum_age = 14

	announce_span = "danger"
	announce_text = "Syndicate forces are approaching the station in an attempt to occupy it!\n\
	<span class='danger'>Operatives</span>: Capture all of your assigned targets and transport them to the holding facility!\n\
	<span class='notice'>Crew</span>: Defend the station and capture the operatives, we need them for information!"

	var/const/agents_possible = 10 //If we ever need more syndicate agents.
	var/operatives_left = 1
	var/list/pre_operatives = list()

	var/datum/team/assaultops/assault_team

	var/operative_antag_datum_type = /datum/antagonist/assaultops
	var/leader_antag_datum_type = /datum/antagonist/assaultops/leader

	waittime_l = 300 SECONDS
	waittime_h = 600 SECONDS

/datum/game_mode/assaultops/pre_setup()
	var/n_agents = min(round(num_players() / 10), antag_candidates.len, agents_possible)
	if(n_agents >= required_enemies)
		for(var/i = 0, i < n_agents, ++i)
			var/datum/mind/new_op = pick_n_take(antag_candidates)
			pre_operatives += new_op
			new_op.assigned_role = "Assault Operative"
			new_op.special_role = "Assault Operative"
			log_game("[key_name(new_op)] has been selected as an Assault operative")
		return TRUE
	else
		setup_error = "Not enough assault op candidates"
		return FALSE
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////

/datum/game_mode/assaultops/post_setup()
	//Assign leader
	var/datum/mind/leader_mind = pre_operatives[1]
	var/datum/antagonist/assaultops/L = leader_mind.add_antag_datum(leader_antag_datum_type)
	assault_team = L.assault_team
	//Assign the remaining operatives
	for(var/i = 1 to pre_operatives.len)
		var/datum/mind/assault_mind = pre_operatives[i]
		assault_mind.add_antag_datum(operative_antag_datum_type)
	//Assign the targets
	for(var/i in GLOB.player_list)
		if(GLOB.assaultops_targets.len >= MAX_ASSAULTOPS_TARGETS)
			break
		if(!check_assaultops_target(i))
			continue
		add_assaultops_target(i)
	addtimer(CALLBACK(src, .proc/notify_time), 20)
	return ..()

/datum/game_mode/assaultops/proc/notify_time()
	send_to_assaultops_watch("<span class='userdanger'>Your watch buzzes, telling you that there is between <b>3 to 5 minutes</b> left before you are detected and a report is sent!</span>")


/datum/game_mode/assaultops/send_intercept()
	var/intercepttext = "<b><i>Central Command Status Summary</i></b><hr>"
	intercepttext += "<b>Central Command has intercepted a rogue transmission emitted from an incoming vessel, we have managed to decript most of it, message reads:</b><hr>"
	intercepttext += "Team in 3531%32 to location, 581224$% for further information regarding the extraction 53£^2£$ and targets-... £&*)&<hr>"
	intercepttext += "<b><i>End of Transmission</i></b><hr>"
	intercepttext += "We believe an assault group of some kind is enroute to your station, we want you to capture them. <b>Alive.</b>"

	print_command_report(intercepttext, "Priority Intercept", announce=TRUE)
	priority_announce("Hostile intervention in progress, do not panic.", "General alert", 'modular_skyrat/modules/alerts/sound/misc/voyalert.ogg')


/datum/game_mode/assaultops/set_round_result()
	..()
	var/result = assault_team.get_result()
	switch(result)
		if(ASSAULT_RESULT_STALEMATE)
			SSticker.mode_result = "stalemate - mission failure - crew and operatives dead"
			SSticker.news_report = ASSAULTOPS_STALEMATE
		if(ASSAULT_RESULT_ASSAULT_FLAWLESS_WIN)
			SSticker.mode_result = "flawless operatives win - all crew captured"
			SSticker.news_report = ASSAULTOPS_ASSAULT_WIN
		if(ASSAULT_RESULT_ASSAULT_MAJOR_WIN)
			SSticker.mode_result = "major operatives win - all crew captured - some operatives dead"
			SSticker.news_report = ASSAULTOPS_ASSAULT_WIN
		if(ASSAULT_RESULT_ASSAULT_WIN)
			SSticker.mode_result = "operatives win - some crew captured"
			SSticker.news_report = ASSAULTOPS_ASSAULT_WIN
		if(ASSAULT_RESULT_CREW_FLAWLESS_WIN)
			SSticker.mode_result = "flawless crew win - all operatives captured"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_CREW_MAJOR_WIN)
			SSticker.mode_result = "major crew win - all operatives captured - but some crew dead"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_CREW_WIN)
			SSticker.mode_result = "crew win - some operatives captured"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_CREW_LOSS)
			SSticker.mode_result = "crew loss - all operatives dead"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		if(ASSAULT_RESULT_ASSAULT_LOSS)
			SSticker.mode_result = "operatives loss - all crew dead"
			SSticker.news_report = ASSAULTOPS_CREW_WIN
		else
			SSticker.mode_result = "halfwin - interrupted"
			SSticker.news_report = OPERATIVE_SKIRMISH

/datum/game_mode/assaultops/generate_report()
	return "Several Nanotransen-affiliated stations in your sector are currently beseiged by the Gorlex Marauders, and current trends suggests your station is next in line.\
           They are heavily armed and dangerous, and we recommend you fortify any defensible positions immediately. They may attempt to communicate or negotiate. Stall for as long as possible. \
            Our ERT force is stretched thin in this sector, so there are no guarantee of reinforcements. As a result, the crew is permitted to aid security as a militia under the directive of the captain . Do not give up control of the station, unless you are unable to resist effectively any further. \
            In which case, surrender to keep costs to a minimal. We will come back eventually to retake the station."

/datum/game_mode/assaultops/check_finished(force_ending)
	if(!SSticker.setup_done || !gamemode_ready)
		return FALSE
	if(replacementmode && round_converted == 2)
		return replacementmode.check_finished()
	if(SSshuttle.emergency && (SSshuttle.emergency.mode == SHUTTLE_ENDGAME))
		return TRUE
	if(station_was_nuked)
		return TRUE
	var/list/continuous = CONFIG_GET(keyed_list/continuous)
	var/list/midround_antag = CONFIG_GET(keyed_list/midround_antag)
	if(!round_converted && (!continuous[config_tag] || (continuous[config_tag] && midround_antag[config_tag]))) //Non-continuous or continous with replacement antags
		if(!continuous_sanity_checked) //make sure we have antags to be checking in the first place
			for(var/mob/Player in GLOB.mob_list)
				if(Player.mind)
					if(Player.mind.special_role || LAZYLEN(Player.mind.antag_datums))
						continuous_sanity_checked = 1
						return FALSE
			if(!continuous_sanity_checked)
				message_admins("The roundtype ([config_tag]) has no antagonists, continuous round has been defaulted to on and midround_antag has been defaulted to off.")
				continuous[config_tag] = TRUE
				midround_antag[config_tag] = FALSE
				SSshuttle.clearHostileEnvironment(src)
				return FALSE

		var/list/targets_alive = assault_team.get_alive_targets()
		var/list/assaultops_alive = assault_team.get_alive_assaultops()
		var/list/targets_alive_captured = assault_team.get_captured_targets()
		var/list/assaultops_alive_captured = assault_team.get_captured_assaultops()
		if(!targets_alive.len)
			return TRUE //All of the targets have died

		if(!assaultops_alive.len)
			return TRUE //All of the assault team is dead

		if(targets_alive_captured.len >= targets_alive.len)
			return TRUE //We got em boys!

		if(assaultops_alive_captured.len >= targets_alive.len)
			return TRUE //The assault team have been captured!

		if(living_antag_player && living_antag_player.mind && isliving(living_antag_player) && living_antag_player.stat != DEAD && !isnewplayer(living_antag_player) &&!isbrain(living_antag_player) && (living_antag_player.mind.special_role || LAZYLEN(living_antag_player.mind.antag_datums)))
			return FALSE //A resource saver: once we find someone who has to die for all antags to be dead, we can just keep checking them, cycling over everyone only when we lose our mark.

		for(var/mob/Player in GLOB.alive_mob_list)
			if(Player.mind && Player.stat != DEAD && !isnewplayer(Player) &&!isbrain(Player) && Player.client && (Player.mind.special_role || LAZYLEN(Player.mind.antag_datums))) //Someone's still antagging but is their antagonist datum important enough to skip mulligan?
				for(var/datum/antagonist/antag_types in Player.mind.antag_datums)
					if(antag_types.prevent_roundtype_conversion)
						living_antag_player = Player //they were an important antag, they're our new mark
						return FALSE

		if(!are_special_antags_dead())
			return FALSE

		if(!continuous[config_tag] || force_ending)
			return TRUE

		else
			round_converted = convert_roundtype()
			if(!round_converted)
				if(round_ends_with_antag_death)
					return TRUE
				else
					midround_antag[config_tag] = 0
					return FALSE

	return FALSE

//OBJECTIVES
/datum/objective/assaultops
	name = "assaultops"
	explanation_text = "Capture all of the security and command team and transport them to the holding facility."
	martyr_compatible = TRUE

/datum/objective/assaultops/check_completion()
	var/finished = TRUE
	for(var/mob/living/carbon/human/H in GLOB.assaultops_targets)
		if(H.stat != DEAD)
			finished = FALSE
	if(finished)
		return TRUE
	return FALSE
