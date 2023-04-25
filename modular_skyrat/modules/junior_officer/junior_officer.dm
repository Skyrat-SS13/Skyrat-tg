/datum/job/junior_officer
	title = JOB_JUNIOR_OFFICER
	description = "Deal with low-level crimes and civil disputes, and assist the Security Officers in their duties"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Warden and Head of Security")
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = SUPERVISOR_HOS
	minimal_player_age = 7
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "JUNIOR_OFFICER"

	outfit = /datum/outfit/job/junior_officer
	plasmaman_outfit = /datum/outfit/plasmaman/security

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_JUNIOR_SECURITY_OFFICER
	bounty_types = CIV_JOB_SEC
	departments_list = list(
		/datum/job_department/security,
	)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/grenade/stingbang = 1,
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/junior_officer
	name = "Civil Disputes Officer"
	jobtype = /datum/job/junior_officer

	belt = /obj/item/storage/belt/security/redsec
	ears = /obj/item/radio/headset/headset_sec
	uniform = /obj/item/clothing/under/rank/security/peacekeeper/sol/junior_officer
	shoes = /obj/item/clothing/shoes/sneakers/black/tactical
	glasses = /obj/item/clothing/glasses/hud/ar/aviator/security
	head = /obj/item/clothing/head/hats/sec/peacekeeper/sol
	gloves = /obj/item/clothing/gloves/fingerless

	suit = /obj/item/clothing/suit/armor/vest/peacekeeper/brit

	backpack_contents = list(
		/obj/item/clothing/gloves/tackler/offbrand,
		/obj/item/storage/box/gunset/pepperball,
		/obj/item/restraints/handcuffs/cable = 2,
		/obj/item/modular_computer/pda/security,
		/obj/item/clipboard,
		)

	l_pocket = /obj/item/flashlight

	r_pocket = /obj/item/assembly/flash/handheld

	box = /obj/item/storage/box/survival/security

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/junior_officer

/datum/outfit/job/junior_officer/post_equip(mob/living/carbon/human/equipped, visualsOnly)
	. = ..()
	if(prob(1))
		ADD_TRAIT(equipped, TRAIT_PACIFISM, ROUNDSTART_TRAIT)

/datum/job/junior_officer/get_roundstart_spawn_point()
	if(length(GLOB.jobspawn_overrides[JOB_SECURITY_OFFICER]))
		return pick(GLOB.jobspawn_overrides[JOB_SECURITY_OFFICER])
	return ..()
