/datum/job/security_medic
	title = JOB_SECURITY_MEDIC
	description = "Patch up officers and prisoners, realize you don't have the tools to Tend Wounds, barge into Medbay and tell them how to do their jobs"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list(JOB_HEAD_OF_SECURITY)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the head of security and any security sergeants"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 120
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SECURITY
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/security_medic
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SECURITY_MEDIC
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
		/datum/job_department/medical,
	)

	family_heirlooms = list(/obj/item/clothing/neck/stethoscope, /obj/item/book/manual/wiki/security_space_law)

	//This is the paramedic goodie list. Secmedics are paramedics more or less so they can use these instead of raiding medbay.
	mail_goodies = list(
		/obj/item/reagent_containers/hypospray/medipen = 20,
		/obj/item/reagent_containers/hypospray/medipen/oxandrolone = 10,
		/obj/item/reagent_containers/hypospray/medipen/salacid = 10,
		/obj/item/reagent_containers/hypospray/medipen/salbutamol = 10,
		/obj/item/reagent_containers/hypospray/medipen/penacid = 10,
		/obj/item/reagent_containers/hypospray/medipen/survival/luxury = 5
	)
	rpg_title = "Battle Cleric"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/job/security_medic/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	to_chat(M, span_redtext("As the Security Medic, you are comparable in medical knowledge to a Paramedic, not a one man surgical bay. \
	your main duty is healing on the field or in combat situations. Leave revivals and chemistry work to trained professionals."))

/datum/outfit/job/security_medic
	name = "Security Medic"
	jobtype = /datum/job/security_medic

	belt = /obj/item/modular_computer/tablet/pda/security
	ears = /obj/item/radio/headset/headset_medsec
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/security_medic
	gloves = /obj/item/clothing/gloves/color/latex/nitrile
	shoes = /obj/item/clothing/shoes/jackboots/security
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses
	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	l_hand = /obj/item/storage/medkit/brute
	head = /obj/item/clothing/head/beret/sec/peacekeeper/security_medic
	backpack_contents = list(/obj/item/storage/box/gunset/firefly = 1)
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/security_medic

/obj/effect/landmark/start/security_medic
	name = "Security Medic"
	icon_state = "Security Medic"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

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
	new /obj/item/clothing/suit/toggle/labcoat/security_medic/blue(src)
	new /obj/item/clothing/suit/hazardvest/security_medic/blue(src)
	new /obj/item/clothing/head/helmet/sec/peacekeeper/security_medic(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/tactical(src)
	new /obj/item/radio/headset/headset_medsec(src)
	new /obj/item/storage/medkit/emergency(src)
	new /obj/item/clothing/suit/straight_jacket(src)
	new /obj/item/storage/belt/medical(src)
	new /obj/item/storage/belt/security/medic/full(src)
	new /obj/item/clothing/under/rank/medical/scrubs/skyrat/red/sec(src)
	new /obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate
