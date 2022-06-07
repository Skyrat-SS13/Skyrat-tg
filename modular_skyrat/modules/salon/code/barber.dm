/datum/job/barber
	title = JOB_BARBER
	description = "Run your salon and meet the crews sanitary needs, such as hair cutting, massaging and more!"
	department_head = list(JOB_HEAD_OF_PERSONNEL)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	supervisors = "the head of personnel"
	selection_color = "#bbe291"
	exp_granted_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/barber
	plasmaman_outfit = /datum/outfit/plasmaman

	paycheck = PAYCHECK_CREW
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_BARTENDER
	bounty_types = CIV_JOB_BASIC
	departments_list = list(
		/datum/job_department/service,
		)

	family_heirlooms = list(/obj/item/hairbrush/comb, /obj/item/razor)
	job_flags = JOB_ANNOUNCE_ARRIVAL | JOB_CREW_MANIFEST | JOB_EQUIP_RANK | JOB_CREW_MEMBER | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_CAN_BE_INTERN


/datum/outfit/job/barber
	name = "Barber"
	jobtype = /datum/job/barber

	glasses = /obj/item/clothing/glasses/sunglasses
	belt = /obj/item/modular_computer/tablet/pda
	ears = /obj/item/radio/headset/headset_srv
	uniform = /obj/item/clothing/under/rank/barber
	shoes = /obj/item/clothing/shoes/laceup
	id_trim = /datum/id_trim/job/barber

/obj/structure/closet/secure_closet/barber
	name = "Barber's locker"
	icon_state = "barber"
	icon = 'modular_skyrat/master_files/icons/obj/closet.dmi'
	req_access = list(ACCESS_BARBER)

/obj/structure/closet/secure_closet/barber/PopulateContents()
	new /obj/item/clothing/mask/surgical(src) // These three are here, so the barber can pick and choose what he's painting.
	new /obj/item/clothing/under/rank/medical/scrubs/blue(src)
	new /obj/item/clothing/suit/apron/surgical(src)
	new /obj/item/clothing/accessory/waistcoat(src)
	new /obj/item/clothing/under/rank/civilian/lawyer/purpsuit(src)
	new /obj/item/clothing/suit/toggle/lawyer/purple(src)
	new /obj/item/razor(src)
	new /obj/item/straight_razor(src)
	new /obj/item/hairbrush/comb(src)
	new /obj/item/scissors(src)
	new /obj/item/fur_dyer(src)
	new /obj/item/dyespray(src)
	new /obj/item/storage/box/lipsticks(src)
	new /obj/item/reagent_containers/spray/quantum_hair_dye(src)
	new /obj/item/reagent_containers/spray/barbers_aid(src)
	new /obj/item/reagent_containers/spray/cleaner(src)
	new /obj/item/reagent_containers/glass/rag(src)
	new /obj/item/storage/medkit(src)

/obj/effect/landmark/start/barber
	name = "Barber"
	icon_state = "Barber"
	icon = 'modular_skyrat/master_files/icons/mob/landmarks.dmi'

