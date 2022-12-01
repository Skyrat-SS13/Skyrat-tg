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

	job_flags = JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_REOPEN_ON_ROUNDSTART_LOSS | JOB_ASSIGN_QUIRKS | JOB_HAS_FAKE_NAME
	rpg_title = "Lout"
	config_tag = "ASSISTANT"

	allow_bureaucratic_error = FALSE

/datum/job/assistant/squatter/get_roundstart_spawn_point()
	var/list/possible_spawns = list()
	for(var/turf/spawner in GLOB.xeno_spawn)
		if(istype(spawner.loc, /area/station/maintenance))
			for(var/mob/living/visible in get_hearers_in_LOS(GHOST_MAX_VIEW_RANGE_DEFAULT, possible_spawns)) // Enlighten me if there's a better define for this specific thing.
				if(visible.stat < DEAD && !HAS_TRAIT(visible, TRAIT_BLIND))
					continue
			possible_spawns += spawner

	if(possible_spawns.len)
		return pick(possible_spawns)

	. = ..() // Left here as a fallback.

/datum/job/assistant/squatter/get_latejoin_spawn_point()
	return get_roundstart_spawn_point()

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

/obj/item/storage/toolbox/emergency/squatter/PopulateContents()
	// To allow escape from enclosed rooms.
	new /obj/item/weldingtool/makeshift(src)
	// Wire for any initial self-repairs, or light-antag purposes.
	new /obj/item/stack/cable_coil(src)
	// Not the emergency one to allow some degree of self-defense from simplemobs.
	new /obj/item/crowbar/makeshift(src)

