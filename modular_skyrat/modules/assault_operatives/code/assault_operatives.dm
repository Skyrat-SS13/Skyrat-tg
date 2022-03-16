#define OBJECTIVE_COUNT 5

/**
 * ASSAULT OPERATIVE ANTAG DATUM
 */

/datum/antagonist/assault_operative
	name = ROLE_ASSAULT_OPERATIVE
	job_rank = ROLE_ASSAULT_OPERATIVE
	roundend_category = "assault operatives"
	antagpanel_category = "Assault Operatives"
	antag_hud_name = "synd"
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = TRUE
	hijack_speed = 2
	preview_outfit = /datum/outfit/nuclear_operative_elite
	var/assault_operative_default_outfit = /datum/outfit/nuclear_operative
	var/datum/team/assault_operatives/assault_team
	/// Should we move the operative to a designated spawn point?
	var/send_to_spawnpoint = TRUE
	/// What class have we equipped? None means we haven't selected one yet.
	var/equipped_class = null
	//If not assigned a team by default ops will try to join existing ones, set this to TRUE to always create new team.
	var/always_new_team = FALSE

/datum/antagonist/assault_operative/greet()
	owner.current.playsound_local(get_turf(owner.current), 'modular_skyrat/modules/assault_operatives/sound/assault_operatives_greet.ogg', 30, 0, use_reverb = FALSE)
	to_chat(owner, span_big("You are an assault operative!"))
	owner.announce_objectives()

/datum/antagonist/assault_operative/on_gain()
	. = ..()
	equip_operative()
	if(send_to_spawnpoint)
		move_to_spawnpoint()


/datum/antagonist/assault_operative/proc/equip_operative()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/human = owner.current
	human.set_species(/datum/species/human)
	human.equipOutfit(assault_operative_default_outfit)
	human.hairstyle = "Crewcut"
	human.hair_color = COLOR_ALMOST_BLACK
	human.facial_hairstyle = "Shaved"
	human.facial_hair_color = COLOR_ALMOST_BLACK
	human.update_hair()
	return TRUE

/datum/antagonist/assault_operative/create_team(datum/team/assault_operatives/new_team)
	if(!new_team)
		if(!always_new_team)
			for(var/datum/antagonist/assault_operative/assault_operative in GLOB.antagonists)
				if(!assault_operative.owner)
					stack_trace("Antagonist datum without owner in GLOB.antagonists: [assault_operative]")
					continue
				if(assault_operative.assault_team)
					assault_team = assault_operative.assault_team
					return
		assault_team = new /datum/team/assault_operatives
		assault_team.add_member(owner)
		assault_team.update_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	assault_team = new_team
	assault_team.add_member(owner)
	assault_team.update_objectives()


/datum/antagonist/assault_operative/proc/move_to_spawnpoint()
	var/team_number = 1
	if(assault_team)
		team_number = assault_team.members.Find(owner)
	owner.current.forceMove(GLOB.assault_operative_start[((team_number - 1) % GLOB.assault_operative_start.len) + 1])

/datum/antagonist/assault_operative/get_preview_icon()
	if (!preview_outfit)
		return null

	var/icon/final_icon = render_preview_outfit(preview_outfit)

	return finish_preview_icon(final_icon)

/**
 * ASSAULT OPERATIVE TEAM DATUM
 */

/datum/team/assault_operatives

/datum/team/assault_operatives/proc/update_objectives(initial = FALSE)
	var/untracked_heads = SSjob.get_all_heads()

	for(var/datum/objective/interrogate/objective in objectives)
		untracked_heads -= objective.target

	for(var/datum/mind/mind in untracked_heads)
		var/datum/objective/interrogate/new_target = new()
		new_target.team = src
		new_target.target = mind
		new_target.update_explanation_text()
		objectives += new_target

	for(var/datum/mind/mind in members)
		var/datum/antagonist/assault_operative/assault_op = mind.has_antag_datum(/datum/antagonist/assault_operative)
		assault_op.objectives |= objectives

	addtimer(CALLBACK(src,.proc/update_objectives), HEAD_UPDATE_PERIOD, TIMER_UNIQUE)

/datum/team/assault_operatives/proc/operatives_dead()
	for(var/i in members)
		var/datum/mind/operative_mind = i
		if(ishuman(operative_mind.current) && (operative_mind.current.stat != DEAD))
			return FALSE
	return TRUE

/datum/team/assault_operatives/roundend_report()
	var/list/parts = list()
	parts += "<span class='header'>Assault Operatives:</span>"

	switch(get_result())
		if(ASSAULT_RESULT_OPERATIVE_WIN)
			parts += span_greentext("Assault Operatives Major Victory!")
			parts += "<B>Assault operatives have extracted all GoldenEye keys from their targets!</B>"
		if(ASSAULT_RESULT_OPERATIVE_PARTIAL_WIN)
			parts += span_greentext("Assault Operatives Minor Victory!")
			parts += "<B>Assault operatives have extracted some of the GoldenEye keys from some of their targets!</B>"
		if(ASSAULT_RESULT_CREW_WIN)
			parts += span_redtext("Crew Major Victory")
			parts += "<B>The Research Staff has saved the GoldenEye Defence Network and stopped the Assault Operatives!</B>"
		else
			parts += "<span class='neutraltext big'>Neutral Victory</span>"
			parts += "<B>Mission aborted!</B>"

	var/text = "<br><span class='header'>The assault operatives were:</span>"
	text += printplayerlist(members)
	text += "<br>"

	parts += text

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/team/assault_operatives/proc/get_result()
	var/result = ASSAULT_RESULT_OPERATIVE_WIN

	var/completed_objectives = 0
	for(var/datum/objective/interrogate/objective as anything in objectives)
		if(objective.check_completion())
			completed_objectives++
			continue
		result = ASSAULT_RESULT_OPERATIVE_PARTIAL_WIN

	if(!completed_objectives)
		result = ASSAULT_RESULT_CREW_WIN

	return result



/**
 * ASSAULT OPERATIVE JOB TYPE
 */
/datum/job/assault_operative
	title = ROLE_ASSAULT_OPERATIVE


/datum/job/assault_operative/get_roundstart_spawn_point()
	return pick(GLOB.assault_operative_start)


/datum/job/assault_operative/get_latejoin_spawn_point()
	return pick(GLOB.assault_operative_start)


