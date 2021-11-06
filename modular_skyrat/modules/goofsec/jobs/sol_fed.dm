GLOBAL_VAR_INIT(amt_911_responders, 0)
GLOBAL_VAR_INIT(votes_for_bad_911_call, 0)
GLOBAL_VAR_INIT(amt_SWAT_responders, 0)
GLOBAL_VAR_INIT(votes_for_treason, 0)
GLOBAL_VAR_INIT(fradulent_911_declared, FALSE)
GLOBAL_VAR_INIT(treason_declared, FALSE)
GLOBAL_VAR(caller_of_911)
GLOBAL_VAR(call_911_msg)
GLOBAL_LIST_INIT(emergency_responders, list())
/datum/antagonist/ert/request_911
	name = "911 Responder"
	antag_hud_type = ANTAG_HUD_SPACECOP
	antag_hud_name = "hud_spacecop"
	suicide_cry = "FOR THE SOL FEDERATION!!"
	var/department = "Some stupid shit"

/datum/antagonist/ert/request_911/apply_innate_effects(mob/living/mob_override)
	..()
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(antag_hud_type, antag_hud_name, M)
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		var/atom/movable/screen/wanted/giving_wanted_lvl = new /atom/movable/screen/wanted()
		H.wanted_lvl = giving_wanted_lvl
		giving_wanted_lvl.hud = H
		H.infodisplay += giving_wanted_lvl
		H.mymob.client.screen += giving_wanted_lvl


/datum/antagonist/ert/request_911/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(antag_hud_type, M)
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		H.infodisplay -= H.wanted_lvl
		QDEL_NULL(H.wanted_lvl)
	..()

/datum/antagonist/ert/request_911/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station for immediate SolFed [department] assistance!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow first responders!\n"
	missiondesc += "<BR><B>911 Transcript is as follows</B>:"
	missiondesc += "<BR> [GLOB.call_911_msg]"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact [GLOB.caller_of_911] and assist them in resolving the matter."
	missiondesc += "<BR> <B>2.</B> Protect, ensure, and uphold the rights of Sol Federation citizens on board [station_name()]."
	missiondesc += "<BR> <B>3.</B> If the 911 call was made in error, for poor reasons, or with known malice, use the False 911 Call Reporter in \
	your backpack to vote that the 911 call was false. This will immediately fine the crew and issue a SWAT Response to arrest those responsible. \
	Coordinate with this SWAT team to ensure they arrest the correct people."
	missiondesc += "<BR> <B>4.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
	along with anyone you are pulling."
	to_chat(owner,missiondesc)
	var/policy = get_policy(ROLE_FAMILIES)
	if(policy)
		to_chat(owner, policy)
	var/mob/living/M = owner.current
	M.playsound_local(M, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911
	name = "911 Response: Base"
	back = /obj/item/storage/backpack/duffelbag/cops
	backpack_contents = list(/obj/item/false_911_call_reporter = 1)

	id_trim = /datum/id_trim/space_police

/datum/outfit/request_911/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/C = H.wear_id
	if(istype(C))
		shuffle_inplace(C.access) // Shuffle access list to make NTNet passkeys less predictable
		C.registered_name = H.real_name
		if(H.age)
			C.registered_age = H.age
		C.update_label()
		C.update_icon()
		var/datum/bank_account/B = SSeconomy.bank_accounts_by_id["[H.account_id]"]
		if(B && B.account_id == H.account_id)
			C.registered_account = B
			B.bank_cards += C
		H.sec_hud_set_ID()

/datum/antagonist/ert/request_911/police
	name = "Marshal"
	role = "Marshal"
	department = "Marshal"
	outfit = /datum/outfit/request_911/police

/datum/outfit/request_911/police
	name = "911 Response: Marshal"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/security/detective/cowboy
	shoes = /obj/item/clothing/shoes/cowboy
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/hunter
	belt = /obj/item/gun/energy/disabler
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solgov
	backpack_contents = list(/obj/item/storage/box/survival = 1,
	/obj/item/storage/box/handcuffs = 1,
	/obj/item/melee/baton/security/loaded = 1,
	/obj/item/false_911_call_reporter = 1,
	/obj/item/beamout_tool = 1)

	id_trim = /datum/id_trim/solgov

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
	id = /obj/item/card/id/advanced/solgov
	backpack_contents = list(/obj/item/storage/box/survival = 1,
	/obj/item/extinguisher = 2,
	/obj/item/false_911_call_reporter = 1,
	/obj/item/beamout_tool = 1)

	id_trim = /datum/id_trim/solgov

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
	id = /obj/item/card/id/advanced/solgov
	suit =  /obj/item/clothing/suit/toggle/labcoat/paramedic
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	belt = /obj/item/storage/belt/medical/paramedic
	suit_store = /obj/item/flashlight/pen/paramedic
	backpack_contents = list(/obj/item/storage/box/survival = 1,
	/obj/item/roller=1,
	/obj/item/storage/firstaid/medical = 1,
	/obj/item/false_911_call_reporter = 1,
	/obj/item/beamout_tool = 1)

	id_trim = /datum/id_trim/solgov

/datum/antagonist/ert/request_911/condom_destroyer
	name = "Armed S.W.A.T. Officer"
	role = "S.W.A.T. Officer"
	department = "Police"
	outfit = /datum/outfit/request_911/condom_destroyer

/datum/antagonist/ert/request_911/condom_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to arrest the responsible individuals for making a faulty 911 call.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the first responders using the Cell Phone in your backpack to identify the suspects."
	missiondesc += "<BR> <B>2.</B> Arrest anyone who interferes with your arrest of the suspects."
	missiondesc += "<BR> <B>3.</B> Use lethal force in the arrest of the suspects if they will not comply, or the station refuses to comply."
	missiondesc += "<BR> <B>4.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
	along with anyone you are pulling."
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
	id = /obj/item/card/id/advanced/solgov
	l_hand = /obj/item/gun/ballistic/shotgun/riot
	backpack_contents = list(/obj/item/storage/box/survival = 1,
	/obj/item/storage/box/handcuffs = 1,
	/obj/item/melee/baton/security/loaded = 1,
	/obj/item/storage/box/lethalshot = 2,
	/obj/item/treason_reporter = 1,
	/obj/item/beamout_tool = 1)

	id_trim = /datum/id_trim/solgov

/datum/antagonist/ert/request_911/treason_destroyer
	name = "Sol Federation Military"
	role = "Private"
	department = "Military"
	outfit = /datum/outfit/request_911/treason_destroyer

/datum/antagonist/ert/request_911/treason_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to assume control of [station_name()] due to the occupants engaging in Treason as reported by our SWAT team.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the SWAT Team and the First Responders via your cell phone to get the situation from them."
	missiondesc += "<BR> <B>2.</B> Arrest all suspects involved in the treason attempt."
	missiondesc += "<BR> <B>3.</B> Assume control of the station for the Sol Federation, and initiate evacuation procedures to get non-offending citizens \
	away from the scene."
	missiondesc += "<BR> <B>4.</B> Lethal force is authorized at all times."
	to_chat(owner,missiondesc)
	var/policy = get_policy(ROLE_FAMILIES)
	if(policy)
		to_chat(owner, policy)
	var/mob/living/M = owner.current
	M.playsound_local(M, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/outfit/request_911/treason_destroyer
	name = "911 Response: SolFed Military"

	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	head = /obj/item/clothing/head/helmet
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat

	back = /obj/item/storage/backpack/duffelbag/cops
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solgov
	r_hand = /obj/item/gun/ballistic/automatic/assault_rifle/m16
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
	/obj/item/melee/baton/security/loaded = 1,
	/obj/item/ammo_box/magazine/m16 = 4)

	id_trim = /datum/id_trim/solgov

/obj/item/false_911_call_reporter
	name = "False 911 Call Reporter"
	desc = "Use this in-hand to vote that the 911 call was faulty. If your entire team votes for it, the 911 call will be ruled faulty."
	icon = 'modular_skyrat/modules/goofsec/reporter.dmi'
	icon_state = "reporter_off"
	var/activated = FALSE

/obj/item/false_911_call_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!GLOB.amt_911_responders)
		to_chat(user, "There's no 911 responders. Stop spawning shit that you don't know how to use.")
		return
	if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911))
		to_chat(user, "You are not a 911 responder. You cannot vote for a false call.")
		return

	if(!activated && !GLOB.fradulent_911_declared)
		if(tgui_input_list(user, "Did the station make a fraudulent 911 call?", "Fraudulent 911 Call Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to declare the station as having made a false 911 call.")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)] has voted that the station made a fraudulent 911 call.")
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.votes_for_bad_911_call++
		to_chat(user, span_warning("You have reported the 911 call as fradulent. \
		Current Votes: [GLOB.votes_for_bad_911_call]/[GLOB.amt_911_responders] votes."))
		if(GLOB.votes_for_bad_911_call >= GLOB.amt_911_responders)
			to_chat(user, span_warning("The 911 call has been declared fradulent!"))
			GLOB.fradulent_911_declared = TRUE
			var/datum/bank_account/station_balance = SSeconomy.get_dep_account(ACCOUNT_CAR)
			station_balance?._adjust_money(-20000) // paying for the gas to drive all the fuckin' way out to the frontier

			priority_announce("Hello, crewmembers of [station_name()]. Our emergency services have reported that you have made a fraudulent \
			911 call. Please note that the punishment for fraudulent 911 calls is a $20,000 fine and \
			a five year prison sentence. We have dispatched officers to arrest those responsible. Do not interefere.", \
			"Sol Federation Fraud Department", 'sound/effects/families_police.ogg', has_important_message=TRUE)
			var/list/candidates = poll_ghost_candidates("The station has made a faulty 911 call and those responsible \
			are going to be arrested. Do you wish to punish them?", "deathsquad")

			if(candidates.len)
				//Pick the (un)lucky players
				var/numagents = min(4,candidates.len)
				GLOB.amt_SWAT_responders = numagents

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

					var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
					phone.gang_id = "911"
					phone.name = "911 branded cell phone"
					var/phone_equipped = phone.equip_to_best_slot(cop)
					if(!phone_equipped)
						to_chat(cop, "Your [phone.name] has been placed at your feet.")
						phone.forceMove(get_turf(cop))

					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					numagents--

/obj/item/treason_reporter
	name = "Treason Reporter"
	desc = "Use this in-hand to vote that the station is engaging in Treason. If your entire team votes for it, the Military will handle the situation."
	icon = 'modular_skyrat/modules/goofsec/reporter.dmi'
	icon_state = "reporter_off"
	var/activated = FALSE

/obj/item/treason_reporter/attack_self(mob/user, modifiers)
	. = ..()
	if(!GLOB.amt_SWAT_responders)
		to_chat(user, "There's no SWAT responders. Stop spawning shit that you don't know how to use.")
		return
	if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911/condom_destroyer))
		to_chat(user, "You are not a SWAT. You cannot vote to declare the station as having committed Treason.")
		return

	if(!activated && !GLOB.treason_declared)
		if(tgui_input_list(user, "Do you know what Treason is?", "Treason Reporter", list("Yes", "No")) != "Yes")
			if(tgui_input_list(user, "Treason is the crime of attacking a state authority to which one owes allegiance. Did the station engage in this today?", "Treason", list("Yes", "No")) != "Yes")
				to_chat(user, "You decide not to declare the station as treasonous.")
				return
		message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged that they know what treason means.")
		if(tgui_input_list(user, "Did station crewmembers assault you or the SWAT team at the direction of Security and/or Command?", "Treason Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to declare the station as treasonous.")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)] has claimed that the crewmembers assaulted them or the SWAT team at the direction of Security and/or Command.")
		if(tgui_input_list(user, "Did station crewmembers actively prevent you and the SWAT team from accomplishing your objectives at the direction of Security and/or Command?", "Treason Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to declare the station as treasonous.")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)] has claimed that the crewmembers prevented them or the SWAT team from accomplishing their objectives at the direction of Security and/or Command.")
		if(tgui_input_list(user, "Were you and your fellow SWAT members unable to handle the issue on your own?", "Treason Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to declare the station as treasonous.")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)] has claimed that the SWAT team was unable to handle the issue on their own.")
		if(tgui_input_list(user, "Are you absolutely sure you wish to declare the station as engaging in Treason? Misuse of this can and will result in \
		administrative action against your account.", "Treason Reporter", list("Yes", "No")) != "Yes")
			to_chat(user, "You decide not to declare the station as treasonous.")
			return
		message_admins("[ADMIN_LOOKUPFLW(user)] has acknowledged the consequences of a false claim of Treason administratively, and has voted that the station is engaging in Treason.")
		activated = TRUE
		icon_state = "reporter_on"
		GLOB.votes_for_treason++
		to_chat(user, span_warning("You have reported the station as participating in Treason. \
		Current Votes: [GLOB.votes_for_treason]/[GLOB.amt_SWAT_responders] votes."))
		if(GLOB.votes_for_treason >= GLOB.amt_SWAT_responders)
			to_chat(user, span_warning("The station has been declared as engaging in Treason!"))
			GLOB.treason_declared = TRUE

			priority_announce("Crewmembers of [station_name()].\n\
			You have refused to comply with first responders and SWAT officers, and have assaulted them, and they are unable to \
			carry out the wills of the Sol Federation, despite residing within Sol Federation borders.\n\
			As such, we are charging those responsible with Treason. The penalty of which is death, or no less than twenty-five years in Superjail.\n\
			Treason is a serious crime. Our military forces are en route to your station. They will be assuming direct control of the station, and \
			will be evacuating civilians from the scene.\n\
			Comply, or be shot.\n\
			Non-offending citizens, prepare for evacuation. Comply with all orders given to you by Sol Federation military personnel.\n\
			To all those who are engaging in treason, lay down your weapons and surrender. Lethal force has been authorized if you do not comply.\n\
			Have a secure day.", \
			"Sol Federation Military", 'sound/effects/families_police.ogg', has_important_message=TRUE)
			var/list/candidates = poll_ghost_candidates("The station has decided to engage in treason. Do you wish to join the Sol Federation Military?", "deathsquad")

			if(candidates.len)
				//Pick the (un)lucky players
				var/numagents = min(12,candidates.len)

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
					var/datum/antagonist/ert/request_911/ert_antag = new /datum/antagonist/ert/request_911/treason_destroyer

					cop.mind.add_antag_datum(ert_antag)
					cop.mind.set_assigned_role(SSjob.GetJobType(ert_antag.ert_job_path))
					SSjob.SendToLateJoin(cop)

					var/obj/item/gangster_cellphone/phone = new() // biggest gang in the city
					phone.gang_id = "911"
					phone.name = "911 branded cell phone"
					var/phone_equipped = phone.equip_to_best_slot(cop)
					if(!phone_equipped)
						to_chat(cop, "Your [phone.name] has been placed at your feet.")
						phone.forceMove(get_turf(cop))

					//Logging and cleanup
					log_game("[key_name(cop)] has been selected as an [ert_antag.name]")
					numagents--

/obj/item/beamout_tool
	name = "Beamout Tool" // TODO, find a way to make this into drop pods cuz that's cooler visually
	desc = "Use this to begin the lengthy beamout process to return to Sol Federation space. It will bring anyone you are pulling with you."
	icon = 'modular_skyrat/modules/goofsec/reporter.dmi'
	icon_state = "beam_me_up_scotty"

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert/request_911))
		to_chat(user, "You don't understand how to use this device.")
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beamout using their beamout tool.")
	to_chat(user, "You have begun the beamout process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beamout")
	if(do_after(user, 30 SECONDS))
		to_chat(user,"You have completed the beamout process and are returning to the Sol Federation.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, pulling_turf)
				sparks.attach(pulling_turf)
				sparks.start()
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, user_turf)
			sparks.attach(user_turf)
			sparks.start()
			qdel(user)
	else
		user.balloon_alert(user, "beamout cancelled")
