GLOBAL_DATUM_INIT(unitologists, /datum/antagonist/unitologist, new)
GLOBAL_LIST_EMPTY(unitologists_list)
/*
/mob/proc/message_unitologists()
	set category = SPECIES_NECROMORPH
	set name = "Commune with the marker"
	set src = usr
	var/message = input("Say what?","Text") as null|text
	message = sanitize(message)
	message_necromorphs("<span class='cult'>[usr]: [message]</span>")
*/
/datum/antagonist/unitologist
	role_text = "Unitologist Zealot"
	role_text_plural = "Unitologist Zealots"
	welcome_text = "You are a zealot of Unitology, one of firm belief in convergence and be made whole, willing to do anything in pursuit of your beliefs. It is your assignment to make the Crew see the light, and submit to convergence, one way or the other. You have been blessed with a psychic connection created by the <b>marker</b>, and must serve the marker's will at all costs by bringing it human sacrifices. Remember, its objectives come before your own..."
	id = MODE_UNITOLOGIST
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	skill_setter = /datum/antag_skill_setter/station
	antaghud_indicator = "hudunitologist" // Used by the ghost antagHUD.
	antag_indicator = "hudunitologist"// icon_state for icons/mob/mob.dm visual indicator.
	restricted_jobs = list(JOBS_SECURITY)
	preference_candidacy_toggle = TRUE

	// Spawn values (autotraitor and game mode)
	//Hard cap of 6 will only be reached at really high playercounts
	hard_cap = 6                        // Max number at roundstart
	hard_cap_round = 6                  // Max number with adding during round
	initial_spawn_req = 0               // Gamemode using this template won't start without this # candidates.
	initial_spawn_target = 3            // Gamemode will attempt to spawn this many antags.

	category = CATEGORY_UNITOLOGY

/datum/objective/unitologist
	explanation_text = "Serve the marker at all costs."

/datum/antagonist/unitologist/create_objectives(var/datum/mind/marker_minion)
	.=..()
	if(!.)
		return
//	marker_minion.current?.psychosis_immune = TRUE //PENDING PSYCHOSIS MERGE.
	var/datum/objective/unitologist/unitologist_objective = new
	marker_minion.objectives += unitologist_objective
	GLOB.unitologists_list += marker_minion.current
	to_chat(marker_minion.current, "<span class='warning'>You can feel an alien presence altering your mind...</span>")
	addtimer(CALLBACK(src, .proc/give_collaborators, marker_minion.current), 2 SECONDS) //Let the other unitologists spawn before iterating through them.
	return

/datum/antagonist/unitologist/proc/give_collaborators(mob/living/our_owner)
	//our_owner.verbs |= /mob/proc/message_unitologists
	to_chat(our_owner, "<span class='warning'>The marker has established a psychic link between you and your fellow zealots.</span>")
	to_chat(our_owner, "<span class='warning'><i>Your mind is flooded with several names, these people must also share a connection to the marker...</i></span>")
	for(var/mob/living/minion in GLOB.unitologists_list)
		if(minion && minion != our_owner)
			to_chat(our_owner, "Fellow zealot: [minion.real_name]")
			our_owner.mind.store_memory("<b>Fellow zealot</b>: [minion.real_name]")

/datum/antagonist/unitologist/equip(var/mob/living/carbon/human/player)
	if(!..())
		return FALSE

	var/obj/item/weapon/tool/multitool/uplink/special/U = new(get_turf(player), player.mind, DEFAULT_TELECRYSTAL_AMOUNT)
	player.put_in_hands(U)
	return TRUE

GLOBAL_DATUM_INIT(shardbearers, /datum/antagonist/unitologist/shardbearer, new)
/*
	The Shardbearer
*/
/datum/antagonist/unitologist/shardbearer
	role_text = "Unitologist Zealot Shardbearer"
	role_text_plural = "Shardbearers"
	preference_candidacy_toggle = TRUE
	id = MODE_UNITOLOGIST_SHARD
	flags = 0

	hard_cap = 4
	hard_cap_round = 1					// When autoadding new shardbearers, we'll only do so if the number is below this
	initial_spawn_req = 1               // Gamemode using this template won't start without this # candidates.
	initial_spawn_target = 3            // Gamemode will attempt to spawn this many antags.
	override_scaling = FALSE	//No scaling

	welcome_text = "While on a planetary survey team on Aegis VII below, you uncovered the Holy Marker. It spoke to you, and you followed its directions, chipping off a piece and smuggling it aboard with you. <br>\
	The shard still speaks to you now. It tells you to hide it. Plant it somewhere in a dark, hidden corner of the Ishimura, where it will not be discovered"
	category = CATEGORY_UNITOLOGY

/datum/antagonist/unitologist/shardbearer/equip(var/mob/living/carbon/human/H)
	.=..()
	H.equip_to_storage_or_drop(new /obj/item/marker_shard)




/datum/antagonist/unitologist/shardbearer/create_objectives(var/datum/mind/marker_minion)
	if(!..())
		return
	var/datum/objective/unitologist/shard/unitologist_objective = new
	marker_minion.objectives += unitologist_objective

/datum/antagonist/unitologist/shardbearer/equip(var/mob/living/carbon/human/player)
	if(!..())
		return FALSE

	var/obj/item/weapon/tool/multitool/uplink/special/U = new(get_turf(player), player.mind, DEFAULT_TELECRYSTAL_AMOUNT)
	player.put_in_hands(U)
	return TRUE

/datum/objective/unitologist/shard
	explanation_text = "Plant the marker shard in a secret place and let it grow."

/datum/codex_entry/concept/unitology
	display_name = "Unitology"
	category = CATEGORY_CONCEPTS
	associated_strings = list("zealot", "unitologist", "unitology")
	lore_text = "Unitology is one of the few remaining widespread religions. Unitology was founded in 2215 by Craig Markoff, who used Michael Altman as a stalking horse. Michael Altman, as a result, became the unwilling prophet and icon of Unitology, sparking the popular phrase: Praise Altman."
	mechanics_text = "Unitology within the confines of this server is separated in two entities: Believers and Fanatics. The differences being:<br>\
	* Believers are not permitted to engage in hostile acts off their own volition. Believers are more susceptible to Marker whispers and voices, though are not allowed to comply with kill or suicide orders.<br>\
	* Fanatics are permitted to engage in hostile acts off their own volition, as they are antagonists in our server. They may also answer the calls of the Marker for offerings, murder, sacrifices and even suicide.<br><br>\
	\
	Players who choose to be a Unitologist, or convert to Unitology mid-round are considered Believers, whereas those chosen to be an antagonist are considered Fanatics. Only by being randomly spawned or chosen as an antag, can you consider yourself a fanatic.<br>\
	For obvious reasons, we hold Unitology in high regard with respect to the rules. The creation of characters that are clinically insane, and use this as cover to murder while <b>choosing</b> to be a Unitologist, won't get away with that."
	antag_text = "As one of the ship's fanatic Unitologists, it is your job to spread the word, light and convergence at the Marker's behest. You are to listen and comply with orders coming from the Marker, and you may <b>opt to listen</b> to the whispers coming from Signals.<br>\
	As an antagonist, you may kill others or yourself in the name of the Marker, and provide offerings to them for good favor. If you play your cards right, you may be the only man or woman walking amongst corpses for a while.<br>\
	As an antagonist, you may NOT use the Supermatter or Atmospherics in a grief-like way to ensure mass-kills. You may not willingly disrupt the flow of air, or blow up the Supermatter. You <b>may sabotage the Supermatter</b> however, by ejecting it and cutting power."



/*
	When counting shardbearers, we count the number of useable shards instead of people
*/
/datum/antagonist/unitologist/shardbearer/get_antag_count()
	var/list/shards = get_viable_shards()
	return length(shards)

/*
	Helpers
*/
/mob/proc/is_unitologist()
	if (! (mind?.special_role))
		return FALSE

	var/datum/antagonist/A = get_antag_data(mind.special_role)
	if (istype(A, /datum/antagonist/unitologist))
		return TRUE

	if (istype(A, /datum/antagonist/ert/unitologists))
		return TRUE

	return FALSE
