/datum/job/junior_officer
	title = "Civil Disputes Officer"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of security, security sergeants and security officers"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 120
	exp_type = EXP_TYPE_MEDICAL


	outfit = /datum/outfit/job/junior_officer

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_JUNIOR_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

/datum/outfit/job/junior_officer
	name = "Civil Disputes Officer"
	jobtype = /datum/job/junior_officer

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/junior
	shoes = /obj/item/clothing/shoes/sneakers/black
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper
	head = /obj/item/clothing/head/soft/black/junior_officer

	suit = /obj/item/clothing/suit/toggle/labcoat/junior_officer

	backpack_contents = list(/obj/item/melee/classic_baton/peacekeeper, /obj/item/storage/box/gunset/pepperball, /obj/item/restraints/handcuffs/cable=2, /obj/item/storage/belt/security/peacekeeper)

	l_pocket = /obj/item/flashlight

	r_pocket = /obj/item/assembly/flash/handheld

	backpack = /obj/item/storage/backpack/security/peacekeeper
	satchel = /obj/item/storage/backpack/satchel/sec/peacekeeper
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/peacekeeper

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/junior_officer

/datum/outfit/job/junior_officer/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(prob(1)) //HURR DURR I BATONG SELF
		ADD_TRAIT(H, TRAIT_CLUMSY, ROUNDSTART_TRAIT)

/obj/effect/landmark/start/junior_officer
	name = "Civil Disputes Officer"
	icon_state = "Security Officer"
