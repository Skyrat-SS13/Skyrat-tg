/datum/job/expedition_commander
	title = "Expedition Сommander"
	description = ""
	department_head = list(JOB_QUARTERMASTER)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the quartermaster"
	selection_color = "#d7b088"
	exp_requirements = 400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_CREW

	departments_list = list(
		/datum/job_department/cargo,
		/datum/job_department/command,
	)

	outfit = /datum/outfit/job/expedition_commander
	plasmaman_outfit = /datum/outfit/plasmaman/mining

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_RANDOM

	family_heirlooms = list(/obj/item/binoculars)

	veteran_only = FALSE

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/expedition_commander
	name = "Expedition Сommander"
	jobtype = /datum/job/expedition_commander

	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/expedition_headset_commander
	gloves = /obj/item/clothing/gloves/fingerless
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	accessory = /obj/item/clothing/accessory/armband/cargo
	head = /obj/item/clothing/head/beret/cargo
	glasses = /obj/item/clothing/glasses/sunglasses

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/advanced_choice_beacon/exp_corps)

	id = /obj/item/card/id/advanced/expedition_commander
	id_trim = /datum/id_trim/expeditionary_corps/expedition_commander

	belt = /obj/item/modular_computer/tablet/pda

/datum/job/expedition_sci
	title = "Expedition Scientist"
	description = ""
	department_head = list(JOB_QUARTERMASTER)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the quartermaster"
	selection_color = "#d7b088"
	exp_requirements = 400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_CREW

	departments_list = list(
		/datum/job_department/cargo,
	)

	outfit = /datum/outfit/job/expedition_sci
	plasmaman_outfit = /datum/outfit/plasmaman/mining

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_RANDOM

	family_heirlooms = list(/obj/item/binoculars)

	veteran_only = FALSE

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/expedition_sci
	name = "Expedition Scientist"
	jobtype = /datum/job/expedition_sci

	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/expedition_headset_sci
	gloves = /obj/item/clothing/gloves/fingerless
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	accessory = /obj/item/clothing/accessory/armband/science
	head = /obj/item/clothing/head/beret/black

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/advanced_choice_beacon/exp_corps)

	id = /obj/item/card/id/advanced/expedition_sci
	id_trim = /datum/id_trim/expeditionary_corps/expedition_sci

	belt = /obj/item/modular_computer/tablet/pda

/datum/job/expedition_medic
	title = "expedition Medic"
	description = ""
	department_head = list(JOB_QUARTERMASTER)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the quartermaster"
	selection_color = "#d7b088"
	exp_requirements = 400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_CREW

	departments_list = list(
		/datum/job_department/cargo,
	)

	outfit = /datum/outfit/job/expedition_medic
	plasmaman_outfit = /datum/outfit/plasmaman/mining

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_RANDOM

	family_heirlooms = list(/obj/item/binoculars)

	veteran_only = FALSE

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/expedition_medic
	name = "Expedition Medic"
	jobtype = /datum/job/expedition_medic

	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/expedition_headset_med
	gloves = /obj/item/clothing/gloves/fingerless
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	accessory = /obj/item/clothing/accessory/armband/medblue
	head = /obj/item/clothing/head/beret/black

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/advanced_choice_beacon/exp_corps)

	id = /obj/item/card/id/advanced/expedition_med
	id_trim = /datum/id_trim/expeditionary_corps/expedition_med

	belt = /obj/item/modular_computer/tablet/pda/medical
	skillchips = list(/obj/item/skillchip/entrails_reader)

/datum/job/expedition_sec
	title = "Expedition Security Guard"
	description = ""
	department_head = list(JOB_QUARTERMASTER)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the quartermaster"
	selection_color = "#d7b088"
	exp_requirements = 400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_CREW

	departments_list = list(
		/datum/job_department/cargo,
	)

	outfit = /datum/outfit/job/expedition_sec
	plasmaman_outfit = /datum/outfit/plasmaman/mining

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_RANDOM

	family_heirlooms = list(/obj/item/binoculars)

	veteran_only = FALSE

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/expedition_sec
	name = "Expedition Security Guard"
	jobtype = /datum/job/expedition_sec

	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/expedition_headset_med
	gloves = /obj/item/clothing/shoes/jackboots/security
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	suit = /obj/item/clothing/suit/armor/vest/security
	suit_store = /obj/item/gun/energy/disabler
	accessory = /obj/item/clothing/accessory/armband
	head = /obj/item/clothing/head/beret/black
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/advanced_choice_beacon/exp_corps)

	id = /obj/item/card/id/advanced/expedition_sec
	id_trim = /datum/id_trim/expeditionary_corps/expedition_sec

	belt = /obj/item/modular_computer/tablet/pda/security

/datum/job/expedition_eng
	title = "Expedition Engineer"
	description = ""
	department_head = list(JOB_QUARTERMASTER)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "the quartermaster"
	selection_color = "#d7b088"
	exp_requirements = 400
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_SUPPLY
	exp_granted_type = EXP_TYPE_CREW

	departments_list = list(
		/datum/job_department/cargo,
	)

	outfit = /datum/outfit/job/expedition_eng
	plasmaman_outfit = /datum/outfit/plasmaman/mining

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_EXP_CORPS
	bounty_types = CIV_JOB_RANDOM

	family_heirlooms = list(/obj/item/binoculars)

	veteran_only = FALSE

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/expedition_eng
	name = "Expedition Engineer"
	jobtype = /datum/job/expedition_eng

	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/expedition_headset_med
	gloves = /obj/item/clothing/gloves/fingerless
	uniform = /obj/item/clothing/under/rank/cargo/tech/skyrat/utility
	accessory = /obj/item/clothing/accessory/armband/engine
	head = /obj/item/clothing/head/beret/black
	l_pocket = /obj/item/modular_computer/tablet/pda/engineering
	r_pocket = /obj/item/t_scanner

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	box = /obj/item/storage/box/survival/expeditionary_corps

	backpack_contents = list(/obj/item/advanced_choice_beacon/exp_corps)

	id = /obj/item/card/id/advanced/expedition_med
	id_trim = /datum/id_trim/expeditionary_corps/expedition_med

	belt = /obj/item/storage/belt/utility/full/engi
	skillchips = list(/obj/item/skillchip/job/engineer)
