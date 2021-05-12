/datum/job/security_medic
	title = "Security Medic"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Head of Security")
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security and any security sergeants"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 120
	exp_type = EXP_TYPE_MEDICAL

	outfit = /datum/outfit/job/security_medic
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_MEDIC
	bounty_types = CIV_JOB_SEC

	family_heirlooms = list(/obj/item/clothing/neck/stethoscope, /obj/item/roller, /obj/item/book/manual/wiki/security_space_law)


/datum/outfit/job/security_medic
	name = "Security Medic"
	jobtype = /datum/job/security_medic

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/headset_medsec
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/security_medic
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	shoes = /obj/item/clothing/shoes/combat/peacekeeper
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	l_hand = /obj/item/storage/firstaid/brute
	head = /obj/item/clothing/head/beret/sec/peacekeeper/security_medic

	backpack_contents = list(/obj/item/melee/classic_baton/telescopic, /obj/item/storage/box/gunset/security_medic)

	backpack = /obj/item/storage/backpack/security/peacekeeper
	satchel = /obj/item/storage/backpack/satchel/sec/peacekeeper
	duffelbag = /obj/item/storage/backpack/duffelbag/sec/peacekeeper

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/security_medic

/obj/effect/landmark/start/security_medic
	name = "Security Medic"
	icon_state = "Security Officer"

/obj/item/encryptionkey/headset_medsec
	name = "medical-security encryption key"
	icon_state = "sec_cypherkey"
	channels = list(RADIO_CHANNEL_MEDICAL = 1, RADIO_CHANNEL_SECURITY = 1)

/obj/item/radio/headset/headset_medsec
	name = "medical-security radio headset"
	desc = "Used to hear how many security officers need to be stiched back together."
	icon_state = "sec_headset"
	keyslot = new /obj/item/encryptionkey/headset_medsec

/obj/structure/closet/secure_closet/security_medic
	name = "security medics's locker"
	req_access = list(ACCESS_SECURITY)
	icon = 'modular_skyrat/modules/sec_haul/icons/lockers/closet.dmi'
	icon_state = "secmed"

/obj/structure/closet/secure_closet/security_medic/PopulateContents()
	..()
	new /obj/item/clothing/suit/toggle/labcoat/security_medic(src)
	new /obj/item/clothing/suit/hazardvest/security_medic(src)
	new /obj/item/clothing/head/helmet/sec/peacekeeper/security_medic(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/tactical(src)
	new /obj/item/radio/headset/headset_medsec(src)
	new /obj/item/storage/firstaid/emergency(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/storage/belt/security/peacekeeper/full(src)
	new /obj/item/clothing/under/rank/medical/doctor/red(src)
