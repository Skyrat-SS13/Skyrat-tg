/datum/job/signal_tech
	title = "Signal Technician"
	department_head = list("Chief Engineer")
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the chief engineer"
	selection_color = "#fff5cc"
	exp_requirements = 60
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/signal_tech
	plasmaman_outfit = /datum/outfit/plasmaman/signal_tech

	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_ENG

	liver_traits = list(TRAIT_ENGINEER_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_SIGNAL_TECHNICIAN
	bounty_types = CIV_JOB_ENG
	departments = DEPARTMENT_ENGINEERING

	family_heirlooms = list(/obj/item/clothing/head/hardhat, /obj/item/screwdriver, /obj/item/wrench, /obj/item/weldingtool, /obj/item/crowbar, /obj/item/wirecutters)

/datum/outfit/job/signal_tech
	name = "Signal Technician"
	jobtype = /datum/job/signal_tech

	belt = /obj/item/storage/belt/utility/full/engi
	l_pocket = /obj/item/pda/signal_tech
	ears = /obj/item/radio/headset/headset_eng
	uniform = /obj/item/clothing/under/rank/engineering/signal_tech
	suit = /obj/item/clothing/suit/hooded/wintercoat/engineering/tcomms
	gloves = /obj/item/clothing/gloves/color/black
	shoes = /obj/item/clothing/shoes/workboots

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	backpack_contents = list(/obj/item/modular_computer/tablet/preset/advanced/engineering=1)

	id_trim = /datum/id_trim/job/signal_tech

/obj/effect/landmark/start/signal_tech
	name = "Signal Technician"
	icon_state = "Station Engineer"
