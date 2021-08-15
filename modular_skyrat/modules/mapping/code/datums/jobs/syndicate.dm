/datum/job/skyratghostrole/syndicate
	paycheck_department = ACCOUNT_INT //Interdyne is the most prominent syndicate ghostrole.

//OPERATVIES / ASSISTANTS//
/datum/job/skyratghostrole/syndicate/operative
	title = "Operative"
	total_positions = 5
	supervisors = "absolutely everyone"
	outfit = /datum/outfit/job/assistant
	plasmaman_outfit = /datum/outfit/plasmaman //TEMP
	paycheck = PAYCHECK_ASSISTANT
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	liver_traits = list(TRAIT_GREYTIDE_METABOLISM)

	family_heirlooms = list(/obj/item/storage/toolbox/mechanical/old/heirloom, /obj/item/clothing/gloves/cut/heirloom)

/datum/outfit/job/skyratghostrole/syndicate/operative //This is intended both as the operative outfit and as a base for all others.
	name = "DS-2 Operative"
	jobtype = /datum/job/skyratghostrole/syndicate/operative
	id_trim = /datum/id_trim/syndicom/skyrat/assault/assistant
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	ears = /obj/item/radio/headset/interdyne
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/black
	implants = list(/obj/item/implant/weapons_auth) //TO-DO - When the access update rolls out, strip these out to be the mindshield equivalent

/datum/outfit/job/skyratghostrole/syndicate/operative/post_equip(mob/living/carbon/human/H) //Sets them as part of the syndicate faction so turrets don't nuke them
	H.faction |= ROLE_SYNDICATE.

//BOTANISTS / CHEFS / SERVICE STAFF//
// Technically these have dedicated equivalents too, but rolling them into one role helps considering how far apart they are and is totally not at all a lazy holdover from DS-1 :)

/datum/job/skyratghostrole/syndicate/service
	title = "Service Staff"
	total_positions = 4
	supervisors = "the corporate liaison"
	outfit = /datum/outfit/job/skyratghostrole/syndicate/operative/service
	plasmaman_outfit = /datum/outfit/plasmaman/chef //TEMP
	paycheck = PAYCHECK_EASY
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	liver_traits = list(TRAIT_CULINARY_METABOLISM)

	family_heirlooms = list(/obj/item/reagent_containers/food/condiment/saltshaker, /obj/item/kitchen/rollingpin, /obj/item/clothing/head/chefhat)

/datum/outfit/job/skyratghostrole/syndicate/operative/service
	name = "DS-2 Staff"
	uniform = /obj/item/clothing/under/utility/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/syndicatestaff

//ENGINE TECHNICIANS / STATION ENGINEERS//
/datum/job/skyratghostrole/syndicate/enginetech
	title = "Engine Technician"
	faction = FACTION_STATION
	total_positions = 5
	supervisors = "the chief engineering officer"
	outfit = /datum/outfit/job/skyratghostrole/syndicate/operative/enginetech
	plasmaman_outfit = /datum/outfit/plasmaman/engineering //TEMP
	paycheck = PAYCHECK_MEDIUM
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	liver_traits = list(TRAIT_ENGINEER_METABOLISM)

	family_heirlooms = list(/obj/item/clothing/head/hardhat, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)

/datum/outfit/job/skyratghostrole/syndicate/operative/enginetech
	name = "DS-2 Engine Technician"
	uniform = /obj/item/clothing/under/utility/eng/syndicate
	id_trim = /datum/id_trim/syndicom/skyratnoicon/enginetechnician
	gloves = /obj/item/clothing/gloves/combat

//Researchers / Scientists//
/datum/job/skyratghostrole/syndicate/researcher
	title = "Researcher"
	total_positions = 5
	supervisors = "the chief research officer"
	outfit = /datum/outfit/job/skyratghostrole/syndicate/operative/researcher
	plasmaman_outfit = /datum/outfit/plasmaman/science //TEMP
	paycheck = PAYCHECK_MEDIUM
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	family_heirlooms = list(/obj/item/toy/plush/slimeplushie)

/datum/outfit/job/skyratghostrole/syndicate/operative/researcher
	name = "DS-2 Researcher"
	uniform = /obj/item/clothing/under/utility/sci/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/researcher

//Medical Officers/Medical Doctors//
/datum/job/skyratghostrole/syndicate/medicalofficer
	title = "Medical Officer"
	total_positions = 5
	supervisors = "the chief medical officer"
	outfit = /datum/outfit/job/skyratghostrole/syndicate/operative/stationmed
	plasmaman_outfit = /datum/outfit/plasmaman/medical //TEMP
	paycheck = PAYCHECK_MEDIUM
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	liver_traits = list(TRAIT_MEDICAL_METABOLISM)

	family_heirlooms = list(/obj/item/storage/firstaid/ancient/heirloom)

/datum/outfit/job/skyratghostrole/syndicate/operative/stationmed
	name = "DS-2 Station Medical Officer"
	uniform = /obj/item/clothing/under/utility/med/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationmedicalofficer

//Master At Arms/Warden//
/datum/job/skyratghostrole/syndicate/masteratarms
	title = "Master At Arms"
	total_positions = 1
	supervisors = "the chief master at arms"
	outfit = /datum/outfit/job/warden
	plasmaman_outfit = /datum/outfit/plasmaman/warden //TEMP
	paycheck = PAYCHECK_HARD
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)

/datum/outfit/job/skyratghostrole/syndicate/operative/masteratarms
	name = "DS-2 Master At Arms"
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/masteratarms
	belt = /obj/item/storage/belt/security/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/vest/warden/syndicate
	head = /obj/item/clothing/head/sec/navywarden/syndicate
	ears = /obj/item/radio/headset/headset_sec/alt/interdyne

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)

//Brigoff/Secoff//
/datum/job/skyratghostrole/syndicate/brig_officer
	title = "Enforcement Officer"
	total_positions = 5
	supervisors = "the chief master at arms"
	outfit = /datum/outfit/job/security
	plasmaman_outfit = /datum/outfit/plasmaman/security //TEMP
	paycheck = PAYCHECK_HARD
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

/datum/outfit/job/skyratghostrole/syndicate/operative/brigoff
	name = "DS-2 Brig Officer"
	uniform = /obj/item/clothing/under/utility/sec/old/syndicate
	id_trim = /datum/id_trim/syndicom/skyrat/assault/brigofficer
	belt = /obj/item/storage/belt/security/full
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	suit = /obj/item/clothing/suit/armor/bulletproof
	head = /obj/item/clothing/head/helmet/swat
	ears = /obj/item/radio/headset/headset_sec/alt/interdyne

	backpack_contents = list(
		/obj/item/storage/box/handcuffs,\
		/obj/item/melee/baton/loaded
	)

//Station Admiral/Captain//
/datum/job/skyratghostrole/syndicate/station_admiral
	title = "Station Admiral"
	total_positions = 1
	supervisors = "Your benefactors and space law"
	req_admin_notify = 1
	outfit = /datum/outfit/job/captain
	plasmaman_outfit = /datum/outfit/plasmaman/captain //TEMP
	paycheck = PAYCHECK_COMMAND
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	liver_traits = list(TRAIT_ROYAL_METABOLISM)
	departments_list = list(/datum/job_department/syndicate)

	family_heirlooms = list(/obj/item/reagent_containers/food/drinks/flask/gold)

	voice_of_god_power = 1.4 //Command staff has authority

/datum/outfit/job/skyratghostrole/syndicate/operative/admiral
	name = "DS-2 Station Admiral"
	uniform = /obj/item/clothing/under/utility/com/syndicate
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	head = /obj/item/clothing/head/hos/beret/syndicate
	back = /obj/item/storage/backpack
	id = /obj/item/card/id/advanced/gold/generic
	backpack_contents = list(/obj/item/gun/ballistic/automatic/pistol/aps)
	id_trim = /datum/id_trim/syndicom/skyrat/assault/stationadmiral
	ears = /obj/item/radio/headset/interdyne/command

//Prisoners, AKA How I extended griff to ghostroles//
/datum/job/skyratghostrole/syndicate/prisoner
	title = "Charge"
	total_positions = 12 //Oh dear god why
	supervisors = "the security team"
	paycheck = PAYCHECK_PRISONER
	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS
	departments_list = list(/datum/job_department/syndicate)

	outfit = /datum/outfit/job/prisoner
	plasmaman_outfit = /datum/outfit/plasmaman/prisoner


	family_heirlooms = list(/obj/item/pen/blue)

/datum/job/skyratghostrole/syndicate/prisoner/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	to_chat(M, "<span class='userdanger'>You <b><u>MUST</b></u> ahelp before attempting breakouts or rioting. Being a shitter = perma prisoner job-ban.")
	to_chat(M, "<span class='warning'>Being a shitter includes but is not limited to: Critting other prisoners, constantly breaking things, and occupying too much of security's time as a result. <b>Remember: You aren't an antagonist.</b>")
	to_chat(M, "<b>You are a prisoner being held in IP-DS-2, awaiting transfer to a secure prison facility or to the courthouse to stand trial.</b>")
	to_chat(M, "It's up to you to decide why you're in here. Chances are, the case against you might not be strong enough to convict you. Or is it?<br>")

//LANDMARK SHITCODE AHEAD//
/obj/effect/landmark/start/syndoperative
	name = "Operative"
	icon_state = "Assistant"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/syndprisoner
	name = "Charge"
	icon_state = "Prisoner"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/syndicateadmiral
	name = "Station Admiral"
	icon_state = "Captain"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/syndicatesecoff
	name = "Enforcement Officer"
	icon_state = "Security Officer"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/syndmasteratarms
	name = "Master At Arms"
	icon_state = "Warden"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/syndmedicalofficer
	name = "Medical Officer" //Literally 1984
	icon_state = "Medical Doctor"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/syndresearcher
	name = "Researcher"
	icon_state = "Scientist"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/enginetechnician
	name = "Engine Technician"
	icon_state = "Station Engineer"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE

/obj/effect/landmark/start/syndicatestaff
	name = "Syndicate Staff"
	icon_state = "Chef"
	jobspawn_override = TRUE
	delete_after_roundstart = FALSE
