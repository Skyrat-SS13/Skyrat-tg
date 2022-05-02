/datum/job/brigoff
	title = JOB_CORRECTIONS_OFFICER
	description = "Guard the Permabrig, stand around looking imposing, get fired for abusing the prisoners"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("The Warden and Head of Security")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Warden and Head of Security"
	selection_color = "#ffeeee"
	minimal_player_age = 7
	exp_requirements = 150
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SEC

	outfit = /datum/outfit/job/brigoff
	plasmaman_outfit = /datum/outfit/plasmaman/security
	display_order = JOB_DISPLAY_ORDER_BRIGOFF
	mind_traits = list(TRAIT_DONUT_LOVER)
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
	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN

/datum/job/brigoff/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	to_chat(M, span_userdanger("You are a <b><u>GUARD</b></u> not a Security Officer, do <b><u>NOT</b></u> run off and be Security unless it's red alert!."))
	to_chat(M, span_warning("You shouldn't leave the brig for long peroids of time. <b>Remember: You aren't a Security Officer.</b>"))
	to_chat(M, "<b>You are a Brig Officer of the Frontier Space Station 13, your duties include Prisoner escort and ensuring the Prisoners stay in line.</b>")




/datum/outfit/job/brigoff
	name = "Corrections Officer"
	jobtype = /datum/job/brigoff
	uniform = /obj/item/clothing/under/rank/security/brigguard/sweater
	suit = /obj/item/clothing/suit/toggle/jacket/brigoff
	shoes = /obj/item/clothing/shoes/laceup
	ears = /obj/item/radio/headset/headset_sec
	glasses = /obj/item/clothing/glasses/sunglasses
	backpack_contents = list(/obj/item/melee/baton/security/loaded/departmental/prison, /obj/item/restraints/handcuffs = 2, /obj/item/clothing/mask/whistle, /obj/item/gun/energy/disabler)
	implants = list(/obj/item/implant/mindshield)
	backpack = /obj/item/storage/backpack/security
	satchel = /obj/item/storage/backpack/satchel/sec
	duffelbag = /obj/item/storage/backpack/duffelbag/sec
	head = /obj/item/clothing/head/brigoff
	box = /obj/item/storage/box/survival/security
	belt = /obj/item/modular_computer/tablet/pda/security

	id_trim = /datum/id_trim/job/brigoff



