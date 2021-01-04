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

/datum/antagonist/assaultops/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)

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

	var/loadout_desc = ""

	switch(chosen_loadout)
		if("cqb")
			chosen_loadout_type = /datum/outfit/assaultops/cqb
			loadout_desc = "<span class='notice'>You have chosen the CQB class, your role is to deal with hand-to-hand combat!</span>"
		if("demoman")
			chosen_loadout_type = /datum/outfit/assaultops/demoman
			loadout_desc = "<span class='notice'>You have chosen the Demolitions class, your role is to blow shit up!</span>"
		if("medic")
			chosen_loadout_type = /datum/outfit/assaultops/medic
			loadout_desc = "<span class='notice'>You have chosen the Medic class, your role is providing medical aid to fellow operatives!</span>"
		if("heavy")
			chosen_loadout_type = /datum/outfit/assaultops/heavy
			loadout_desc = "<span class='notice'>You have chosen the Heavy class, your role is continuous suppression!</span>"
		if("assault")
			chosen_loadout_type = /datum/outfit/assaultops/assault
			loadout_desc = "<span class='notice'>You have chosen the Assault class, your role is general combat!</span>"
		if("sniper")
			chosen_loadout_type = /datum/outfit/assaultops/sniper
			loadout_desc = "<span class='notice'>You have chosen the Sniper class, your role is suppressive fire!</span>"
		if("tech")
			chosen_loadout_type = /datum/outfit/assaultops/tech
			loadout_desc = "<span class='notice'>You have chosen the Tech class, your role is hacking!</span>"
		else
			chosen_loadout_type = pick(/datum/outfit/assaultops/cqb, /datum/outfit/assaultops/demoman, /datum/outfit/assaultops/medic, /datum/outfit/assaultops/heavy, /datum/outfit/assaultops/assault, /datum/outfit/assaultops/sniper, /datum/outfit/assaultops/tech)

	if(!chosen_loadout)
		chosen_loadout_type = /datum/outfit/assaultops

	H.equipOutfit(chosen_loadout_type)

	to_chat(H, loadout_desc)

	loadout = chosen_loadout
	return TRUE

/datum/antagonist/assaultops/greet()
	owner.current.playsound_local(get_turf(owner.current), 'modular_skyrat/modules/assaultops/sound/assaultops_start.ogg',20,0, use_reverb = FALSE)
	to_chat(owner, "<span class='notice'>You are a [assault_team ? assault_team.syndicate_name : "syndicate"] agent!</span>")

	owner.announce_objectives()

/datum/antagonist/assaultops/on_gain()
	give_alias()
	forge_objectives()
	. = ..()
	if(send_to_spawnpoint)
		move_to_spawnpoint()
	equip_op()
	memorise_kills(TRUE)

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

/datum/antagonist/assaultops/proc/memorise_kills(startup=FALSE)
	if(assault_team)
		antag_memory = ""
		antag_memory += "Your currently assigned targets to <b>CAPTURE</b> are: <br>"
		for(var/i in GLOB.assaultops_targets)
			var/datum/mind/M = i
			antag_memory += "- <b>[M.current.name]</b>: [M.assigned_role]<br>"
		antag_memory += "<b>You only need to capture these people, the others are not relevant.</b><br>"
		antag_memory += " <br>"

		if(startup)
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
		var/datum/game_mode/assaultops/ticker_team = SSticker.mode
		ticker_team.assault_team = assault_team

		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	assault_team = new_team



/datum/antagonist/assaultops/leader
	name = "Assault Operative Leader"
	assaultop_outfit = /datum/outfit/syndicate/leader
	always_new_team = TRUE
	var/title

/datum/antagonist/assaultops/leader/give_alias()
	title = pick("Czar", "Boss", "Commander", "Chief", "Kingpin", "Director", "Overlord")
	if(assault_team?.syndicate_name)
		owner.current.real_name = "[assault_team.syndicate_name] [title]"
	else
		owner.current.real_name = "Syndicate [title]"

/datum/antagonist/assaultops/leader/greet()
	owner.current.playsound_local(get_turf(owner.current), 'modular_skyrat/modules/assaultops/sound/assaultops_start.ogg',20,0, use_reverb = FALSE)
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
