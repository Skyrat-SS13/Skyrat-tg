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
	preview_outfit = /datum/outfit/syndicate
	/// The default outfit given BEFORE they choose their equipment.
	var/assault_operative_default_outfit = /datum/outfit/syndicate
	/// The team linked to this antagonist datum.
	var/datum/team/assault_operatives/assault_team
	/// Should we move the operative to a designated spawn point?
	var/send_to_spawnpoint = TRUE
	/// What class have we equipped? None means we haven't selected one yet.
	var/equipped_class = null
	//If not assigned a team by default ops will try to join existing ones, set this to TRUE to always create new team.
	var/always_new_team = FALSE
	var/spawn_text = "Your mission is to assault NTSS13 and get all of the GoldenEye keys that you can from the heads of staff that reside there. \
	Use your pinpointer to locate these after you have extracted the GoldenEye key from the head of staff. It will be sent in by droppod. \
	You must then upload the key to the GoldenEye upload terminal on this GoldenEye station. After you have completed your mission, \
	The GoldenEye defence network will fall, and we will gain access to Nanotrasen's military systems. Good luck agent."

/datum/antagonist/assault_operative/greet()
	owner.current.playsound_local(get_turf(owner.current), 'modular_skyrat/modules/assault_operatives/sound/assault_operatives_greet.ogg', 30, 0, use_reverb = FALSE)
	to_chat(owner, span_big("You are an assault operative!"))
	to_chat(owner, span_red(spawn_text))
	owner.announce_objectives()

/datum/antagonist/assault_operative/on_gain()
	give_alias()
	. = ..()
	equip_operative()
	if(send_to_spawnpoint)
		move_to_spawnpoint()
	show_choices()


/datum/antagonist/assault_operative/proc/give_alias()
	owner.current.real_name = "GoldenEye Operative #[rand(100, 1000)]"

/datum/antagonist/assault_operative/proc/show_choices()
	if(equipped_class)
		return
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/human_target = owner.current

	if(human_target.dna.species.id == "plasmaman" )
		human_target.set_species(/datum/species/human)
		to_chat(human_target, span_userdanger("You are now a human!"))

	to_chat(human_target, span_greentext("Select your loadout from the radial menu!"))

	var/list/loadouts = list(
		"cqb" = image(icon = 'modular_skyrat/modules/assault_operatives/icons/radial.dmi', icon_state = "cqb"),
		"demoman" = image(icon = 'modular_skyrat/modules/assault_operatives/icons/radial.dmi', icon_state = "demoman"),
		"medic" = image(icon = 'modular_skyrat/modules/assault_operatives/icons/radial.dmi', icon_state = "medic"),
		"heavy" = image(icon = 'modular_skyrat/modules/assault_operatives/icons/radial.dmi', icon_state = "heavy"),
		"assault" = image(icon = 'modular_skyrat/modules/assault_operatives/icons/radial.dmi', icon_state = "assault"),
		"sniper" = image(icon = 'modular_skyrat/modules/assault_operatives/icons/radial.dmi', icon_state = "sniper"),
		"tech" = image(icon = 'modular_skyrat/modules/assault_operatives/icons/radial.dmi', icon_state = "tech"),
		)

	var/chosen_loadout = show_radial_menu(human_target, human_target, loadouts, radius = 40)

	var/datum/outfit/assaultops/chosen_loadout_type

	var/loadout_desc = ""

	switch(chosen_loadout)
		if("cqb")
			chosen_loadout_type = /datum/outfit/assaultops/cqb
			loadout_desc = span_notice("You have chosen the CQB class, your role is to deal with hand-to-hand combat!")
		if("demoman")
			chosen_loadout_type = /datum/outfit/assaultops/demoman
			loadout_desc = span_notice("You have chosen the Demolitions class, your role is to blow shit up!")
		if("medic")
			chosen_loadout_type = /datum/outfit/assaultops/medic
			loadout_desc = span_notice("You have chosen the Medic class, your role is providing medical aid to fellow operatives!")
		if("heavy")
			chosen_loadout_type = /datum/outfit/assaultops/heavy
			loadout_desc = span_notice("You have chosen the Heavy class, your role is continuous suppression!")
		if("assault")
			chosen_loadout_type = /datum/outfit/assaultops/assault
			loadout_desc = span_notice("You have chosen the Assault class, your role is general combat!")
		if("sniper")
			chosen_loadout_type = /datum/outfit/assaultops/sniper
			loadout_desc = span_notice("You have chosen the Sniper class, your role is suppressive fire!")
		if("tech")
			chosen_loadout_type = /datum/outfit/assaultops/tech
			loadout_desc = span_notice("You have chosen the Tech class, your role is hacking!")
		else
			chosen_loadout_type = pick(/datum/outfit/assaultops/cqb, /datum/outfit/assaultops/demoman, /datum/outfit/assaultops/medic, /datum/outfit/assaultops/heavy, /datum/outfit/assaultops/assault, /datum/outfit/assaultops/sniper, /datum/outfit/assaultops/tech)

	if(!chosen_loadout)
		chosen_loadout_type = /datum/outfit/assaultops

	for(var/obj/item/item in human_target.get_equipped_items(TRUE))
		qdel(item)

	var/obj/item/organ/brain/human_brain = human_target.getorganslot(BRAIN)
	human_brain.destroy_all_skillchips() // get rid of skillchips to prevent runtimes

	human_target.equipOutfit(chosen_loadout_type)

	human_target.regenerate_icons()

	to_chat(human_target, loadout_desc)

	equipped_class = chosen_loadout
	return TRUE

/datum/antagonist/assault_operative/proc/equip_operative()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/human_target = owner.current
	for(var/obj/item/item in human_target.get_equipped_items(TRUE))
		qdel(item)

	var/obj/item/organ/brain/human_brain = human_target.getorganslot(BRAIN)
	human_brain.destroy_all_skillchips() // get rid of skillchips to prevent runtimes

	human_target.equipOutfit(assault_operative_default_outfit)

	human_target.regenerate_icons()

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


