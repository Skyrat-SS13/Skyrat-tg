/datum/job/fleetmaster
	title = "Fleetmaster"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Nanotrasen Fleet Command")
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	supervisors = "Nanotrasen Fleet Command and God himself"
	selection_color = "#6969f8"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 6000
	exp_required_type = EXP_TYPE_CREW
	exp_required_type_department = EXP_TYPE_NANOTRASEN_FLEET_COMMAND
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/fleetmaster
	plasmaman_outfit = /datum/outfit/plasmaman/centcom_commander

	paycheck = PAYCHECK_NANOTRASEN_FLEET_COMMAND
	paycheck_department = ACCOUNT_CCM

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_FLEETMASTER
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

	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE

	voice_of_god_power = 1.4 //Command staff has authority

	veteran_only = TRUE


/datum/job/fleetmaster/get_captaincy_announcement(mob/living/captain)
	return "Fleetmaster [captain.real_name] on deck!"

/datum/outfit/job/fleetmaster
	name = "Fleetmaster"

	jobtype = /datum/job/fleetmaster

	implants = list(/obj/item/implant/mindshield)

	id = /obj/item/card/id/advanced/centcom
	belt = /obj/item/pda/nanotrasen_representative
	glasses = /obj/item/clothing/glasses/eyepatch
	mask = /obj/item/clothing/mask/cigarette/cigar/cohiba
	ears = /obj/item/radio/headset/headset_cent/commander
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	uniform = /obj/item/clothing/under/rank/centcom/commander
	suit = /obj/item/clothing/suit/toggle/armor/vest/centcom_formal
	suit_store = /obj/item/gun/ballistic/revolver/mateba
	shoes = /obj/item/clothing/shoes/combat/swat
	head = /obj/item/clothing/head/centhat
	back = /obj/item/storage/backpack/satchel/leather
	backpack_contents = list(/obj/item/melee/baton/loaded, /obj/item/ammo_box/a357 = 4)

	skillchips = list(/obj/item/skillchip/disk_verifier)

	implants = list(/obj/item/implant/mindshield)
	accessory = /obj/item/clothing/accessory/medal/gold/heroism

	chameleon_extras = list(/obj/item/gun/energy/e_gun, /obj/item/stamp/centcom)

	id_trim = /datum/id_trim/centcom/fleetmaster


/datum/id_trim/centcom/fleetmaster
	assignment = "Fleetmaster"

/datum/id_trim/centcom/fleetmaster/New()
	. = ..()

	access = SSid_access.get_region_access_list(list(REGION_CENTCOM, REGION_ALL_STATION))

/obj/effect/landmark/start/fleetmaster
	name = "Fleetmaster"
	icon_state = "Captain"
	delete_after_roundstart = FALSE
	jobspawn_override = TRUE
