/datum/job/corrections_officer
	title = JOB_CORRECTIONS_OFFICER
	description = "Guard the permabrig, stand around looking imposing, get fired for abusing the prisoners"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Warden and Head of Security")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_HOS
	minimal_player_age = 7
	exp_requirements = 150
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "CORRECTIONS_OFFICER"

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	outfit = /datum/outfit/job/corrections_officer
	plasmaman_outfit = /datum/outfit/plasmaman/security
	display_order = JOB_DISPLAY_ORDER_CORRECTIONS_OFFICER
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)
	departments_list = list(
		/datum/job_department/security,
	)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/effect/spawner/random/contraband/prison = 5, //Gives them something fun to hold over the prisoners, or hide from them.
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)
	rpg_title = "Bailiff"
	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/security_cap, /obj/item/clothing/mask/whistle)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

// OUTFIT
/datum/outfit/job/corrections_officer
	name = "Corrections Officer"
	jobtype = /datum/job/corrections_officer
	uniform = /obj/item/clothing/under/rank/security/corrections_officer/sweater
	suit = /obj/item/clothing/suit/toggle/jacket/corrections_officer
	shoes = /obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/headset_sec
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(/obj/item/melee/baton/security/loaded/departmental/prison, /obj/item/restraints/handcuffs = 2, /obj/item/clothing/mask/whistle, /obj/item/gun/energy/disabler)
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	messenger = /obj/item/storage/backpack/messenger/sec
	head = /obj/item/clothing/head/security_garrison
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/modular_computer/pda/security

	id_trim = /datum/id_trim/job/corrections_officer



