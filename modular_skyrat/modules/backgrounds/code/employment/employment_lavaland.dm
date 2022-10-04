/datum/background_info/employment/lavaland
	name = "Ashwalker Tribesman"
	description = "Placeholder."
	economic_power = 0
	features = list(/datum/background_feature/lavaland)
	groups = BACKGROUNDS_LAVALAND

/datum/background_info/employment/lavaland/is_job_valid(datum/job/job)
	return FALSE

/datum/background_info/employment/lavaland/is_ghost_role_valid(obj/effect/mob_spawn/ghost_role/human/ghost_role)
	// If you aren't using an ashwalker spawn, get yeeted.
	if(!istype(ghost_role, /obj/effect/mob_spawn/ghost_role/human/ash_walker))
		return FALSE

	return ..()

/datum/background_info/employment/lavaland/hunter
	name = "Ashwalker Hunter"

/datum/background_info/employment/lavaland/shaman
	name = "Ashwalker Shaman"
