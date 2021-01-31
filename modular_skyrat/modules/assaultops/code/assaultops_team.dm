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

//Returns any alive assaultops
/datum/team/assaultops/proc/get_alive_assaultops()
	sanity_check_assaultops_targets()
	var/list/alive = list()
	for(var/i in members)
		var/datum/mind/operative_mind = i
		if(ishuman(operative_mind.current) && is_assault_operative(operative_mind.current) && (operative_mind.current.stat != DEAD))
			alive.Add(i)
	return alive

//Returns any targets that are alive
/datum/team/assaultops/proc/get_alive_targets()
	sanity_check_assaultops_targets()
	var/list/alive = list()
	for(var/i in GLOB.assaultops_targets)
		var/datum/mind/M = i
		if(M.current.stat != DEAD)
			alive.Add(M)
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
	text += printplayerlist(GLOB.assaultops_targets)
	text += "<br>"
	parts += text

	return "<div class='panel redborder'>[parts.Join("<br>")]</div>"

/datum/team/assaultops/antag_listing_name()
	if(syndicate_name)
		return "[syndicate_name] Syndicates"
	else
		return "Syndicates"


/datum/team/assaultops/is_gamemode_hero()
	return SSticker.mode.name == "assaultops"
