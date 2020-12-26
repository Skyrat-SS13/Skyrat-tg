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

	switch(chosen_loadout)
		if("cqb")
			chosen_loadout = /datum/outfit/assaultops/cqb
			to_chat(H, "<span class='notice'>You have chosen the Demolitions class, your role is to deal with hand-to-hand combat!</span>")
		if("demoman")
			chosen_loadout = /datum/outfit/assaultops/demoman
			to_chat(H, "<span class='notice'>You have chosen the Demolitions class, your role is to blow shit up!</span>")
		if("medic")
			chosen_loadout = /datum/outfit/assaultops/medic
			to_chat(H, "<span class='notice'>You have chosen the Medic class, your role is providing medical aid to fellow operatives!</span>")
		if("heavy")
			chosen_loadout = /datum/outfit/assaultops/heavy
			to_chat(H, "<span class='notice'>You have chosen the Heavy class, your role is continuous suppression!</span>")
		if("assault")
			chosen_loadout = /datum/outfit/assaultops/assault
			to_chat(H, "<span class='notice'>You have chosen the Assault class, your role is general combat!</span>")
		if("sniper")
			chosen_loadout = /datum/outfit/assaultops/sniper
			to_chat(H, "<span class='notice'>You have chosen the Sniper class, your role is suppressive fire!</span>")
		if("tech")
			chosen_loadout = /datum/outfit/assaultops/tech
			to_chat(H, "<span class='notice'>You have chosen the Tech class, your role is hacking!</span>")
		else
			chosen_loadout = pick(/datum/outfit/assaultops/cqb, /datum/outfit/assaultops/demoman, /datum/outfit/assaultops/medic, /datum/outfit/assaultops/heavy, /datum/outfit/assaultops/assault, /datum/outfit/assaultops/sniper, /datum/outfit/assaultops/tech)

	if(!chosen_loadout)
		chosen_loadout = /datum/outfit/assaultops

	H.equipOutfit(chosen_loadout)
	return TRUE

/datum/antagonist/assaultops/greet()
	owner.current.playsound_local(get_turf(owner.current), 'sound/ambience/antag/ops.ogg',100,0, use_reverb = FALSE)
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
		antag_memory += "Your currently assigned targets are: \n"
		for(var/i in GLOB.assaultops_targets)
			var/mob/living/carbon/human/H = i
			antag_memory += "\n - [H.name]: [H.job]"
		antag_memory += "\n <b>Try to kill only your targets, we need the crew.</b>"
		to_chat(owner, "You have been given a list of command and security staff that must be killed, check your notes!")
		to_chat(owner, "<span class='danger'>YOU ARE NOT NUCLEAR OPERATIVES, YOUR ASSIGNMENT IS HOSTILE TAKEOVER, DO NOT KILL BYSTANDERS UNLESS PROVOKED</span>")

/datum/antagonist/assaultops/proc/forge_objectives()
	if(assault_team)
		objectives |= assault_team.objectives

/datum/antagonist/assaultops/proc/move_to_spawnpoint()
	var/team_number = 1
	if(assault_team)
		team_number = assault_team.members.Find(owner)
	owner.current.forceMove(GLOB.nukeop_start[((team_number - 1) % GLOB.nukeop_start.len) + 1])

/datum/antagonist/assaultops/leader/move_to_spawnpoint()
	owner.current.forceMove(pick(GLOB.nukeop_leader_start))

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
	owner.current.forceMove(pick(GLOB.nukeop_start))

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


/datum/team/assaultops/proc/assaultops_dead()
	for(var/I in members)
		var/datum/mind/operative_mind = I
		if(ishuman(operative_mind.current) && (operative_mind.current.stat != DEAD))
			return FALSE
	return TRUE

/datum/team/assaultops/proc/crew_dead()
	var/finished = TRUE
	for(var/mob/living/carbon/human/H in GLOB.assaultops_targets)
		if(H.stat != DEAD)
			finished = FALSE
	if(finished)
		return TRUE
	return FALSE

/datum/team/assaultops/proc/get_result()
	var/crew_is_dead = crew_dead()
	var/assaultops_is_dead = assaultops_dead()

	if(!crew_is_dead && !assaultops_is_dead)
		return ASSAULT_RESULT_FLUKE
	else if(crew_is_dead)
		return ASSAULT_RESULT_ASSAULT_WIN
	else if (assaultops_is_dead)
		return ASSAULT_RESULT_CREW_WIN
	else
		return	//Undefined result

/datum/team/assaultops/roundend_report()
	var/list/parts = list()
	parts += "<span class='header'>[syndicate_name] Assault Operatives:</span>"

	switch(get_result())
		if(ASSAULT_RESULT_FLUKE)
			parts += "<span class='redtext big'>Stalemate</span>"
			parts += "Somehow the syndicate assault team and the loyalist nanotrasen crew have reached a stalemate!"
		if(ASSAULT_RESULT_ASSAULT_WIN)
			parts += "<span class='greentext big'>Syndicate Major Victory!</span>"
			parts += "<B>[syndicate_name] assault team have taken over [station_name()], leaving no loyalist NT crew!</B>"
		if(ASSAULT_RESULT_CREW_WIN)
			parts += "<span class='redtext big'>Crew Major Victory</span>"
			parts += "<B>The Research Staff has stopped the [syndicate_name] Assault Operatives!</B>"
		else
			parts += "<span class='neutraltext big'>Neutral Victory</span>"
			parts += "<B>Mission aborted!</B>"

	var/text = "<br><span class='header'>The syndicate assault operatives were:</span>"
	text += printplayerlist(members)
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
