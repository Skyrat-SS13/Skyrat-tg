/datum/job/warden
	title = "Warden"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/warden
	plasmaman_outfit = /datum/outfit/plasmaman/warden

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_WARDEN
	bounty_types = CIV_JOB_SEC
	departments = DEPARTMENT_SECURITY

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law)

/datum/outfit/job/warden
	name = "Warden"
	jobtype = /datum/job/warden

	belt = /obj/item/pda/warden
	ears = /obj/item/radio/headset/headset_sec/alt
	uniform = /obj/item/clothing/under/rank/security/warden/peacekeeper //SKYRAT EDIT CHANGE - SEC_HAUL - ORIGINAL: /obj/item/clothing/under/rank/security/warden
	shoes = /obj/item/clothing/shoes/combat/peacekeeper //SKYRAT EDIT CHANGE - SEC_HAUL
	suit = /obj/item/clothing/suit/armor/vest/warden/peacekeeper //SKYRAT EDIT CHANGE - SEC_HAUL - ORIGINAL: /obj/item/clothing/suit/armor/vest/warden/alt
	gloves = /obj/item/clothing/gloves/combat/peacekeeper //SKYRAT EDIT CHANGE - SEC_HAUL - ORIGINAL: gloves = /obj/item/clothing/gloves/color/black
	head = /obj/item/clothing/head/beret/sec/navywarden/peacekeeper //SKYRAT EDIT CHANGE - SEC_HAUL - ORIGINAL: /obj/item/clothing/head/warden
	glasses = /obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper //SKYRAT EDIT CHANGE - SEC_HAUL - ORIGINAL: /obj/item/clothing/glasses/hud/security/sunglasses
	r_pocket = /obj/item/assembly/flash/handheld
	l_pocket = /obj/item/restraints/handcuffs
	//suit_store = /obj/item/gun/energy/disabler //SKYRAT EDIT REMOVAL - SEC_HAUL
	backpack_contents = list(/obj/item/melee/classic_baton/peacekeeper, /obj/item/clothing/head/beret/sec/peacekeeper, /obj/item/armament_token/sidearm) //SKRYAT EDIT CHANGE - SEC_HAUL - ORIGINAL: backpack_contents = list(/obj/item/melee/baton/loaded=1)

	backpack = /obj/item/storage/backpack/security/peacekeeper //SKYRAT EDIT CHANGE - SEC_HAUL - ORIGINAL: backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec/peacekeeper
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/peacekeeper
	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/warden
