/datum/mind/proc/make_antag(antagtype, opt = null)
	message_admins("[src] was turned into [antagtype]")
	switch(antagtype)
		if(ROLE_TRAITOR)
			src.make_Traitor()
		if(ROLE_BROTHER)
			src.add_antag_datum(/datum/antagonist/brother/)
		if(ROLE_CHANGELING)
			src.make_Changeling()
		if(ROLE_REV)
			src.make_Rev()
		if(ROLE_CULTIST)
			src.add_antag_datum(/datum/antagonist/cult)
		if(ROLE_OBSESSED)
			src.add_antag_datum(/datum/antagonist/obsessed)
		if(ROLE_MONKEY)
			src.add_antag_datum(/datum/antagonist/monkey/leader)
		if(ROLE_INTERNAL_AFFAIRS)
			src.add_antag_datum(/datum/antagonist/traitor/internal_affairs)
		if(ROLE_FAMILIES)
			src.add_antag_datum(/datum/antagonist/gang)
		if(ROLE_HERETIC)
			src.add_antag_datum(/datum/antagonist/heretic)
	return

/client/proc/one_click_antag()
	set name = "Create Antagonist"
	set desc = "Auto-create an antagonist of your choice"
	set category = "Admin.Events"

	if(holder)
		holder.one_click_antag()
	return

/*
DOES NOT WORK:
BLOOD BROTHER
OBSESSED
IAA
FAMILIES

I dont even know; make_antag() calls perfectly fine, but then it just doesn't find valid players???
*/
/datum/admins/proc/one_click_antag()
	var/dat = ""
	for(var/role in GLOB.special_roles)
		if(role == ROLE_MALF)
			continue
		if(role == ROLE_PAI)
			continue
		if(role == ROLE_SENTIENCE)
			continue
		dat += "<a href='?src=[REF(src)];[HrefToken()];makeAntag=[role]'>Make [role](s)."
		if(antag_is_ghostrole(role))
			dat += " (Requires Ghosts)"
		dat += "</a><br>"
	var/datum/browser/popup = new(usr, "oneclickantag", "Quick-Create Antagonist", 400, 400)
	popup.set_content(dat)
	popup.open()

/datum/admins/proc/can_make_antag(mob/living/carbon/human/applicant, targetrole, onstation = TRUE, conscious = TRUE)
	if(applicant.mind.special_role)
		return FALSE
	if(!(targetrole in applicant.client.prefs.be_special))
		return FALSE
	if(onstation)
		var/turf/T = get_turf(applicant)
		if(!is_station_level(T.z))
			return FALSE
	if(conscious && applicant.stat) //incase you don't care about a certain antag being unconcious when made, ie if they have selfhealing abilities.
		return FALSE
	if(!considered_alive(applicant.mind) || considered_afk(applicant.mind)) //makes sure the player isn't a zombie, brain, or just afk all together
		return FALSE
	return !is_banned_from(applicant.ckey, list(targetrole, ROLE_SYNDICATE))

/datum/admins/
	var/MAKEANTAG_RESTRICTLIST = list()
	var/MAKEANTAG_PL_DEFAULT_SEC = list("Prisoner", "Security Officer", "Warden", "Detective", "Head of Security", "Captain")
	var/MAKEANTAG_PL_DEFAULT_SILICON = list("AI", "Cyborg")

/datum/admins/proc/antag_get_protected_roles(antagtype)
	if(MAKEANTAG_RESTRICTLIST[antagtype])
		return MAKEANTAG_RESTRICTLIST[antagtype]
	//message_admins("Constructing Protected Roles for [antagtype]")
	var/c_p = CONFIG_GET(flag/protect_roles_from_antagonist)
	var/c_a = CONFIG_GET(flag/protect_assistant_from_antagonist)
	var/list/p_p = list()
	var/list/p_r = list()
	switch(antagtype)
		if(ROLE_TRAITOR)
			p_p += MAKEANTAG_PL_DEFAULT_SEC
		if(ROLE_CHANGELING)
			p_p += MAKEANTAG_PL_DEFAULT_SEC
		if(ROLE_CULTIST)
			p_p += MAKEANTAG_PL_DEFAULT_SEC
			p_p += MAKEANTAG_PL_DEFAULT_SILICON
			p_p += list("Chaplain", "Head of Personnel")
		if(ROLE_HERETIC)
			p_p += MAKEANTAG_PL_DEFAULT_SEC
			p_r += MAKEANTAG_PL_DEFAULT_SILICON
		if(ROLE_FAMILIES)
			p_r += MAKEANTAG_PL_DEFAULT_SEC
			p_r += MAKEANTAG_PL_DEFAULT_SILICON
			p_r += list("Head of Personnel")
		if(ROLE_MONKEY)
			p_r += MAKEANTAG_PL_DEFAULT_SILICON
			p_r += list("Prisoner")
		if(ROLE_REV)
			p_r += MAKEANTAG_PL_DEFAULT_SEC
			p_r += MAKEANTAG_PL_DEFAULT_SILICON
			p_r += list("Head of Personnel", "Chief Engineer", "Research Director", "Chief Medical Officer")
	if(c_a)
		p_r += list("Assistant")
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
	message_admins("Trying to create '[antagtype]' with an optional paramater of '[opt]'")

	if(antag_is_ghostrole(antagtype))
		return make_antag_ghostrole(antagtype, opt)

	var/list/restricted_jobs = antag_get_protected_roles(antagtype)
	var/list/mob/living/carbon/human/candidates = list()
	var/mob/living/carbon/human/holder = null
	for(var/mob/living/carbon/human/applicant in GLOB.player_list)
		//message_admins("player_list [applicant]")
		if(can_make_antag(applicant, antagtype))
			if(applicant.job in restricted_jobs)
				continue
			candidates += applicant
	if(candidates.len)
		var/canmake = min(candidates.len, opt)
		for(var/index = 0, index<canmake, index++)
			holder = pick(candidates)
			holder.mind.make_antag(antagtype)
			candidates.Remove(holder)
		return TRUE
	return FALSE

/datum/admins/proc/make_antag_ghostrole(antagtype, opt)
	//message_admins("make_antag_ghostrole [antagtype]")
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
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for the position of a Wizard Foundation 'diplomat'?", ROLE_WIZARD, null)
	var/mob/dead/observer/selected = pick_n_take(candidates)
	var/mob/living/carbon/human/new_character = makeBody(selected)
	new_character.mind.make_Wizard()
	return TRUE

/datum/admins/proc/make_nukies(maxCount = 5)
	var/list/mob/dead/observer/candidates = pollGhostCandidates("Do you wish to be considered for a nuke team being sent in?", ROLE_OPERATIVE, null)
	var/list/mob/dead/observer/chosen = list()
	var/mob/dead/observer/theghost = null
	if(candidates.len)
		var/numagents = maxCount
		var/agentcount = 0
		for(var/i = 0, i<numagents,i++)
			shuffle_inplace(candidates) //More shuffles means more randoms
			for(var/mob/j in candidates)
				if(!j || !j.client)
					candidates.Remove(j)
					continue
				theghost = j
				candidates.Remove(theghost)
				chosen += theghost
				agentcount++
				break
		//Making sure we have atleast 3 Nuke agents, because less than that is kinda bad
		if(agentcount < 3)
			return FALSE
		//Let's find the spawn locations
		var/leader_chosen = FALSE
		var/datum/team/nuclear/nuke_team
		for(var/mob/c in chosen)
			var/mob/living/carbon/human/new_character=makeBody(c)
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
