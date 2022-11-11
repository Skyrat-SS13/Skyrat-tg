/datum/job/assistant/squatter
	title = JOB_SQUATTER
	description = "Be a lazy bum, steal station resources, have a good time."
	faction = FACTION_NONE
	supervisors = "no one"
	outfit = /datum/outfit/job/squatter
	plasmaman_outfit = /datum/outfit/plasmaman/squatter
	paycheck = PAYCHECK_ZERO
	display_order = JOB_DISPLAY_ORDER_SQUATTER
	department_for_prefs = /datum/job_department/assistant/squatter

	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS
	rpg_title = "Lout"
	config_tag = "ASSISTANT"

	allow_bureaucratic_error = FALSE

/datum/job_department/assistant/squatter
	// Uhhhh, something something squatter specific vars.
	// Leaving as assistant vars cause it saves me headaches when it comes to inconsequential shit.

/datum/outfit/plasmaman/squatter
	name = "Squatter Plasmaman"

	r_hand = null
	l_pocket = /obj/item/tank/internals/plasmaman/belt/full

/datum/outfit/job/squatter
	name = JOB_SQUATTER
	jobtype = /datum/job/assistant/squatter
	id_trim = /datum/id_trim/job/assistant
	uniform = /obj/item/clothing/under/color/random
	l_hand = /obj/item/storage/toolbox/emergency/squatter
	// Not the emergency one to allow some degree of self-defense from simplemobs.
	r_hand = /obj/item/crowbar/large

/obj/item/storage/toolbox/emergency/squatter/PopulateContents()
	// To allow escape from enclosed rooms.
	new /obj/item/weldingtool/mini(src)
	// Wire for any initial self-repairs, or light-antag purposes.
	new /obj/item/stack/cable_coil(src)

