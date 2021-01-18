/datum/job/qm
	title = "Quartermaster"
	//department_head = list("Head of Personnel") //ORIGINAL
	department_head = list("Captain") //SKYRAT EDIT CHANGE
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	//supervisors = "the head of personnel" //ORIGINAL
	supervisors = "the captain" //SKYRAT EDIT CHANGE
	selection_color = "#d7b088"
	exp_type_department = EXP_TYPE_SUPPLY // This is so the jobs menu can work properly

	outfit = /datum/outfit/job/quartermaster

	//SKYRAT EDIT CHANGE BEGIN
	/*
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE)
	*/
	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE, ACCESS_KEYCARD_AUTH, ACCESS_RC_ANNOUNCE, ACCESS_SEC_DOORS, ACCESS_HEADS)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE, ACCESS_KEYCARD_AUTH, ACCESS_RC_ANNOUNCE, ACCESS_SEC_DOORS, ACCESS_HEADS)
	//SKYRAT EDIT CHANGE END
	//paycheck = PAYCHECK_MEDIUM //ORIGINAL
	paycheck = PAYCHECK_COMMAND //SKYRAT EDIT CHANGE
	paycheck_department = ACCOUNT_CAR

	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_QUARTERMASTER
	bounty_types = CIV_JOB_RANDOM

/datum/outfit/job/quartermaster
	name = "Quartermaster"
	jobtype = /datum/job/qm

	belt = /obj/item/pda/quartermaster
	//ears = /obj/item/radio/headset/headset_cargo //ORIGINAL
	ears = /obj/item/radio/headset/heads/qm //SKYRAT EDIT CHANGE
	id = /obj/item/card/id/silver //SKYRAT EDIT ADDITION
	uniform = /obj/item/clothing/under/rank/cargo/qm
	shoes = /obj/item/clothing/shoes/sneakers/brown
	glasses = /obj/item/clothing/glasses/sunglasses
	l_hand = /obj/item/clipboard
	//backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1) //ORIGINAL
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1, /obj/item/modular_computer/tablet/preset/advanced/command = 1) //SKYRAT EDIT CHANGE

	chameleon_extras = /obj/item/stamp/qm

