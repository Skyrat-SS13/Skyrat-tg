/datum/antagonist/assaultops
	name = "Assault Operative"
	roundend_category = "syndicate operatives" //just in case
	antagpanel_category = "AssaultOp"
	job_rank = ROLE_ASSAULTOPS
	antag_hud_type = ANTAG_HUD_OPS
	antag_hud_name = "synd"
	antag_moodlet = /datum/mood_event/focused
	show_to_ghosts = TRUE
	var/datum/team/assaultops/assault_team
	var/always_new_team = FALSE //If not assigned a team by default ops will try to join existing ones, set this to TRUE to always create new team.
	var/send_to_spawnpoint = TRUE //Should the user be moved to default spawnpoint.
	var/assaultop_outfit = /datum/outfit/assaultops
	var/borg_chosen = FALSE
	var/loadout //The chosen loaduout of the op


/datum/antagonist/assaultops/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)
	ADD_TRAIT(owner, TRAIT_DISK_VERIFIER, NUKEOP_TRAIT)

/datum/antagonist/assaultops/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)
	REMOVE_TRAIT(owner, TRAIT_DISK_VERIFIER, NUKEOP_TRAIT)

/datum/antagonist/assaultops/proc/equip_op()
	if(!ishuman(owner.current))
		return
	var/mob/living/carbon/human/H = owner.current

	if(H.dna.species.id == "plasmaman" )
		H.set_species(/datum/species/human)

	H.faction |= ROLE_SYNDICATE

	var/list/loadouts = list(
		"cqb" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "cqb"),
		"demoman" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "demoman"),
		"medic" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "medic"),
		"heavy" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "heavy"),
		"assault" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "assault"),
		"sniper" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "sniper"),
		"tech" = image(icon = 'modular_skyrat/modules/assaultops/icons/radial.dmi', icon_state = "tech"),
		)

	var/chosen_loadout = show_radial_menu(H, H, loadouts, radius = 40)

	var/datum/outfit/assaultops/chosen_loadout_type

	switch(chosen_loadout)
		if("cqb")
			chosen_loadout_type = /datum/outfit/assaultops/cqb
		if("demoman")
			chosen_loadout_type = /datum/outfit/assaultops/demoman
		if("medic")
			chosen_loadout_type = /datum/outfit/assaultops/medic
		if("heavy")
			chosen_loadout_type = /datum/outfit/assaultops/heavy
		if("assault")
			chosen_loadout_type = /datum/outfit/assaultops/assault
		if("sniper")
			chosen_loadout_type = /datum/outfit/assaultops/sniper
		if("tech")
			chosen_loadout_type = /datum/outfit/assaultops/tech
		else
			chosen_loadout_type = pick(/datum/outfit/assaultops/cqb, /datum/outfit/assaultops/demoman, /datum/outfit/assaultops/medic, /datum/outfit/assaultops/heavy, /datum/outfit/assaultops/assault, /datum/outfit/assaultops/sniper, /datum/outfit/assaultops/tech)

	if(!chosen_loadout)
		chosen_loadout_type = /datum/outfit/assaultops

	H.equipOutfit(chosen_loadout_type)

	to_chat(H, chosen_loadout_type.desc)

	loadout = chosen_loadout
	return TRUE

/datum/antagonist/assaultops/greet()
	owner.current.playsound_local(get_turf(owner.current), 'modular_skyrat/modules/assaultops/sound/assaultops_start.ogg',40,0, use_reverb = FALSE)
	to_chat(owner, "<span class='notice'>You are a [assault_team ? assault_team.syndicate_name : "syndicate"] agent!</span>")
	owner.announce_objectives()

/datum/antagonist/assaultops/on_gain()
	give_alias()
	forge_objectives()
	. = ..()
	if(send_to_spawnpoint)
		move_to_spawnpoint()
	equip_op()
	memorise_kills()


/datum/antagonist/assaultops/get_team()
	return assault_team

/datum/antagonist/assaultops/proc/give_alias()
	if(assault_team?.syndicate_name)
		var/mob/living/carbon/human/H = owner.current
		if(istype(H)) // Reinforcements get a real name
			var/chosen_name = H.dna.species.random_name(H.gender,0,assault_team.syndicate_name)
			H.fully_replace_character_name(H.real_name,chosen_name)
		else
			var/number = 1
			number = assault_team.members.Find(owner)
			owner.current.real_name = "[assault_team.syndicate_name] Operative #[number]"

/datum/antagonist/assaultops/proc/memorise_kills()
	if(assault_team)
		antag_memory += "Your currently assigned targets to CAPTURE are: \n"
		for(var/i in GLOB.assaultops_targets)
			var/mob/living/carbon/human/H = i
			antag_memory += "- [H.name]: [H.job] \n"
		antag_memory += "<b>You only need to capture these people, the others are not relevant.</b> \n"
		to_chat(owner, "You have been given a list of command and security staff that must be <b>CAPTURED</b>, do not kill them!")
		to_chat(owner, "<span class='redtext'>YOU ARE NOT NUCLEAR OPERATIVES, YOUR ASSIGNMENT IS CAPTURE AND TAKEOVER, DO NOT KILL BYSTANDERS UNLESS PROVOKED!</span>")
		to_chat(owner, "<span class='notice'>For a target to be considered captured, they must be alive and kept in the <b>holding facility</b> that you are currently docked to.</span>")


/datum/antagonist/assaultops/proc/forge_objectives()
	if(assault_team)
		objectives |= assault_team.objectives

/datum/antagonist/assaultops/proc/move_to_spawnpoint()
	var/team_number = 1
	if(assault_team)
		team_number = assault_team.members.Find(owner)
	var/assop_start = GLOB.assaultop_start[((team_number - 1) % GLOB.assaultop_start.len) + 1]
	var/turf/turf_loc = get_turf(assop_start)
	owner.current.forceMove(turf_loc)

/datum/antagonist/assaultops/create_team(datum/team/assaultops/new_team)
	if(!new_team)
		if(!always_new_team)
			for(var/datum/antagonist/assaultops/N in GLOB.antagonists)
				if(!N.owner)
					stack_trace("Antagonist datum without owner in GLOB.antagonists: [N]")
					continue
				if(N.assault_team)
					assault_team = N.assault_team
					return
		assault_team = new /datum/team/assaultops
		assault_team.update_objectives()
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	assault_team = new_team

/datum/antagonist/assaultops/admin_add(datum/mind/new_owner,mob/admin)
	new_owner.assigned_role = ROLE_SYNDICATE
	new_owner.add_antag_datum(src)
	message_admins("[key_name_admin(admin)] has assault op'ed [key_name_admin(new_owner)].")
	log_admin("[key_name(admin)] has assault op'ed [key_name(new_owner)].")

/datum/antagonist/assaultops/get_admin_commands()
	. = ..()
	.["Send to base"] = CALLBACK(src,.proc/admin_send_to_base)

/datum/antagonist/assaultops/proc/admin_send_to_base(mob/admin)
	owner.current.forceMove(pick(GLOB.assaultop_start))

/datum/antagonist/assaultops/leader
	name = "Assault Operative Leader"
	assaultop_outfit = /datum/outfit/syndicate/leader
	always_new_team = TRUE
	var/title
	var/challengeitem = /obj/item/nuclear_challenge

/datum/antagonist/assaultops/leader/give_alias()
	title = pick("Czar", "Boss", "Commander", "Chief", "Kingpin", "Director", "Overlord")
	if(assault_team?.syndicate_name)
		owner.current.real_name = "[assault_team.syndicate_name] [title]"
	else
		owner.current.real_name = "Syndicate [title]"

/datum/antagonist/assaultops/leader/greet()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ops.ogg',100,0, use_reverb = FALSE)
	to_chat(owner, "<B>You are the Syndicate [title] for this mission. You are responsible for coordination and your ID is the only one who can open the launch bay doors.</B>")
	to_chat(owner, "<B>If you feel you are not up to this task, give your ID to another operative.</B>")
	owner.announce_objectives()
	addtimer(CALLBACK(src, .proc/assaultops_name_assign), 1)


/datum/antagonist/assaultops/leader/proc/assaultops_name_assign()
	if(!assault_team)
		return
	assault_team.rename_team(ask_name())

/datum/team/assaultops/proc/rename_team(new_name)
	syndicate_name = new_name
	name = "[syndicate_name] Team"
	for(var/I in members)
		var/datum/mind/synd_mind = I
		var/mob/living/carbon/human/H = synd_mind.current
		if(!istype(H))
			continue
		var/chosen_name = H.dna.species.random_name(H.gender,0,syndicate_name)
		H.fully_replace_character_name(H.real_name,chosen_name)

/datum/antagonist/assaultops/leader/proc/ask_name()
	var/randomname = pick(GLOB.last_names)
	var/newname = stripped_input(owner.current,"You are the assault operative [title]. Please choose a last name for your family.", "Name change",randomname)
	if (!newname)
		newname = randomname
	else
		newname = reject_bad_name(newname)
		if(!newname)
			newname = randomname

	return capitalize(newname)

/datum/team/assaultops
	var/syndicate_name
	var/core_objective = /datum/objective/assaultops

/datum/team/assaultops/New()
	..()
	syndicate_name = syndicate_name()

/datum/team/assaultops/proc/update_objectives()
	if(core_objective)
		var/datum/objective/O = new core_objective
		O.team = src
		objectives += O

//WIN SENARIO CALCULATIONS >>>>>>>>>>>>>>>>
/datum/team/assaultops/proc/get_alive_assaultops()
	var/list/alive = list()
	for(var/i in members)
		var/datum/mind/operative_mind = i
		if(ishuman(operative_mind.current) && is_assault_operative(operative_mind.current) && (operative_mind.current.stat != DEAD))
			alive.Add(i)
	return alive

//Returns any targets that are alive
/datum/team/assaultops/proc/get_alive_targets()
	var/list/alive = list()
	for(var/mob/living/carbon/human/H in GLOB.assaultops_targets)
		if(H.stat != DEAD)
			alive.Add(H)
	return alive

//Returns any targets that are alive and captured
/datum/team/assaultops/proc/get_captured_targets()
	var/list/alive = get_alive_targets()
	var/list/captured = list()
	for(var/i in alive)
		var/mob/living/carbon/human/H = i
		var/area/loc_area = get_area(H)
		if(istype(loc_area, /area/cruiser_dock/brig))
			captured.Add(H)
	return captured

//Returns any ops that are alive and captured
/datum/team/assaultops/proc/get_captured_assaultops()
	var/list/alive = get_alive_assaultops()
	var/list/captured = list()
	for(var/i in alive)
		var/mob/living/carbon/human/H = i
		var/area/loc_area = get_area(H)
		if(HAS_TRAIT(H, TRAIT_RESTRAINED) && istype(loc_area, /area/security))
			captured.Add(H)
	return captured

/datum/team/assaultops/proc/get_result()
	var/list/targets_alive = get_alive_targets()
	var/list/assaultops_alive = get_alive_assaultops()
	var/list/targets_alive_captured = get_captured_targets()
	var/list/assaultops_alive_captured = get_captured_assaultops()

	if(!assaultops_alive.len && !targets_alive.len)
		return ASSAULT_RESULT_STALEMATE

	if(!assaultops_alive.len)
		return ASSAULT_RESULT_CREW_LOSS

	if(!targets_alive.len)
		return ASSAULT_RESULT_ASSAULT_LOSS

	if(assaultops_alive.len >= members.len && targets_alive_captured.len >= GLOB.assaultops_targets.len)
		return ASSAULT_RESULT_ASSAULT_FLAWLESS_WIN

	if(assaultops_alive.len && targets_alive_captured.len >= GLOB.assaultops_targets.len)
		return ASSAULT_RESULT_ASSAULT_MAJOR_WIN

	if(assaultops_alive.len && targets_alive_captured.len >= targets_alive.len)
		return ASSAULT_RESULT_ASSAULT_WIN

	if(targets_alive.len >= GLOB.assaultops_targets.len && assaultops_alive_captured.len >= members.len)
		return ASSAULT_RESULT_CREW_FLAWLESS_WIN

	if(targets_alive.len && assaultops_alive_captured.len >= members.len)
		return ASSAULT_RESULT_CREW_MAJOR_WIN

	if(targets_alive.len && assaultops_alive_captured.len >= assaultops_alive.len)
		return ASSAULT_RESULT_CREW_WIN

	return //Oh no, fuck.

/datum/team/assaultops/roundend_report()
	var/list/parts = list()

	if(!syndicate_name)
		syndicate_name = "Syndicate"

	parts += "<span class='header'>[syndicate_name] Assault Operative Incursion:</span>"

	switch(get_result())
		if(ASSAULT_RESULT_STALEMATE)
			parts += "<span class='redtext big'>Stalemate</span>"
			parts += "Somehow the syndicate assault team and the loyalist nanotrasen crew have reached a stalemate!"
		if(ASSAULT_RESULT_ASSAULT_FLAWLESS_WIN)
			parts += "<span class='greentext big'>Flawless Syndicate Victory!</span>"
			parts += "<B>All of the [syndicate_name] assault team have survived, and have safely captured the entirety of Security and Command, well done!</B>"
		if(ASSAULT_RESULT_ASSAULT_MAJOR_WIN)
			parts += "<span class='greentext big'>Major Syndicate Victory!</span>"
			parts += "<B>Most of the [syndicate_name] assault team have survived, and have safely captured the entierty of Security and Command!</B>"
		if(ASSAULT_RESULT_ASSAULT_WIN)
			parts += "<span class='greentext'>Syndicate Victory!</span>"
			parts += "<B>The [syndicate_name] assault team have safely captured some of Security and Command, but some of them were killed!</B>"
		if(ASSAULT_RESULT_ASSAULT_LOSS)
			parts += "<span class='redtext big'>Syndicate Failure!</span>"
			parts += "<B>The [syndicate_name] assault team brutally murdered all of their targets, shame on them!</B>"
		if(ASSAULT_RESULT_CREW_FLAWLESS_WIN)
			parts += "<span class='greentext big'>Flawless Crew Victory!</span>"
			parts += "<B>The entirety of the Security and Command have surived, and have safely captured all of the [syndicate_name] assault team, well done!</B>"
		if(ASSAULT_RESULT_CREW_MAJOR_WIN)
			parts += "<span class='greentext big'>Major Crew Victory!</span>"
			parts += "<B>Most of Security and Command have survived, and have safely captured all of the [syndicate_name] assault team!</B>"
		if(ASSAULT_RESULT_CREW_WIN)
			parts += "<span class='greentext'>Crew Victory</span>"
			parts +="<B>The crew of [station_name()] have safely captured some of the [syndicate_name] assault team, but some were killed!</B>"
		if(ASSAULT_RESULT_CREW_LOSS)
			parts += "<span class='redtext big'>Crew Failure!</span>"
			parts += "<B>The crew of [station_name()] have brutally murdered all of the [syndicate_name] assault team, shame on them!</B>"
		else
			parts += "<span class='neutraltext big'>Neutral Victory</span>"
			parts += "<B>Mission aborted!</B>"

	var/text = "<br><span class='header'>The [syndicate_name] assault operatives were:</span>"
	text += printplayerlist(members)
	text += "<br>"
	text += "<br><span class='header'>The command and security team targets were:</span>"
	var/list/datum/mind/target_minds = list()
	for(var/i in GLOB.assaultops_targets)
		var/mob/living/carbon/human/H = i
		var/datum/mind = H.mind
		target_minds.Add(mind)
	text += printplayerlist(target_minds)
	text += "<br>"
	parts += text

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/team/assaultops/antag_listing_name()
	if(syndicate_name)
		return "[syndicate_name] Syndicates"
	else
		return "Syndicates"


/datum/team/assaultops/is_gamemode_hero()
	return SSticker.mode.name == "assault incursion"

