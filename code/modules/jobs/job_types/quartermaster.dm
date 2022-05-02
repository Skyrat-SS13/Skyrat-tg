/datum/job/quartermaster
	title = JOB_QUARTERMASTER
	description = "Coordinate cargo technicians and shaft miners, assist with \
		economical purchasing."
	//department_head = list(JOB_HEAD_OF_PERSONNEL) //ORIGINAL
	department_head = list(JOB_CAPTAIN) //SKYRAT EDIT CHANGE
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	//supervisors = "the head of personnel" //ORIGINAL
	supervisors = "the captain" //SKYRAT EDIT CHANGE
	selection_color = "#d7b088"
	exp_requirements = 180 //SKYRAT EDIT CHANGE
	exp_required_type = EXP_TYPE_CREW //SKYRAT EDIT CHANGE
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/quartermaster
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_COMMAND //SKYRAT EDIT CHANGE - ORIGINAL: PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	//liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM) //ORIGINAL
	liver_traits = list(TRAIT_ROYAL_METABOLISM) //SKYRAT EDIT CHANGE

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		/datum/job_department/command, //SKYRAT EDIT CHANGE
		)
	family_heirlooms = list(/obj/item/stamp, /obj/item/stamp/denied)
	mail_goodies = list(
		/obj/item/circuitboard/machine/emitter = 3
	)
	rpg_title = "Steward"
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN


/datum/job/quartermaster/after_spawn(mob/living/carbon/human/H, mob/M) //SKYRAT EDIT - Gubman 3.1
	. = ..()
	to_chat(M, "<span class='userdanger'>The firearm in your locker is for <b><u>SELF DEFENSE</b></u>, keep it within your department unless the situation is <i>extremely</i>dire. Security can confiscate it!.")

/datum/outfit/job/quartermaster
	name = "Quartermaster"
	jobtype = /datum/job/quartermaster

	id = /obj/item/card/id/advanced/silver //SKYRAT EDIT CHANGE
	id_trim = /datum/id_trim/job/quartermaster
	uniform = /obj/item/clothing/under/rank/cargo/qm
	backpack_contents = list(
		/obj/item/melee/baton/telescopic=1,
		/obj/item/modular_computer/tablet/preset/cargo/quartermaster = 1
		) //SKYRAT EDIT CHANGE - ORIGINAL: backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo/quartermaster = 1)
	belt = /obj/item/modular_computer/tablet/pda/quartermaster
	ears = /obj/item/radio/headset/heads/qm //SKYRAT EDIT CHANGE - OIGINAL: ears = /obj/item/radio/headset/headset_cargo
	glasses = /obj/item/clothing/glasses/sunglasses
	shoes = /obj/item/clothing/shoes/sneakers/brown
	l_hand = /obj/item/clipboard

	chameleon_extras = /obj/item/stamp/qm
