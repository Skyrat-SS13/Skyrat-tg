/**
 * Employments. How and/or why someone is hired, or "hired" by their respective company.
 * These should not contain any required or recommended languages unless it makes sense for them to.
 */
/datum/background_info/employment
	/// If not null, this is the employment name that will appear on the character's passport.
	var/fake_name = null

	// This is to make employments not accept ashies by default.
	false_if_in_roles = TRUE
	roles = list(/obj/effect/mob_spawn/ghost_role/human/ash_walker)
