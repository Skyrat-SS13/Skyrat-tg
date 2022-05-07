/datum/traitor_objective/final/romerol
	name = "Spread the experimental bioterror agent Romerol by calling a droppod down at %AREA%"
	description = "Go to %AREA%, and recieve the bioterror agent. Spread it to the crew, \
	and watch then raise from the dead as mindless killing machines. Warning: The undead will attack you too."

	//this is a prototype so this progression is for all basic level kill objectives

	///area type the objective owner must be in to recieve the romerol
	var/area/romerol_spawnarea_type
	///checker on whether we have sent the romerol yet.
	var/sent_romerol = FALSE

/datum/traitor_objective/final/romerol/generate_objective(datum/mind/generating_for, list/possible_duplicates)
	if(!can_take_final_objective())
		return
	var/list/possible_areas = GLOB.the_station_areas.Copy()
	for(var/area/possible_area as anything in possible_areas)
		//remove areas too close to the destination, too obvious for our poor shmuck, or just unfair
		if(istype(possible_area, /area/station/hallway) || istype(possible_area, /area/station/security))
			possible_areas -= possible_area
	romerol_spawnarea_type = pick(possible_areas)
	replace_in_name("%AREA%", initial(romerol_spawnarea_type.name))
	return TRUE

/datum/traitor_objective/final/romerol/generate_ui_buttons(mob/user)
	var/list/buttons = list()
	if(!sent_romerol)
		buttons += add_ui_button("", "Pressing this will call down a pod with the biohazard kit.", "biohazard", "romerol")
	return buttons

/datum/traitor_objective/final/romerol/ui_perform_action(mob/living/user, action)
	. = ..()
	switch(action)
		if("romerol")
			if(sent_romerol)
				return
			var/area/delivery_area = get_area(user)
			if(delivery_area.type != romerol_spawnarea_type)
				to_chat(user, span_warning("You must be in [initial(romerol_spawnarea_type.name)] to recieve the bioterror agent."))
				return
			sent_romerol = TRUE
			podspawn(list(
				"target" = get_turf(user),
				"style" = STYLE_SYNDICATE,
				"spawn" = /obj/item/storage/box/syndie_kit/romerol,
			))
			priority_announce("Attention crew: sensors just detected an unregistered drop pod on final approach to your station. The pod appears to have decloaked and engaged thrusters after a remote activation signal likely sent from your vessel. Long-range scans suggest it may contain a highly-secured biohazardous agent. Estimated impact site: [initial(romerol_spawnarea_type.name)].", "[command_name()] High-Priority Update") //skyrat add: comm announcement on romerol call
