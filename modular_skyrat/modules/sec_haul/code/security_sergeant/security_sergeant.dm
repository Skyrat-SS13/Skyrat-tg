/datum/job/security_sergeant
	title = "Security Sergeant"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of security"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 120
	exp_type = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/security_sergeant
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_SERGEANT
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

/datum/outfit/job/security_sergeant
	name = "Security Sergeant"
	jobtype = /datum/job/security_sergeant

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/sergeant
	gloves = /obj/item/clothing/gloves/combat/peacekeeper
	shoes = /obj/item/clothing/shoes/combat/peacekeeper
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/black
	head = /obj/item/clothing/head/beret/sec/peacekeeper/sergeant

	backpack_contents = list(/obj/item/melee/classic_baton/telescopic, /obj/item/armament_token/sidearm, /obj/item/armament_token/primary)

	backpack = /obj/item/storage/backpack/security/peacekeeper
	satchel = /obj/item/storage/backpack/satchel/sec/peacekeeper
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/peacekeeper

	l_pocket = /obj/item/megaphone/sec

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/security_sergeant

/obj/effect/landmark/start/security_sergeant
	name = "Security Sergeant"
	icon_state = "Security Officer"
