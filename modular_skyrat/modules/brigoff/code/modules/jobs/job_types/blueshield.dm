/datum/job/brigoff
	title = "Brig Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Warden and Head of Security")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Warden and Head of Security"
	selection_color = "#ddddff"
	minimal_player_age = 7
	exp_requirements = 150
	exp_type = EXP_TYPE_CREW

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	outfit = /datum/outfit/job/brigoff
	display_order = JOB_DISPLAY_ORDER_BRIGOFF
	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

/datum/outfit/job/brigoff
	name = "Brig Officer"
	jobtype = /datum/job/brigoff
	uniform = /obj/item/clothing/under/rank/security/brigguard
	suit = /obj/item/clothing/suit/toggle/jacket/brigoff
	shoes = /obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/headset_sec
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(/obj/item/melee/classic_baton/peacekeeper, /obj/item/restraints/handcuffs = 2)
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/security/peacekeeper
	satchel = /obj/item/storage/backpack/satchel/sec/peacekeeper
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/peacekeeper
	head = /obj/item/clothing/head/brigoff
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/pda/security

	id_trim = /datum/id_trim/job/brigoff



