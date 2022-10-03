/obj/effect/mob_spawn/ghost_role/human/allow_spawn(mob/user, silent = FALSE)
	if(!..())
		return FALSE

	return is_background_valid()


/obj/effect/mob_spawn/ghost_role/human/ash_walker/allow_spawn(mob/user, silent = FALSE)
	if(!..())
		return FALSE

	return is_background_valid()


/obj/effect/mob_spawn/ghost_role/human/proc/is_background_valid()
	if(!user?.client?.prefs)
		return FALSE

	var/datum/preferences/preferences = user.client.prefs
	if(!preferences.origin.is_ghost_role_valid(src) || !preferences.social_background.is_ghost_role_valid(src) || !preferences.employment.is_ghost_role_valid(src))
		user.show_message(span_warning("Your background doesn't allow for this ghost role!"))
		return FALSE
