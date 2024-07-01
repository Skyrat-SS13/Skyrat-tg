/datum/job/telecomms_specialist
	title = JOB_TELECOMMS_SPECIALIST
	description = "Monitor, configure, and maintain all station communications \
		and assist with light engineering work."
	department_head = list(JOB_CHIEF_ENGINEER)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = SUPERVISOR_CE
	exp_requirements = 60
	exp_required_type = EXP_TYPE_CREW
	exp_granted_type = EXP_TYPE_CREW
	config_tag = "TELECOMMS_SPECIALIST"

	outfit = /datum/outfit/job/telecomms_specialist
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_ENG

	liver_traits = list(TRAIT_ENGINEER_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_TELECOMMS_SPECIALIST
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		)

	family_heirlooms = list(
		/obj/item/modular_computer/laptop,
		/obj/item/radio,
		/obj/item/pai_card,
		/obj/item/multitool,
		/obj/item/clothing/accessory/pocketprotector,
	)

	mail_goodies = list(
		/obj/item/coffee_cartridge = 20,
		/obj/item/reagent_containers/cup = 10,
		/obj/item/stock_parts/subspace = 8,
		/obj/item/banhammer = 8,
		/obj/item/computer_disk/maintenance = 1,
	)
	rpg_title = "Diviner"
	job_flags = STATION_JOB_FLAGS

/obj/effect/landmark/start/telecomms_specialist
	name = "Telecomms Specialist"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'
	icon_state = "Engineering Guard"

/datum/outfit/job/telecomms_specialist
	name = "Telecomms Specialist"
	jobtype = /datum/job/telecomms_specialist

	id_trim = /datum/id_trim/job/telecomms_specialist
	uniform = /obj/item/clothing/under/rank/engineering/engineer/skyrat/utility/telecomm
	suit = /obj/item/clothing/suit/toggle/jacket/tcomm
	neck = /obj/item/clothing/neck/link_scryer
	belt = /obj/item/screwdriver
	ears = /obj/item/radio/headset/headset_eng
	head = /obj/item/clothing/head/utility/hardhat/dblue
	shoes = /obj/item/clothing/shoes/laceup
	l_pocket = /obj/item/modular_computer/pda/telecomms
	r_pocket = /obj/item/multitool

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	messenger = /obj/item/storage/backpack/messenger/eng

	box = /obj/item/storage/box/survival/engineer
	pda_slot = ITEM_SLOT_LPOCKET
	skillchips = list(/obj/item/skillchip/job/engineer)

	backpack_contents = list(
		/obj/item/paper/monitorkey,
		/obj/item/wirecutters,
		/obj/item/holosign_creator/atmos,
	)

/obj/item/modular_computer/pda/telecomms
	name = "telecomms PDA"
	greyscale_config = /datum/greyscale_config/tablet/stripe_split
	greyscale_colors = "#3267B1#3D83E3#D99A2E"
	starting_programs = list(
		/datum/computer_file/program/alarm_monitor,
		/datum/computer_file/program/signal_commander,
		/datum/computer_file/program/ntnetmonitor,
	)

/datum/id_trim/job/telecomms_specialist
	assignment = "Telecomms Specialist"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_telecommsspecialist"
	department_color = COLOR_ENGINEERING_ORANGE
	subdepartment_color = COLOR_ENGINEERING_ORANGE
	sechud_icon_state = SECHUD_TELECOMMS_SPECIALIST
	minimal_access = list(
		ACCESS_CONSTRUCTION,
		ACCESS_ENGINEERING,
		ACCESS_MAINT_TUNNELS,
		ACCESS_MECH_ENGINE,
		ACCESS_MINERAL_STOREROOM,
		ACCESS_MINISAT,
		ACCESS_NETWORK, //Sysadmin gets network access, of course
		ACCESS_RC_ANNOUNCE, //to use the requests console announcement found in telecomms
		ACCESS_TCOMMS,
		ACCESS_TECH_STORAGE,
		)
	extra_access = list(
		ACCESS_ATMOSPHERICS,
		ACCESS_ENGINE_EQUIP,
		ACCESS_EXTERNAL_AIRLOCKS,
		)
	template_access = list(
		ACCESS_CAPTAIN,
		ACCESS_CHANGE_IDS,
		ACCESS_CE,
		)
	job = /datum/job/telecomms_specialist
