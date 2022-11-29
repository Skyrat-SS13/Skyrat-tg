#define POP_PER_BORER 30

/proc/printborer(datum/mind/borer)
	var/list/text = list()
	var/mob/living/basic/cortical_borer/player_borer = borer.current
	if(!player_borer)
		text += span_redtext("[span_bold(borer.name)] had their body destroyed.")
		return text
	if(borer.current.stat != DEAD)
		text += "[span_bold(player_borer.name)] [span_greentext("survived")]"
	else
		text += "[span_bold(player_borer.name)] [span_redtext("died")]"
	text += span_bold("[span_bold(player_borer.name)] produced [player_borer.children_produced] borers.")
	var/list/string_of_genomes = list()

	for(var/evo_index in player_borer.past_evolutions)
		var/datum/borer_evolution/evolution = player_borer.past_evolutions[evo_index]
		string_of_genomes += evolution.name

	text += "[span_bold(player_borer.name)] had the following evolutions: [english_list(string_of_genomes)]"
	return text.Join("<br>")

/proc/printborerlist(list/players,fleecheck)
	var/list/parts = list()

	parts += "<ul class='playerlist'>"
	for(var/datum/mind/M in players)
		parts += "<li>[printborer(M)]</li>"
	parts += "</ul>"
	return parts.Join("<br>")

/datum/antagonist/cortical_borer
	name = "Cortical Borer"
	job_rank = ROLE_BORER
	show_in_antagpanel = TRUE
	roundend_category = "cortical borers"
	antagpanel_category = "Cortical Borers"
	prevent_roundtype_conversion = FALSE
	show_to_ghosts = TRUE
	/// The team of borers
	var/datum/team/cortical_borers/borers

/datum/antagonist/cortical_borer/get_preview_icon()
	return finish_preview_icon(icon('modular_skyrat/modules/cortical_borer/icons/animal.dmi', "brainslug"))

/datum/antagonist/cortical_borer/get_team()
	return borers

/datum/antagonist/cortical_borer/create_team(datum/team/cortical_borers/new_team)
	if(!new_team)
		for(var/datum/antagonist/cortical_borer/borer in GLOB.antagonists)
			if(!borer.owner)
				stack_trace("Antagonist datum without owner in GLOB.antagonists: [borer]")
				continue
			if(borer.borers)
				borers = borer.borers
				return
		if(!new_team)
			borers = new /datum/team/cortical_borers
			return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	borers = new_team

/datum/team/cortical_borers
	name = "\improper Cortical Borers"

/datum/team/cortical_borers/roundend_report()
	var/list/parts = list()
	parts += span_header("The [name] were:")
	parts += printborerlist(members)
	var/survival = FALSE
	for(var/mob/living/basic/cortical_borer/check_borer in GLOB.cortical_borers)
		if(check_borer.stat == DEAD)
			continue
		survival = TRUE
	if(survival)
		parts += span_greentext("Borers were able to survive the shift!")
	else
		parts += span_redtext("Borers were unable to survive the shift!")
	if(GLOB.successful_egg_number >= GLOB.objective_egg_borer_number)
		parts += span_greentext("Borers were able to produce enough eggs!")
	else
		parts += span_redtext("Borers were unable to produce enough eggs!")
	if(length(GLOB.willing_hosts) >= GLOB.objective_willing_hosts)
		parts += span_greentext("Borers were able to gather enough willing hosts!")
	else
		parts += span_redtext("Borers were unable to gather enough willing hosts!")
	if(GLOB.successful_blood_chem >= GLOB.objective_blood_borer)
		parts += span_greentext("Borers were able to learn enough chemicals through the blood!")
	else
		parts += span_redtext("Borers were unable to learn enough chemicals through the blood!")
	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/round_event_control/cortical_borer
	name = "Cortical Borer Infestation"
	typepath = /datum/round_event/ghost_role/cortical_borer
	weight = 10
	min_players = 999
	max_occurrences = 1 //should only ever happen once
	dynamic_should_hijack = TRUE

/datum/round_event/ghost_role/cortical_borer
	announce_when = 400

/datum/round_event/ghost_role/cortical_borer/setup()
	announce_when = rand(announce_when, announce_when + 50)

/datum/round_event/ghost_role/cortical_borer/announce(fake)
	priority_announce("Unidentified lifesigns detected coming aboard [station_name()]. Secure any exterior access, including ducting and ventilation.", "Lifesign Alert", ANNOUNCER_ALIENS)

/datum/round_event/ghost_role/cortical_borer/start()
	var/list/vents = list()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue // No parent vent
			// Stops Cortical Borers getting stuck in small networks.
			// See: Security, Virology
			if(length(temp_vent_parent.other_atmos_machines) > 20)
				vents += temp_vent
	if(!length(vents))
		return MAP_ERROR
	var/list/mob/dead/observer/candidates = poll_ghost_candidates("Do you want to spawn as a cortical borer?", ROLE_PAI, FALSE, 10 SECONDS, POLL_IGNORE_CORTICAL_BORER)
	if(!length(candidates))
		return NOT_ENOUGH_PLAYERS
	var/living_number = max(length(GLOB.player_list) / POP_PER_BORER, 1)
	var/choosing_number = min(length(candidates), living_number)
	for(var/repeating_code in 1 to choosing_number)
		var/mob/dead/observer/new_borer = pick(candidates)
		candidates -= new_borer
		var/turf/vent_turf = get_turf(pick(vents))
		var/mob/living/basic/cortical_borer/spawned_cb = new /mob/living/basic/cortical_borer(vent_turf)
		spawned_cb.ckey = new_borer.ckey
		spawned_cb.mind.add_antag_datum(/datum/antagonist/cortical_borer)
		to_chat(spawned_cb, span_warning("You are a cortical borer! You can fear someone to make them stop moving, but make sure to inhabit them! You only grow/heal/talk when inside a host!"))
	for(var/mob/dead_mob in GLOB.dead_mob_list)
		to_chat(dead_mob, span_notice("The cortical borers have been selected, you are able to orbit them! Remember, they can reproduce!"))

/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer
	name = "Cortical Borer Infestation"
	antag_datum = /datum/antagonist/cortical_borer
	midround_ruleset_style = MIDROUND_RULESET_STYLE_LIGHT
	antag_flag = ROLE_BORER
	enemy_roles = list(
		JOB_CAPTAIN,
		JOB_DETECTIVE,
		JOB_HEAD_OF_SECURITY,
		JOB_SECURITY_OFFICER,
	)
	required_enemies = list(2,2,1,1,1,1,1,0,0,0)
	required_candidates = 1
	weight = 3
	cost = 15
	minimum_players = 20
	repeatable = TRUE
	/// List of on-station vents
	var/list/vents = list()

/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer/execute()
	for(var/obj/machinery/atmospherics/components/unary/vent_pump/temp_vent in GLOB.machines)
		if(QDELETED(temp_vent))
			continue
		if(is_station_level(temp_vent.loc.z) && !temp_vent.welded)
			var/datum/pipeline/temp_vent_parent = temp_vent.parents[1]
			if(!temp_vent_parent)
				continue // No parent vent
			// Stops Borers getting stuck in small networks.
			// See: Security, Virology
			if(length(temp_vent_parent.other_atmos_machines) > 20)
				vents += temp_vent
	if(!length(vents))
		return FALSE
	return TRUE

/datum/dynamic_ruleset/midround/from_ghosts/cortical_borer/generate_ruleset_body(mob/applicant)
	var/obj/vent = pick_n_take(vents)
	var/mob/living/basic/cortical_borer/new_borer = new(vent.loc)
	new_borer.key = applicant.key
	new_borer.move_into_vent(vent)
	message_admins("[ADMIN_LOOKUPFLW(new_borer)] has been made into a borer by the midround ruleset.")
	log_game("DYNAMIC: [key_name(new_borer)] was spawned as a borer by the midround ruleset.")
	return new_borer

#undef POP_PER_BORER
