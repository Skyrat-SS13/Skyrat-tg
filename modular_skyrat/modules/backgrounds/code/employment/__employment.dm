/datum/background_info/employment
	/// Decides if the employment hides the character from manifest.
	var/on_manifest = TRUE
	/// If not null, this is the employment name that will appear on the character's passport.
	var/fake_name = null

/datum/background_info/employment/is_job_valid(datum/job/job)
	if(groups & CULTURE_LAVALAND)
		return FALSE

	return ..()

/datum/background_info/employment/is_ghost_role_valid(obj/effect/mob_spawn/ghost_role/human/ghost_role)
	// If you don't have a lavaland employment, get yeeted.
	if(istype(ghost_role, obj/effect/mob_spawn/ghost_role/human/ash_walker) && !(groups & CULTURE_LAVALAND))
		return FALSE
	// If you do have a lavaland employment, but try to do something else, get yeeted.
	if((groups & CULTURE_LAVALAND) && !istype(ghost_role, obj/effect/mob_spawn/ghost_role/human/ash_walker))
		return FALSE

	return ..()
