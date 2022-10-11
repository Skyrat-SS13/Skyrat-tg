/datum/background_info/employment
	/// If not null, this is the employment name that will appear on the character's passport.
	var/fake_name = null

	// This is to make employments not accept ashies by default.
	false_if_in_roles = TRUE
	roles = list(/obj/effect/mob_spawn/ghost_role/human/ash_walker)
