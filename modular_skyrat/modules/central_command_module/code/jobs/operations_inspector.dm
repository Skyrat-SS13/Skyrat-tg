/datum/job/operations_inspector
	title = "Operations Inspector"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Fleetmaster")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Fleetmaster"
	selection_color = "#6969f8"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 6000
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_COMMAND
	exp_granted_type = EXP_TYPE_NANOTRASEN_FLEET_COMMAND

	outfit = /datum/outfit/job/operations_inspector
	plasmaman_outfit = /datum/outfit/plasmaman/centcom_official

	paycheck = PAYCHECK_NANOTRASEN_FLEET_COMMAND
	paycheck_department = ACCOUNT_CCM

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_OPERATIONS_INSPECTOR
	departments_list = list(
		/datum/job_department/nanotrasen_fleet_command,
		)

	family_heirlooms = list(/obj/item/reagent_containers/food/drinks/flask/gold)

	mail_goodies = list(
		/obj/item/clothing/mask/cigarette/cigar/havana = 20,
		/obj/item/storage/fancy/cigarettes/cigars/havana = 15,
		/obj/item/reagent_containers/food/drinks/bottle/champagne = 10
	)

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

	veteran_only = TRUE

/datum/outfit/job/operations_inspector
	name = "Operations Inspector"

	jobtype = /datum/job/operations_inspector

	implants = list(/obj/item/implant/mindshield)

	id = /obj/item/card/id/advanced/centcom
	belt = /obj/item/pda/nanotrasen_representative
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_cent/alt_with_Key
	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/rank/centcom/officer
	suit = /obj/item/clothing/suit/toggle/
	shoes = /obj/item/clothing/shoes/combat/swat
	back = /obj/item/storage/backpack/satchel/leather

	chameleon_extras = list(/obj/item/gun/energy/e_gun)

	id_trim = /datum/id_trim/centcom/operations_inspector

/datum/id_trim/centcom/operations_inspector
	access = list(ACCESS_CENT_GENERAL, ACCESS_CENT_LIVING, ACCESS_WEAPONS)
	assignment = "Operations Inspector"

/obj/effect/landmark/start/operations_inspector
	name = "Operations Inspector"
	icon_state = "Captain"
	delete_after_roundstart = FALSE
	jobspawn_override = TRUE
