/**

Earthgov agents, by Kmc2000 (initial groundwork by theLion).
This antag uses two extensions, one which tracks "evidence" like photographs of suspicious things, and one which handles receipt of said evidence.
There's a few lists down below if you need to make any changes, these operate what counts as applicable evidence for the agents to submit.

*/

GLOBAL_DATUM_INIT(agents, /datum/antagonist/earthgov_agent, new)
GLOBAL_LIST_EMPTY(agents_list)

//List of all the earthgov agent objectives. These are always present on an earthgov antag
#define EARTHGOV_OBJECTIVES list(/datum/objective/collect_evidence, /datum/objective/escape, /datum/objective/unitologist_recon)
//List of "bonus" objectives, these are picked at random
#define EARTHGOV_OBJECTIVES_OPTIONAL list(/datum/objective/collect_evidence/illegal_mining, /datum/objective/brig)
//Anything that can be photographed and faxed as "evidence" of unitologists, illegal activity etc. As strict types, SUBTYPES NOT INCLUDED!

#define EARTHGOV_UNITOLOGIST_EVIDENCE list(/obj/machinery/marker, /obj/item/weapon/storage/bible/unitology, /obj/item/weapon/storage/lunchbox/unitology)
#define EARTHGOV_CRACKING_EVIDENCE list(/obj/item/weapon/card/id/holo/mining, /obj/item/weapon/card/id/holo/mining/director, /obj/item/weapon/card/id/holo/mining/foreman, /obj/item/clothing/under/deadspace/planet_cracker)

//If you define more evidence lists, concatenate them here. This is what cameras search through to mark things as "suspicious"
#define EARTHGOV_EVIDENCE_TYPES EARTHGOV_UNITOLOGIST_EVIDENCE + EARTHGOV_CRACKING_EVIDENCE

/datum/antagonist/earthgov_agent
	role_text = ROLETEXT_EARTHGOV_AGENT
	role_text_plural = "EarthGov Agents"
	welcome_text = "You are a well-trained agent of the government of Earth, sent to spy on the illegal planet cracking operation in the Cygnus system. In addition, you are investigating a lead that the Church of Unitology has infiltrated the crew of the Ishimura. It is your assignment to report back to your superiors, investigate the situation surrounding the Church, and protect the interests of Earth. You have been provided a direct comm-link to <b>EarthGov Command</b>. Remember, EarthGov directives come before your own..."
	id = MODE_EARTHGOV_AGENT
	flags = ANTAG_SUSPICIOUS | ANTAG_RANDSPAWN | ANTAG_VOTABLE
	skill_setter = /datum/antag_skill_setter/station
	antaghud_indicator = "hudearthgov" // Used by the ghost antagHUD.
	antag_indicator = "hudearthgov"// icon_state for icons/mob/mob.dm visual indicator.
	preference_candidacy_toggle = TRUE

	// Spawn values (autotraitor and game mode)
	//Hard cap of 6 will only be reached at really high playercounts
	hard_cap = 2                        // Autotraitor var. Won't spawn more than this many antags.
	hard_cap_round = 2                  // As above but 'core' round antags ie. roundstart.
	initial_spawn_req = 0               // Gamemode using this template won't start without this # candidates.
	initial_spawn_target = 2            // Gamemode will attempt to spawn this many antags.
	restricted_jobs = list(JOBS_COMMAND)


/datum/antagonist/earthgov_agent/create_objectives(var/datum/mind/player, var/override=0)
	.=..()

	//When a new agent is activated, we force the marine team to regenerate their global objectives, in order to create an extract objective targeting us
	var/datum/antagonist/ert/edf_marines/EDFM = get_antag_data(ERT_EDF_MARINES)
	EDFM.create_global_objectives(TRUE)


/datum/antagonist/earthgov_agent/equip(var/mob/living/carbon/human/player)

	if(!..())
		return FALSE

	var/obj/item/weapon/tool/multitool/uplink/special/U = new(get_turf(player), player.mind, DEFAULT_TELECRYSTAL_AMOUNT)
	player.put_in_hands(U)

	return TRUE





//Extension for handling special earthgov objectives.

/datum/extension/earthgov_evidence
	var/suspect_details = null //What this evidence shows.
	var/suspect_type = null

/datum/extension/earthgov_evidence/proc/copy_to(datum/extension/earthgov_evidence/target)
	target.suspect_details = suspect_details
	target.suspect_type = suspect_type

/datum/extension/earthgov_evidence/New(datum/holder, atom/movable/suspicious_object)
	. = ..()
	if(!istype(suspicious_object))
		return //No, you can't collect datums as evidence.
	suspect_details = suspicious_object.name //Just stores the name, in case the object is destroyed.
	suspect_type = suspicious_object.type //And store some extra debug info for later.

//Show the details of the captured evidence. You don't have to work for earthgov to see this to allow captains etc. to burn the evidence to protect the corporation.
/datum/extension/earthgov_evidence/proc/display_evidence(mob/user)
	if(user && ismob(user)) //Sure, we'll let ghosts see evidence too.
		to_chat(user, "<span class='notice'><i>This photo shows a [suspect_details]! This could be quite incriminating if presented as evidence to EarthGov...</i></span>")

/datum/extension/earthgov
	name = "EarthGov Mission Handler"

/datum/extension/earthgov/proc/on_admin_fax(obj/item/weapon/photo/target, destination)
	var/datum/mind/M = holder
	if(!istype(M))
		message_admins("Earthgov extension was added to a non mind ([holder]), contact a coder please!")
		return FALSE //No idea what happened here.
	to_chat(M.current, "<span class='notice'><b>You hear a message crackle in your ears...</b></span>")
	to_chat(M.current, "<span class='notice'>We're analyzing the evidence you sent in, please hold. </span>")

	var/datum/extension/earthgov_evidence/E = get_extension(target, /datum/extension/earthgov_evidence)
	if(!E) //No idea why this would happen, but.
		to_chat(M.current, "<span class='notice'>Something bugged out with your objectives, please ahelp!</span>")
		return FALSE
	for(var/datum/objective/O in M.objectives)
		if(istype(O, /datum/objective/collect_evidence))
			var/datum/objective/collect_evidence/C = O
			for(var/e_type in C.evidence_types)
				if(e_type == E.suspect_type)
					C.completed = TRUE //Evidence checks out, grats.
					to_chat(M.current, "<span class='warning'>You have successfully submitted evidence of [C.activity_type] activity aboard the USG Ishimura to EarthGov. Good work, agent.</span>")
					return TRUE
	to_chat(M.current, "<span class='notice'>This isn't something we can use, gather further evidence.</span>")
	return FALSE

/datum/objective/unitologist_recon
	explanation_text = "Spy on the Ishimura and protect EarthGov's interests by any means you see fit."
	completed = TRUE //This is honestly just a fluff objective from the looks of it.

//Collecting evidence of unitology aboard the ship, stuff like the marker itself, bibles, or whatever.
/datum/objective/collect_evidence
	explanation_text = "Collect evidence of unitologist worship aboard the USG Ishimura, and fax it to EarthGov before the round ends <b>(Send the evidence to earthgov, NOT a department aboard the Ishimura!)</b>."
	var/activity_type = "Unitologist"
	var/list/evidence_types = EARTHGOV_UNITOLOGIST_EVIDENCE
//Collecting evidence of miners, or well, specifically miners with planet cracker gear!
/datum/objective/collect_evidence/illegal_mining
	explanation_text = "Collect evidence of illegal planet cracking aboard the USG Ishimura, and fax it to EarthGov before the round ends <b>(Send the evidence to earthgov, NOT a department aboard the Ishimura!)</b>."
	activity_type = "illegal planet cracking"
	evidence_types = EARTHGOV_CRACKING_EVIDENCE

/datum/antagonist/earthgov_agent/create_objectives(var/datum/mind/traitor)
	if(!..())
		return
	set_extension(traitor, /datum/extension/earthgov)
	//EarthGov specific objectives...

	for(var/otype in EARTHGOV_OBJECTIVES)
		if (!(locate(otype) in traitor.objectives))
			var/datum/objective/objective = new otype()
			objective.owner = traitor
			traitor.objectives += objective
	if(!traitor.current)
		message_admins("BUG: Earthgov agent antagonist added to a mind with no body...?")
		return FALSE
	var/atom/movable/backpack = traitor.current.back
	new /obj/item/device/camera(backpack) //Earthgov agents need a camera to collect evidence!
	var/list/optional = EARTHGOV_OBJECTIVES_OPTIONAL
	for(var/otype in optional)
		message_admins(otype)
		//Evenly distribute the objectives using probability, this should mathematically guarantee you at least get one. As more objectives are added, your chance to get a given one decreases.
		if(prob(round(100 / optional.len)))
			var/datum/objective/objective = new otype()
			objective.owner = traitor
			traitor.objectives += objective

/datum/antagonist/earthgov_agent/proc/give_collaborators(mob/living/our_owner)
	//our_owner.verbs |= /mob/proc/message_earthgov_agent
	to_chat(our_owner, "<span class='warning'>A comm link has been established between you and your fellow agents.</span>")
	to_chat(our_owner, "<span class='warning'><i>You are provided with several names, these people are your allies.</i></span>")
	for(var/mob/living/minion in GLOB.agents_list)
		if(minion && minion != our_owner)
			to_chat(our_owner, "Fellow agent: [minion.real_name]")
			our_owner.mind.store_memory("<b>Fellow agent</b>: [minion.real_name]")

/datum/codex_entry/concept/earthgov_agents
	display_name = "EarthGov"
	category = CATEGORY_CONCEPTS
	associated_strings = list("EarthGov", "agent", "Earth")
	lore_text = "The Earth Government Colonial Alliance, or EarthGov, is the executive branch of Earth and all its colonies."
	mechanics_text = "For the purpose of this game setting, no one is specifically associated with EarthGov unless:<br> \ * They are an EarthGov agent sent specifically with a task, or have been coopted into an EarthGov operation.<br>\ * Are a marine within the Earth Defense Force.<br><br>"