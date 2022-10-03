/obj/effect/mob_spawn/ghost_role/human/allow_spawn(mob/user, silent = FALSE)
	if(!..())
		return FALSE

	return is_background_valid(user)


/obj/effect/mob_spawn/ghost_role/human/ash_walker/allow_spawn(mob/user, silent = FALSE)
	if(!..())
		return FALSE

	return is_background_valid(user)


/obj/effect/mob_spawn/ghost_role/human/proc/is_background_valid(mob/user)
	if(!user?.client?.prefs)
		return FALSE

	var/datum/background_info/origin = GLOB.origins[user.client.prefs.origin]
	var/datum/background_info/social_background = GLOB.social_backgrounds[user.client.prefs.social_background]
	var/datum/background_info/employment = GLOB.employments[user.client.prefs.employment]
	if(!origin.is_ghost_role_valid(src) || !social_background.is_ghost_role_valid(src) || !employment.is_ghost_role_valid(src))
		user.show_message(span_warning("Your background doesn't allow for this ghost role!"))
		return FALSE
