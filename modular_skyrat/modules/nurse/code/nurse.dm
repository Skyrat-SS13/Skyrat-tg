/datum/job/nurse
	title = "Nurse"
	description = "Wear frilly dresses, fetch the MD a IV drip, STAT. Observe Surgery and take notes."
	department_head = list("Chief Medical Officer")
	faction = FACTION_STATION
	job_spawn_title = "Medical Doctor"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the chief medical officer"
	selection_color = "#ffeef0"
	exp_granted_type = EXP_TYPE_CREW

	department_for_prefs = /datum/job_department/medical

	outfit = /datum/outfit/job/nurse
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	liver_traits = list(TRAIT_MEDICAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_NURSE
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)

	family_heirlooms = list(/obj/item/storage/firstaid/ancient/heirloom)

	mail_goodies = list(
		/obj/item/healthanalyzer/advanced = 15,
		/obj/item/scalpel/advanced = 6,
		/obj/item/retractor/advanced = 6,
		/obj/item/cautery/advanced = 6,
		/obj/item/reagent_containers/glass/bottle/formaldehyde = 6,
		/obj/effect/spawner/random/medical/organs = 5,
		/obj/effect/spawner/random/medical/memeorgans = 1
	)
	rpg_title = "Cleric"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/nurse
	name = "Nurse"
	jobtype = /datum/job/nurse

	id_trim = /datum/id_trim/job/nurse
	uniform = /obj/item/clothing/under/rank/medical/doctor/blue
	belt = /obj/item/pda/medical
	neck = /obj/item/clothing/neck/stethoscope
	ears = /obj/item/radio/headset/headset_med
	shoes = /obj/item/clothing/shoes/sneakers/white
	l_hand = /obj/item/storage/firstaid/medical
	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med

	box = /obj/item/storage/box/survival/medical
	chameleon_extras = /obj/item/gun/syringe
	skillchips = list(/obj/item/skillchip/entrails_reader)

/obj/effect/landmark/start/nurse
	name = "Nurse"
	icon_state = "Medical Doctor"
