/datum/job/command_secretary
	title = "Command Secretary"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Captain")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Captain, and all of the Command staff"
	selection_color = "#ddddff"
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 60
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/commsec
	departments = DEPARTMENT_COMMAND

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV
	bounty_types = CIV_JOB_RANDOM

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_COMMAND_SECRETARY

    mail_goodies = list(
		/obj/item/reagent_containers/food/drinks/coffee = 12,
		/obj/item/stack/spacecash/c500 = 2,
		/obj/item/clothing/head/collectable/hos = 2,
		/obj/item/clothing/head/collectable/hop = 2,
		/obj/item/clothing/head/collectable/captain = 2,
	)

	family_heirlooms = list(/obj/item/reagent_containers/food/drinks/trophy/silver_cup)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

/datum/outfit/job/commsec
	name = "Command Secretary"
	jobtype = /datum/job/command_secretary

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/pda/heads/hop
	ears = /obj/item/radio/headset/commsec
	uniform = /obj/item/clothing/under/misc/assistantformal
	shoes = /obj/item/clothing/shoes/sneakers/brown
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)
	id_trim = /datum/id_trim/job/command_secretary

/obj/item/radio/headset/commsec
	name = "\proper the command secretary's headset"
	desc = "The headset of command's play-thing."
	icon_state = "com_headset"
	keyslot = new /obj/item/encryptionkey/commsec

/obj/item/encryptionkey/commsec
	name = "\proper the command secretary's encryption key"
	icon_state = "hop_cypherkey"
	channels = list(RADIO_CHANNEL_COMMAND = 1)
