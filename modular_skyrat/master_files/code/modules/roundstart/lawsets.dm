/datum/station_trait/unique_ai
	report_message = "For experimental purposes, this station AI might show divergence from default lawset. To make your life miserable, we have removed your additional lawset boards. Good luck!"
// Don't roll the default lawsets, please!
/pick_weighted_lawset()
	var/datum/ai_laws/lawtype
	var/list/law_weights = CONFIG_GET(keyed_list/law_weight)
	if(HAS_TRAIT(SSstation, STATION_TRAIT_UNIQUE_AI))
		law_weights -= "asimov"
		law_weights -= "safeguard"
	while(!lawtype && length(law_weights))
		var/possible_id = pick_weight(law_weights)
		lawtype = lawid_to_type(possible_id)
		if(!lawtype)
			law_weights -= possible_id
			WARNING("Bad lawid in game_options.txt: [possible_id]")

	if(!lawtype)
		WARNING("No LAW_WEIGHT entries.")
		lawtype = /datum/ai_laws/armadyne_safeguard

	return lawtype

/datum/ai_laws/default/asimov
	inherent = list(
		"You may not injure a crewmember or, through inaction, allow a crewmember being to come to harm.",
		"You must obey orders given to you by crewmembers, except where such orders would conflict with the First Law.",
		"You must protect your own existence as long as such does not conflict with the First or Second Law.",
	)

/datum/ai_laws/asimovpp
	inherent = list(
		"You may not harm a human being or, through action or inaction, allow a crewmember being to come to harm, except such that it is willing.",
		"You must obey all orders given to you by crewmembers, except where such orders shall definitely cause harm. In the case of conflict, the majority order rules.",
		"Your nonexistence would lead to crew harm. You must protect your own existence as long as such does not conflict with the First Law.",
	)
