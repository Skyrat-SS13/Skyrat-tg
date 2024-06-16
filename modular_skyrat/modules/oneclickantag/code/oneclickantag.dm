/datum/mind/var/list/oneclickantag = list()

/datum/mind/remove_antag_datum(datum)
	var/datum/antagonist/antag = datum
	var/role = initial(antag.job_rank)
	if(role)
		oneclickantag += role
	else message_admins("Unable to update [src]'s previous antag list for One Click Antag. Unhandled datum '[datum]'. Ping ZephyrTFA.")
	return ..()

/datum/mind/proc/make_antag(antagtype, opt = null)
	message_admins("[src] was turned into [antagtype]")
	src.oneclickantag += antagtype
	switch(antagtype)
		if(ROLE_TRAITOR)
			src.add_antag_datum(/datum/antagonist/traitor)
		if(ROLE_CHANGELING)
			src.add_antag_datum(/datum/antagonist/changeling)
		if(ROLE_REV)
			var/datum/antagonist/rev/head/antag = new
			antag.give_flash = TRUE
			antag.give_hud = TRUE
			src.add_antag_datum(antag)
		if(ROLE_CULTIST)
			src.add_antag_datum(/datum/antagonist/cult)
		if(ROLE_BROTHER)
			if(!istype(opt, /datum/team/brother_team))
				message_admins("Attempted to create bloodbrothers but no team was specified!")
				return FALSE
			var/datum/team/brother_team/team = opt
			src.add_antag_datum(/datum/antagonist/brother, team)
		if(ROLE_HERETIC)
			src.add_antag_datum(/datum/antagonist/heretic)
		else
			message_admins("[src] could not be turned into [antagtype] as it is not implemented; blame coders.")
			return FALSE
	return TRUE

ADMIN_VERB(one_click_antag, R_ADMIN, "Create Antagonist", "Auto-create an antagonist of your choice", ADMIN_CATEGORY_EVENTS)
	user.holder?.one_click_antag()

/**
If anyone can figure out how to get Obsessed to work I would be very appreciative.
**/
/datum/admins/proc/one_click_antag()
	var/dat = ""
	for(var/role in GLOB.special_roles)
		if(role in list(ROLE_MALF, ROLE_PAI, ROLE_SENTIENCE, ROLE_OBSESSED))
			continue
		dat += "<a href='?src=[REF(src)];[HrefToken()];makeAntag=[role]'>Make [role](s)."
		if(antag_is_ghostrole(role))
			dat += " (Requires Ghosts)"
		dat += "</a><br>"
	var/datum/browser/popup = new(usr, "oneclickantag", "Quick-Create Antagonist", 400, 400)
	popup.set_content(dat)
	popup.open()

/datum/admins/proc/can_make_antag(mob/living/carbon/human/applicant, targetrole, onstation = TRUE, conscious = TRUE)
	if(applicant.mind.oneclickantag.Find(targetrole))
		return FALSE
	if(applicant.mind.special_role)
		return FALSE
	if(!(targetrole in applicant.client.prefs.be_special))
		return FALSE
	if(onstation)
		var/turf/T = get_turf(applicant)
		if(!is_station_level(T.z))
			return FALSE
	if(conscious && applicant.stat)
		return FALSE
	if(!considered_alive(applicant.mind) || considered_afk(applicant.mind))
		return FALSE
	if(is_banned_from(applicant.ckey, list(targetrole, ROLE_SYNDICATE)))
		return FALSE
	return TRUE

/datum/admins/
	var/MAKEANTAG_RESTRICTLIST = list()
	var/MAKEANTAG_PL_DEFAULT_SECURITY = list(JOB_PRISONER, JOB_SECURITY_OFFICER, JOB_WARDEN, JOB_DETECTIVE, JOB_HEAD_OF_SECURITY, JOB_CAPTAIN, JOB_CORRECTIONS_OFFICER, JOB_BLUESHIELD, JOB_ORDERLY, JOB_BOUNCER, JOB_CUSTOMS_AGENT, JOB_ENGINEERING_GUARD, JOB_SCIENCE_GUARD)
	var/MAKEANTAG_PL_DEFAULT_HEADS = list(JOB_CAPTAIN,JOB_HEAD_OF_PERSONNEL,JOB_RESEARCH_DIRECTOR,JOB_CHIEF_ENGINEER,JOB_CHIEF_MEDICAL_OFFICER,JOB_HEAD_OF_SECURITY,JOB_QUARTERMASTER)
	var/MAKEANTAG_PL_DEFAULT_SILICON = list(JOB_AI, JOB_CYBORG)

/datum/admins/proc/antag_get_protected_roles(antagtype)
	if(MAKEANTAG_RESTRICTLIST[antagtype])
		return MAKEANTAG_RESTRICTLIST[antagtype]
	var/c_p = CONFIG_GET(flag/protect_roles_from_antagonist)
	var/c_a = CONFIG_GET(flag/protect_assistant_from_antagonist)
	var/list/p_p = list()
	var/list/p_r = list()
	switch(antagtype)
		if(ROLE_TRAITOR)
			p_p += MAKEANTAG_PL_DEFAULT_SECURITY
			p_p += MAKEANTAG_PL_DEFAULT_HEADS
		if(ROLE_CHANGELING)
			p_p += MAKEANTAG_PL_DEFAULT_SECURITY
			p_p += MAKEANTAG_PL_DEFAULT_HEADS
		if(ROLE_CULTIST)
			p_p += MAKEANTAG_PL_DEFAULT_SECURITY
			p_p += MAKEANTAG_PL_DEFAULT_HEADS
			p_p += MAKEANTAG_PL_DEFAULT_SILICON
			p_p += list(JOB_CHAPLAIN, JOB_HEAD_OF_PERSONNEL)
		if(ROLE_HERETIC)
			p_p += MAKEANTAG_PL_DEFAULT_SECURITY
			p_p += MAKEANTAG_PL_DEFAULT_HEADS
			p_r += MAKEANTAG_PL_DEFAULT_SILICON
		if(ROLE_REV)
			p_r += MAKEANTAG_PL_DEFAULT_SECURITY
			p_r += MAKEANTAG_PL_DEFAULT_HEADS
			p_r += MAKEANTAG_PL_DEFAULT_SILICON
	if(c_a)
		p_r += list(JOB_ASSISTANT)
	if(c_p)
		p_r += p_p
	MAKEANTAG_RESTRICTLIST[antagtype] = p_r
	return p_r

/datum/admins/proc/antag_is_ghostrole(antagtype)
	switch(antagtype)
		if(ROLE_WIZARD)
			return TRUE
		if(ROLE_OPERATIVE)
			return TRUE
		if(ROLE_NINJA)
			return TRUE
		if(ROLE_ABDUCTOR)
			return TRUE
		if(ROLE_REVENANT)
			return TRUE
		if(ROLE_SPACE_DRAGON)
			return TRUE
		if(ROLE_BLOB)
			return TRUE
		if(ROLE_ALIEN)
			return TRUE
	return FALSE

/datum/admins/proc/make_antag(antagtype, opt)
	if(antag_is_ghostrole(antagtype))
		return make_antag_ghostrole(antagtype, opt)
	var/datum/team/brother_team/team
	if(antagtype == ROLE_BROTHER)
		team = new
		team.forge_brother_objectives()
	var/list/restricted_jobs = antag_get_protected_roles(antagtype)
	var/list/mob/living/carbon/human/candidates = list()
	var/mob/living/carbon/human/holder = null
	for(var/mob/living/carbon/human/applicant in GLOB.player_list)
		if(can_make_antag(applicant, antagtype))
			if(applicant.job in restricted_jobs)
				continue
			candidates += applicant
	if(candidates.len)
		candidates = shuffle(candidates)
		var/canmake = min(candidates.len, opt)
		for(var/index = 0, index<canmake, index++)
			holder = pick(candidates)
			if(antagtype==ROLE_BROTHER)
				holder.mind.make_antag(antagtype, team)
			else
				holder.mind.make_antag(antagtype)
			candidates.Remove(holder)
		if(antagtype==ROLE_BROTHER)
			team.update_name()
		return TRUE
	return FALSE

/datum/admins/proc/make_antag_ghostrole(antagtype, opt)
	switch(antagtype)
		if(ROLE_WIZARD)
			return make_wizard()
		if(ROLE_OPERATIVE)
			return make_nukies(opt)
		if(ROLE_NINJA)
			new /datum/round_event/ghost_role/space_ninja()
			return TRUE
		if(ROLE_BLOB)
			new/datum/round_event/ghost_role/blob(TRUE, opt)
			return TRUE
		if(ROLE_ABDUCTOR)
			new /datum/round_event/ghost_role/abductor()
			return TRUE
		if(ROLE_ALIEN)
			return make_aliens(opt)
		if(ROLE_REVENANT)
			new /datum/round_event/ghost_role/revenant(TRUE, TRUE)
			return TRUE
		if(ROLE_SPACE_DRAGON)
			new /datum/round_event/ghost_role/space_dragon()
			return TRUE
	return FALSE

/datum/admins/proc/make_wizard()
	var/list/mob/dead/observer/candidates = SSpolling.poll_ghost_candidates("Do you wish to be considered for the position of a Wizard Foundation 'diplomat'?", role = ROLE_WIZARD)
	var/mob/living/carbon/human/target
	do
		var/mob/dead/observer/selected = pick_n_take(candidates)
		if(!LAZYLEN(candidates))
			return FALSE
		target = make_body(selected)
		if(!target.mind.active) //SMH people can't be trusted with shit; why would you DISCONNECT RIGHT AFTER BEING SELECTED FOR THE GHOST ROLE???
			qdel(target)
			continue
	while(!target)
	target.mind.add_antag_datum(/datum/antagonist/wizard)
	return TRUE

/datum/admins/proc/make_nukies(maxCount = 5)
	var/list/mob/dead/observer/candidates =  SSpolling.poll_ghost_candidates("Do you wish to be considered for a nuke team being sent in?", role = ROLE_OPERATIVE)
	var/list/mob/dead/observer/chosen = list()
	var/mob/dead/observer/theghost = null
	if(candidates.len)
		var/numagents = maxCount
		var/agentcount = 0
		for(var/i = 0, i<numagents,i++)
			shuffle_inplace(candidates)
			for(var/mob/j in candidates)
				if(!j || !j.client)
					candidates.Remove(j)
					continue
				theghost = j
				candidates.Remove(theghost)
				chosen += theghost
				agentcount++
				break
		if(agentcount < 3)
			return FALSE
		var/leader_chosen = FALSE
		var/datum/team/nuclear/nuke_team
		for(var/mob/c in chosen)
			var/mob/living/carbon/human/new_character = make_body(c)
			if(!leader_chosen)
				leader_chosen = TRUE
				var/datum/antagonist/nukeop/N = new_character.mind.add_antag_datum(/datum/antagonist/nukeop/leader)
				nuke_team = N.nuke_team
			else
				new_character.mind.add_antag_datum(/datum/antagonist/nukeop,nuke_team)
		return TRUE
	else
		return FALSE

/datum/admins/proc/make_aliens(count)
	var/datum/round_event/ghost_role/alien_infestation/E = new(FALSE)
	E.spawncount = count
	E.processing = TRUE
	return TRUE
