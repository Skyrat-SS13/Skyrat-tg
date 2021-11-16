GLOBAL_VAR_INIT(amt_911_responders, 0)
GLOBAL_VAR_INIT(votes_for_bad_911_call, 0)
GLOBAL_VAR_INIT(fradulent_911_declared, FALSE)
GLOBAL_VAR(caller_of_911)
GLOBAL_LIST_INIT(emergency_responders, list())
/datum/antagonist/ert/request_911
	name = "911 Responder"
	antag_hud_name = "hud_spacecop"
	suicide_cry = "FOR THE SOL FEDERATION!!"
	var/department = "Some stupid shit"

/datum/antagonist/ert/request_911/apply_innate_effects(mob/living/mob_override)
	..()
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		var/atom/movable/screen/wanted/giving_wanted_lvl = new /atom/movable/screen/wanted()
		H.wanted_lvl = giving_wanted_lvl
		giving_wanted_lvl.hud = H
		H.infodisplay += giving_wanted_lvl
		H.mymob.client.screen += giving_wanted_lvl


/datum/antagonist/ert/request_911/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		H.infodisplay -= H.wanted_lvl
		QDEL_NULL(H.wanted_lvl)
	..()

/datum/antagonist/ert/request_911/greet()
	var/missiondesc =  "<span class='warningplain'><B><font size=6 color=red>You are the [name].</font></B>"
	missiondesc += "<BR><B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station for immediate SolFed [department] assistance!\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact whoever called 911 and assist in resolving the matter."
	missiondesc += "<BR> <B>2.</B> Protect, ensure, and uphold the rights of Sol Federation citizens on board [station_name()]."
	missiondesc += "<BR> <B>3.</B> If the 911 call was made in error, for poor reasons, or with known malice, use the False 911 Call Reporter in \
	your backpack to vote that the 911 call was false. This will immediately fine the crew and issue a response to arrest the caller."
	to_chat(owner,missiondesc)
	var/policy = get_policy(ROLE_FAMILIES)
	if(policy)
		to_chat(owner, policy)
	var/mob/living/M = owner.current
	M.playsound_local(M, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/ert/request_911
	name = "911 Response: Base"
	back = /obj/item/storage/backpack/duffelbag/cops
	backpack_contents = list(/obj/item/false_911_call_reporter = 1)

	id_trim = /datum/id_trim/space_police

/datum/antagonist/ert/request_911/police
	name = "Beat Cop"
	role = "Police Officer"
	department = "Police"
	outfit = /datum/outfit/request_911/police

/datum/outfit/request_911/police
	name = "911 Response: Police"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/security/officer/beatcop
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/spacepolice
	belt = /obj/item/gun/energy/disabler
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/black
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/melee/baton/security/loaded = 1,
	/obj/item/false_911_call_reporter = 1)

	id_trim = /datum/id_trim/space_police

/datum/antagonist/ert/request_911/fire
	name = "Firefighter"
	role = "Firefighter"
	department = "Fire"
	outfit = /datum/outfit/request_911/fire

/datum/outfit/request_911/fire
	name = "911 Response: Firefighter"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician
	shoes = /obj/item/clothing/shoes/sneakers/yellow
	ears = /obj/item/radio/headset/headset_eng
	head = /obj/item/clothing/head/hardhat/red
	suit = /obj/item/clothing/suit/fire/firefighter
	suit_store = /obj/item/tank/internals/oxygen/red
	mask = /obj/item/clothing/mask/gas
	id = /obj/item/card/id/advanced/black
	backpack_contents = list(/obj/item/extinguisher/advanced = 2,
	/obj/item/false_911_call_reporter = 1)

	id_trim = /datum/id_trim/space_police

/datum/antagonist/ert/request_911/emt
	name = "Emergency Medical Technician"
	role = "EMT"
	department = "EMT"
	outfit = /datum/outfit/request_911/emt

/datum/outfit/request_911/emt
	name = "911 Response: EMT"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	shoes = /obj/item/clothing/shoes/sneakers/white
	ears = /obj/item/radio/headset/headset_med
	head = /obj/item/clothing/head/soft/paramedic
	id = /obj/item/card/id/advanced/black
	suit =  /obj/item/clothing/suit/toggle/labcoat/paramedic
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/paramedic
	suit_store = /obj/item/flashlight/pen/paramedic
	backpack_contents = list(/obj/item/roller=1,
	/obj/item/storage/firstaid/medical = 1,
	/obj/item/false_911_call_reporter = 1)

	id_trim = /datum/id_trim/space_police

/datum/antagonist/ert/request_911/condom_destroyer
	name = "Armed S.W.A.T. Officer"
	role = "S.W.A.T. Officer"
	department = "Police"
	outfit = /datum/outfit/request_911/condom_destroyer

/datum/antagonist/ert/request_911/condom_destroyer/greet()
	var/missiondesc =  "<span class='warningplain'><B><font size=6 color=red>You are the [name].</font></B>"
	missiondesc += "<BR><B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to arrest [GLOB.caller_of_911] for making a faulty 911 call.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Arrest [GLOB.caller_of_911]."
	missiondesc += "<BR> <B>2.</B> Arrest anyone who interferes with you arresting [GLOB.caller_of_911]."
	missiondesc += "<BR> <B>3.</B> Use lethal force in the arrest of [GLOB.caller_of_911] if they will not comply."
	to_chat(owner,missiondesc)
	var/policy = get_policy(ROLE_FAMILIES)
	if(policy)
		to_chat(owner, policy)
	var/mob/living/M = owner.current
	M.playsound_local(M, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911/condom_destroyer
	name = "911 Response: Armed S.W.A.T. Officer"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/security/officer/beatcop
	shoes = /obj/item/clothing/shoes/jackboots
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/helmet/riot
	belt = /obj/item/gun/energy/disabler
	suit = /obj/item/clothing/suit/armor/riot
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/black
	l_hand = /obj/item/gun/ballistic/shotgun/riot
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/melee/baton/security/loaded = 1,
	/obj/item/storage/box/lethalshot = 2)

	id_trim = /datum/id_trim/space_police

/obj/item/false_911_call_reporter
	name = "False 911 Call Reporter"
	desc = "Use this in-hand to vote that the 911 call was faulty. If half of your team votes for it, the 911 call will be ruled faulty."
	icon = 'modular_skyrat/modules/goofsec/icons/reporter.dmi'
	icon_state = "reporter_off"
	var/activated = FALSE

/obj/item/false_911_call_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!GLOB.amt_911_responders)
		to_chat(user, "There's no 911 responders. Stop spawning shit that you don't know how to use.")
		return
	if(!activated && !GLOB.fradulent_911_declared)
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.votes_for_bad_911_call++
		to_chat(user, span_warning("You have reported the 911 call as fradulent. \
		Current Votes: [GLOB.votes_for_bad_911_call]/[GLOB.amt_911_responders] votes."))
		if(GLOB.votes_for_bad_911_call >= (GLOB.amt_911_responders / 2))
			to_chat(user, span_warning("The 911 call has been declared fradulent!"))
			GLOB.fradulent_911_declared = TRUE
			var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
			station_balance?._adjust_money(-20000) // paying for the gas to drive all the fuckin' way out to the frontier

			priority_announce("Hello, crewmembers of [station_name()]. Our emergency services have reported that you have made a fraudulent \
			911 call. Please note that the punishment for fraudulent 911 calls is a $20,000 fine and \
			a five year prison sentence. We have dispatched officers to arrest [GLOB.caller_of_911]. Do not interefere.", \
			"Sol Federation Fraud Department", 'sound/effects/families_police.ogg')
			var/list/candidates = poll_ghost_candidates("The station has made a faulty 911 call and [GLOB.caller_of_911] \
			is going to be arrested. Do you wish to punish them?", "deathsquad")

			if(candidates.len)
				//Pick the (un)lucky players
				var/numagents = min(4,candidates.len)

				var/list/spawnpoints = GLOB.emergencyresponseteamspawn
				var/index = 0
				while(numagents && candidates.len)
					var/spawnloc = spawnpoints[index+1]
					//loop through spawnpoints one at a time
					index = (index + 1) % spawnpoints.len
					var/mob/dead/observer/chosen_candidate = pick(candidates)
					candidates -= chosen_candidate
					if(!chosen_candidate.key)
						continue

					//Spawn the body
					var/mob/living/carbon/human/cop = new(spawnloc)
					chosen_candidate.client.prefs.safe_transfer_prefs_to(cop, is_antag = TRUE)
					cop.key = chosen_candidate.key

					//Give antag datum
					var/datum/antagonist/ert/request_911/ert_antag = new /datum/antagonist/ert/request_911/condom_destroyer

					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))
					SSjob.SendToLateJoin(cop)

					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					numagents--
