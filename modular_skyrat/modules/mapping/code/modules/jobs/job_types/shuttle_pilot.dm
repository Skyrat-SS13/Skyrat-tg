/datum/job/shuttlepilot
	title = "Shuttle Pilot"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("CentCom")
	faction = "Station"
	total_positions = 0 //Set to 1 in map config if your map has a dedicated station-shuttle, see shipstation for an example.
	spawn_positions = 0 //Ditto.
	supervisors = "The Captain, and the people you leave behind"
	selection_color = "#ccccff"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 180
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_COMMAND

	outfit = /datum/outfit/job/shuttlepilot

	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_CAPTAIN

/datum/job/shuttlepilot/announce(mob/living/carbon/human/H)
	..()
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, .proc/minor_announce, "Shuttle Pilot [H.real_name] on deck!"))

/datum/outfit/job/shuttlepilot //Controls the ship, the real captain stays at the dock and keeps the nuke diskie. Technically a captain in their own right, but still answers to the station captain. Think of them as the QM to the captain's HOP.
	name = "Shuttle Pilot"
	jobtype = /datum/job/shuttlepilot

	id = /obj/item/card/id/advanced/silver
	belt = /obj/item/pda/captain
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/heads/captain/alt
	gloves = /obj/item/clothing/gloves/color/captain/pilot
	uniform =  /obj/item/clothing/under/rank/captain/pilot
	shoes = /obj/item/clothing/shoes/sneakers/brown
	head = /obj/item/clothing/head/caphat/pilot
	backpack_contents = list(/obj/item/melee/classic_baton/telescopic=1)

	backpack = /obj/item/storage/backpack/captain
	satchel = /obj/item/storage/backpack/satchel/cap
	duffelbag = /obj/item/storage/backpack/duffelbag/captain

	implants = list(/obj/item/implant/mindshield)

	id_trim = /datum/id_trim/job/captain/shuttle_pilot

/datum/outfit/plasmaman/shuttlepilot
	name = "Shuttle Pilot Plasmaman"

	head = /obj/item/clothing/head/helmet/space/plasmaman/captain
	uniform = /obj/item/clothing/under/plasmaman/captain
	gloves = /obj/item/clothing/gloves/color/captain/pilot

