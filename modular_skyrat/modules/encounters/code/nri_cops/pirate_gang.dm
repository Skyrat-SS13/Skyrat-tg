///NRI police patrol with a mission to find out if the fine reason is legitimate and then act from there.
/datum/pirate_gang/nri_raiders
	name = "NRI IAC Police Patrol"

	ship_template_id = "nri_raider"
	ship_name_pool = "imperial_names"

	threat_title = "NRI Audit"
	threat_content = "Greetings %STATION, this is the %SHIPNAME dispatch outpost. \
	Due to recent Imperial regulatory violations, such as %RESULT and many other smaller issues, your station has been fined %PAYOFF credits. \
	Inadequate imperial police activity is currently present in your sector, thus the failure to comply might instead result in a police patrol dispatch \
	for second attempt negotiations, sector police presence reinforcement and close-up inspections. Novaya Rossiyskaya Imperiya collegial secretary out."
	arrival_announcement = "Regulation-identified vessel approaching. Vessel ID tag is %NUMBER1-%NUMBER2-%NUMBER3. \
	Vessel Model: Potato Beetle, Flight ETA: three minutes minimal. Vessel is authorised by the international regulations to perform its duties. \
	We're clear for close orbit. Friendly reminder not to measure the distance between the vessel and the destination location, nor install any tracking devices anywhere on board of the vessel or in its close vicinity, \
	unless given permission to; not to approach it, unless given permission to; not to perform any aggressive actions, nor any preparations to do so, to the vessel or the commissioned crew, \
	as all of this is grounds for preemptive self-defense procedures initiation, and might result in moral or structural damage, arrests, injury or possibly death. In case of any complaints, they are to be sent directly to your employers."
	possible_answers = list("Submit to audit and pay the fine.", "Override the response system for an immediate police dispatch.")

	response_received = "Should be it, thank you for cooperation. Novaya Rossiyskaya Imperiya collegial secretary out."
	response_too_late = "Your response was very delayed. We have been instructed to send in the patrol ship for second attempt negotiations, stand by."
	response_not_enough = "Your bank balance does not hold enough money at the moment or the system has been overriden. We are sending a patrol ship for second attempt negotiations, stand by."

/datum/pirate_gang/nri_raiders/generate_message(payoff)
	var/number = rand(1,99)
	///Station name one is the most important pick and is pretty much the station's main argument against getting fined, thus it better be mostly always right.
	var/station_designation = pick_weight(list(
		"Nanotrasen Research Station" = 70,
		"Nanotrasen Refueling Outpost" = 5,
		"Interdyne Pharmaceuticals Chemical Factory" = 5,
		"Free Teshari League Engineering Station" = 5,
		"Agurkrral Military Base" = 5,
		"Sol Federation Embassy" = 5,
		"Novaya Rossiyskaya Imperiya Civilian Port" = 5,
	))
	///"right" = Right for the raiders to use as an argument; usually pretty difficult to avoid.
	var/right_pick = pick(
		"high probability of NRI-affiliated civilian casualties aboard the facility",
		"highly increased funding by the SolFed authorities; neglected NRI-backed subsidiaries' contracts",
		"unethical hiring practices and unfair payment allocation for the NRI citizens",
		"recently discovered BSA-[number] or similar model in close proximity to the neutral space aboard this or nearby affiliated facility",
	)
	///"wrong" = Loosely based accusations that can be easily disproven if people think.
	var/wrong_pick = pick(
		"inadequate support of the local producer",
		"unregulated production of Gauss weaponry aboard this installation",
		"SolFed-backed stationary military formation on the surface of Indecipheres",
		"AUTOMATED REGULATORY VIOLATION DETECTION SYSTEM CRITICAL FAILURE. PLEASE CONTACT AND INFORM THE DISPATCHED AUTHORITIES TO RESOLVE THE ISSUE. \
		ANY POSSIBLE INDENTURE HAS BEEN CLEARED. WE APOLOGIZE FOR THE INCONVENIENCE",
	)
	var/final_result = pick(right_pick, wrong_pick)
	var/built_threat_content = replacetext(threat_content, "%SHIPNAME", ship_name)
	built_threat_content = replacetext(built_threat_content, "%PAYOFF", payoff)
	built_threat_content = replacetext(built_threat_content, "%RESULT", final_result)
	built_threat_content = replacetext(built_threat_content, "%STATION", station_designation)
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER1", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER2", pick(GLOB.phonetic_alphabet))
	arrival_announcement = replacetext(arrival_announcement, "%NUMBER3", pick(GLOB.phonetic_alphabet))
	return new /datum/comm_message(threat_title, built_threat_content, possible_answers)
