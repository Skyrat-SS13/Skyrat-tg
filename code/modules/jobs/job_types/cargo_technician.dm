/datum/job/cargo_technician
	title = "Cargoslavian Mercenary"
	//department_head = list("Head of Personnel") //ORIGINAL
	department_head = list("Quartermaster") //SKYRAT EDIT CHANGE
	faction = "Station"
	total_positions = 3
	spawn_positions = 2
	//supervisors = "the quartermaster and the head of personnel" //ORIGINAL
	supervisors = "the quartermaster" //SKYRAT EDIT CHANGE
	selection_color = "#dcba97"

	outfit = /datum/outfit/job/cargo_tech
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_CARGO_TECHNICIAN
	bounty_types = CIV_JOB_RANDOM
	departments = DEPARTMENT_CARGO

	family_heirlooms = list(/obj/item/clipboard)

/datum/outfit/job/cargo_tech
	name = "Cargoslavian Mercenary"
	jobtype = /datum/job/cargo_technician

	belt = /obj/item/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	uniform = /obj/item/clothing/under/rank/cargo/tech
	suit = /obj/item/clothing/suit/armor/bulletproof
	r_hand = /obj/item/gun/ballistic/automatic/cfa_wildcat
	l_hand = /obj/item/export_scanner
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/cargo=1),(/obj/item/ammo_box/magazine/smg32/rubber=1),(/obj/item/gun/ballistic/automatic/pistol/cfa_snub=1)
	id_trim = /datum/id_trim/job/cargo_technician
