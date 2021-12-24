// /obj/item/clothing/under/rank/security/officer/blueshirt

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	icon_state = "barney_uniform"
	worn_icon_state = "barney_uniform"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	unique_reskin = null

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	name = "orderly uniform"
	icon_state = "orderly_uniform"
	worn_icon_state = "orderly_uniform"

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	name = "engineering guard uniform"
	icon_state = "engineering_guard_uniform"
	worn_icon_state = "engineering_guard_uniform"

/obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	name = "customs agent uniform"
	icon_state = "customs_uniform"
	worn_icon_state = "customs_uniform"

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat
	icon_state = "barney_armor"
	worn_icon_state = "barney_armor"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	unique_reskin = null

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/guard
	icon_state = "guard_armor"
	worn_icon_state = "guard_armor"

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	name = "armored orderly coat"
	desc = "An armored coat, to keep you safe from unruly patients."
	icon_state = "medical_coat"
	worn_icon_state = "medical_coat"

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	name = "armored engineering guard coat"
	desc = "An armored coat, to keep you safe from unruly patients."
	icon_state = "engineering_coat"
	worn_icon_state = "engineering_coat"

/obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	name = "armored customs agent coat"
	desc = "An armored coat, to keep you safe from unruly customers."
	icon_state = "customs_coat"
	worn_icon_state = "customs_coat"

/obj/item/clothing/head/helmet/blueshirt/skyrat
	icon_state = "barney_helm"
	worn_icon_state = "barney_helm"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	unique_reskin = null

/obj/item/clothing/head/helmet/blueshirt/skyrat/guard
	icon_state = "mallcop_helm"
	worn_icon_state = "mallcop_helm"

/datum/job/orderly
	title = JOB_ORDERLY
	description = "Defend the medical department, hold down idiots who refuse the vaccine, flex your muscles at people who fuck with medical."
	job_spawn_title = "Medical Doctor"
	department_head = list(JOB_CHIEF_MEDICAL_OFFICER)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief medical officer, <b>NOT SECURITY</b>"
	selection_color = "#ffeeee"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/orderly
	plasmaman_outfit = /datum/outfit/plasmaman/medical

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_MED

	display_order = JOB_DISPLAY_ORDER_ORDERLY
	bounty_types = CIV_JOB_MED
	departments_list = list(
		/datum/job_department/medical,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/orderly
	name = "Orderly" // You forgot your vaccine *flexes muscles*
	jobtype = /datum/job/orderly

	belt = /obj/item/pda/medical
	ears = /obj/item/radio/headset/headset_med
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/orderly
	shoes = /obj/item/clothing/shoes/sneakers/white
	head =  /obj/item/clothing/head/helmet/blueshirt/skyrat/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/orderly
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		)

	backpack = /obj/item/storage/backpack/medic
	satchel = /obj/item/storage/backpack/satchel/med
	duffelbag = /obj/item/storage/backpack/duffelbag/med
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/orderly

/datum/id_trim/job/orderly
	assignment = "Orderly"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_orderly"
	extra_access = list(ACCESS_SEC_DOORS, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM)
	config_job = "orderly"
	template_access = list(ACCESS_SEC_DOORS, ACCESS_CAPTAIN, ACCESS_CMO, ACCESS_CHANGE_IDS)
	job = /datum/job/orderly

/datum/job/science_guard
	title = JOB_SCIENCE_GUARD // I'm a little busy here, Calhoun.
	description = "Figure out why the emails aren't working, keep an eye on those eggheads, keep them safe from their mistakes."
	job_spawn_title = "Scientist"
	department_head = list(JOB_RESEARCH_DIRECTOR)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the research director, <b>NOT SECURITY</b>"
	selection_color = "#ffeeee"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/science_guard
	plasmaman_outfit = /datum/outfit/plasmaman/science

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SCI

	display_order = JOB_DISPLAY_ORDER_SCIENCE_GUARD
	bounty_types = CIV_JOB_SCI
	departments_list = list(
		/datum/job_department/science,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/science_guard
	name = "Science Guard"
	jobtype = /datum/job/science_guard

	belt = /obj/item/pda/science
	ears = /obj/item/radio/headset/headset_sci
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat
	shoes = /obj/item/clothing/shoes/sneakers/black
	head =  /obj/item/clothing/head/helmet/blueshirt/skyrat
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		)

	backpack = /obj/item/storage/backpack/science
	satchel = /obj/item/storage/backpack/satchel/science
	duffelbag = /obj/item/storage/backpack/duffelbag/science
	box = /obj/item/storage/box/survival/medical

	id_trim = /datum/id_trim/job/science_guard

/datum/id_trim/job/science_guard
	assignment = "Science Guard"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_calhoun"
	extra_access = list(ACCESS_SEC_DOORS, ACCESS_ROBOTICS, ACCESS_RND, ACCESS_ORDNANCE, ACCESS_ORDNANCE_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY,
					ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE, ACCESS_GENETICS, ACCESS_AUX_BASE)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_ROBOTICS, ACCESS_RND, ACCESS_ORDNANCE, ACCESS_ORDNANCE_STORAGE, ACCESS_RESEARCH, ACCESS_XENOBIOLOGY,
					ACCESS_MECH_SCIENCE, ACCESS_MINERAL_STOREROOM, ACCESS_TECH_STORAGE, ACCESS_GENETICS, ACCESS_AUX_BASE)
	config_job = "science_guard"
	template_access = list(ACCESS_CAPTAIN, ACCESS_RD, ACCESS_CHANGE_IDS)
	job = /datum/job/science_guard

/datum/job/bouncer
	title = JOB_BOUNCER
	description = "Tell people they aren't on the list. Check people's IDs. Tell them to fuck off and get real ID."
	job_spawn_title = "Bartender"
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of personnel, <b>NOT SECURITY</b>"
	selection_color = "#ffeeee"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/bouncer
	plasmaman_outfit = /datum/outfit/plasmaman/party_bouncer

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_BOUNCER
	bounty_types = CIV_JOB_DRINK
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/bouncer
	name = "Bouncer" // That ID looks a little suspect, pal. You ain't on the list, beat it.
	jobtype = /datum/job/bouncer

	belt = /obj/item/pda/bar
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/misc/bouncer
	shoes = /obj/item/clothing/shoes/sneakers/black
	head =  /obj/item/clothing/head/helmet/blueshirt/skyrat/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/guard
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		)
	glasses = /obj/item/clothing/glasses/sunglasses

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival

	id_trim = /datum/id_trim/job/bouncer

/datum/id_trim/job/bouncer
	assignment = "Bouncer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_bouncer"
	extra_access = list(ACCESS_SEC_DOORS, ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	config_job = "bouncer"
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/bouncer

/datum/job/customs_agent
	title = JOB_CUSTOMS_AGENT // No, you don't get to ship ten kilograms of cocaine to the Spinward Stellar Coalition.
	description = "Inspect the packages coming to and from the station, protect the cargo department, beat the shit out of people trying to ship Cocaine to the Spinward Stellar Coalition."
	job_spawn_title = "Cargo Technician"
	department_head = list(JOB_QUARTERMASTER)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the quartermaster, <b>NOT SECURITY</b>"
	selection_color = "#ffeeee"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/customs_agent
	plasmaman_outfit = /datum/outfit/plasmaman/cargo

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_CUSTOMS_AGENT
	bounty_types = CIV_JOB_RANDOM
	departments_list = list(
		/datum/job_department/cargo,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/customs_agent
	name = "Customs Agent"
	jobtype = /datum/job/customs_agent

	belt = /obj/item/pda/cargo
	ears = /obj/item/radio/headset/headset_cargo
	shoes = /obj/item/clothing/shoes/sneakers/black
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/customs_agent
	head =  /obj/item/clothing/head/helmet/blueshirt/skyrat/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/customs_agent
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag
	box = /obj/item/storage/box/survival

	id_trim = /datum/id_trim/job/customs_agent

/datum/id_trim/job/customs_agent
	assignment = "Customs Agent"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_customs"
	extra_access = list(ACCESS_SEC_DOORS, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	config_job = "customs_agent"
	template_access = list(ACCESS_CAPTAIN, ACCESS_QM, ACCESS_CHANGE_IDS)
	job = /datum/job/customs_agent

/datum/job/engineering_guard
	title = JOB_ENGINEERING_GUARD // Listen here, this engine is a restricted area. Please leave if you aren't wearing a radioactive suit.
	description = "Spy on the supermatter, keep an eye on atmospherics, fall asleep at your desk."
	job_spawn_title = "Station Engineer"
	department_head = list(JOB_CHIEF_ENGINEER)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the chief engineer, <b>NOT SECURITY</b>"
	selection_color = "#ffeeee"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/engineering_guard
	plasmaman_outfit = /datum/outfit/plasmaman/engineering

	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_ENG

	display_order = JOB_DISPLAY_ORDER_ENGINEER_GUARD
	bounty_types = CIV_JOB_ENG
	departments_list = list(
		/datum/job_department/engineering,
		)

	family_heirlooms = list(/obj/item/book/manual/wiki/security_space_law, /obj/item/clothing/head/beret/sec)

	mail_goodies = list(
		/obj/item/food/donut/caramel = 10,
		/obj/item/food/donut/matcha = 10,
		/obj/item/food/donut/blumpkin = 5,
		/obj/item/clothing/mask/whistle = 5,
		/obj/item/melee/baton/security/boomerang/loaded = 1
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS

/datum/outfit/job/engineering_guard
	name = "Engineering Guard"
	jobtype = /datum/job/engineering_guard

	belt = /obj/item/pda/engineering
	ears = /obj/item/radio/headset/headset_eng
	shoes = /obj/item/clothing/shoes/workboots
	uniform = /obj/item/clothing/under/rank/security/officer/blueshirt/skyrat/engineering_guard
	head =  /obj/item/clothing/head/helmet/blueshirt/skyrat/guard
	suit = /obj/item/clothing/suit/armor/vest/blueshirt/skyrat/engineering_guard
	l_pocket = /obj/item/restraints/handcuffs
	r_pocket = /obj/item/assembly/flash/handheld
	backpack_contents = list(
		/obj/item/melee/baton/security/loaded = 1,
		)

	backpack = /obj/item/storage/backpack/industrial
	satchel = /obj/item/storage/backpack/satchel/eng
	duffelbag = /obj/item/storage/backpack/duffelbag/engineering
	box = /obj/item/storage/box/survival/engineer

	id_trim = /datum/id_trim/job/engineering_guard

/datum/id_trim/job/engineering_guard
	assignment = "Engineering Guard"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_engiguard"
	extra_access = list(ACCESS_SEC_DOORS, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_AUX_BASE,
					ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SEC_DOORS, ACCESS_ENGINE, ACCESS_ENGINE_EQUIP, ACCESS_TECH_STORAGE, ACCESS_MAINT_TUNNELS, ACCESS_MECH_ENGINE, ACCESS_AUX_BASE,
					ACCESS_EXTERNAL_AIRLOCKS, ACCESS_CONSTRUCTION, ACCESS_ATMOSPHERICS, ACCESS_TCOMSAT, ACCESS_MINERAL_STOREROOM)
	config_job = "engineering_guard"
	template_access = list(ACCESS_CAPTAIN, ACCESS_CE, ACCESS_CHANGE_IDS)
	job = /datum/job/engineering_guard
