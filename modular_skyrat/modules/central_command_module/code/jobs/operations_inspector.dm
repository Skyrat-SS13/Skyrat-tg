/datum/job/operations_inspector
	title = "Operations Inspector"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Fleet Admiral")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Fleet Admiral"
	selection_color = "#6969f8"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 60000000
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_NANOTRASEN_FLEET_COMMAND
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/assistant
	plasmaman_outfit = /datum/outfit/plasmaman/centcom_commander

	paycheck = PAYCHECK_NANOTRASEN_FLEET_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_OPERATIONS_INSPECTOR
	departments_list = list(
		/datum/job_department/command,
		/datum/job_department/nanotrasen_fleet_command,
		)

	family_heirlooms = list(/obj/item/reagent_containers/food/drinks/flask/gold)

	mail_goodies = list(
		/obj/item/clothing/mask/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/food/drinks/bottle/champagne = 10
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_BOLD_SELECT_TEXT | JOB_REOPEN_ON_ROUNDSTART_LOSS

	veteran_only = TRUE
