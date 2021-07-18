/datum/job/quartermaster
	title = "Quartermaster"
<<<<<<< HEAD
	//department_head = list("Head of Personnel") //ORIGINAL
	department_head = list("Captain") //SKYRAT EDIT CHANGE
	faction = "Station"
=======
	department_head = list("Head of Personnel")
	faction = FACTION_STATION
>>>>>>> 4c21166e4ff (Job refactor: strings to references and typepaths (#59841))
	total_positions = 1
	spawn_positions = 1
	//supervisors = "the head of personnel" //ORIGINAL
	supervisors = "the captain" //SKYRAT EDIT CHANGE
	selection_color = "#d7b088"
	exp_type_department = EXP_TYPE_SUPPLY // This is so the jobs menu can work properly

	outfit = /datum/outfit/job/quartermaster
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_COMMAND //SKYRAT EDIT CHANGE - ORIGINAL: PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	//liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM) //ORIGINAL
	liver_traits = list(TRAIT_ROYAL_METABOLISM) //SKYRAT EDIT CHANGE

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER
	bounty_types = CIV_JOB_RANDOM
	departments = DEPARTMENT_CARGO
	family_heirlooms = list(/obj/item/stamp, /obj/item/stamp/denied)
	mail_goodies = list(
		/obj/item/circuitboard/machine/emitter = 3
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE


/datum/job/quartermaster/after_spawn(mob/living/carbon/human/H, mob/M) //SKYRAT EDIT - Gubman 3.1
	. = ..()
	to_chat(M, "<span class='userdanger'>The firearm in your locker is for <b><u>SELF DEFENSE</b></u>, keep it within your department unless the situation is <i>extremely</i>dire. Security can confiscate it!.")

/datum/outfit/job/quartermaster
	name = "Quartermaster"
	jobtype = /datum/job/quartermaster

	belt = /obj/item/pda/quartermaster
	//ears = /obj/item/radio/headset/headset_cargo //ORIGINAL
	ears = /obj/item/radio/headset/heads/qm //SKYRAT EDIT CHANGE
	id = /obj/item/card/id/advanced/silver //SKYRAT EDIT CHANGE
	uniform = /obj/item/clothing/under/rank/cargo/qm
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	//backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo/quartermaster = 1) //ORIGINAL
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/cargo/quartermaster = 1) //SKYRAT EDIT CHANGE

	chameleon_extras = /obj/item/stamp/qm

	id_trim = /datum/id_trim/job/quartermaster
