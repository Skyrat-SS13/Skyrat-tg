// This is purely so that we can cleanly update the name in the "Setup Character" menu entry.
/datum/preference_middleware/titlescreen

/datum/preference_middleware/titlescreen/on_new_character(mob/user)
	// User changed the slot.
	if(!istype(user, /mob/dead/new_player))
		return
	SStitle.update_character_name(user, preferences.read_preference(/datum/preference/name/real_name))

/datum/preference_middleware/titlescreen/post_set_preference(mob/user, preference, value)
	// User changed the current slot's name.
	if(!istype(user, /mob/dead/new_player) || preference != "real_name")
		return FALSE
	SStitle.update_character_name(user, value)
	return FALSE
