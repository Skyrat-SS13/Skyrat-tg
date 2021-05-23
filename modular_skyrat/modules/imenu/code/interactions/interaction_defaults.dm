/datum/interaction/handshake
	name = "Handshake"
	category = INTERACTION_CAT_NONE
	message = "%USER% shakes %TARGET%'s hand."

/datum/interaction/handshake/allow_act(mob/living/user, mob/living/target)
	return user.has_active_hand() && target.has_active_hand()

/datum/interaction/pat
	name = "Pat"
	category = INTERACTION_CAT_NONE
	message = "%USER% pats %TARGET% on their shoulder."

/datum/interaction/pat/allow_act(mob/living/user, mob/living/target)
	return user.has_active_hand()

/datum/interaction/cheer
	name = "Cheer"
	distance_allowed = TRUE
	category = INTERACTION_CAT_NONE
	message = "%USER% cheers for %TARGET%!"

/datum/interaction/cheer/allow_act(mob/living/user, mob/living/target)
	return user.can_speak()

/datum/interaction/highfive
	name = "Highfive"
	category = INTERACTION_CAT_NONE
	message = "%USER% gives %TARGET% a highfive!"

/datum/interaction/highfive/allow_act(mob/living/user, mob/living/target)
	return user.has_active_hand()

/datum/interaction/pat/head
	name = "Headpat"
	message = "%USER% pats %TARGET%'s head!"

/datum/interaction/salute
	name = "Salute"
	distance_allowed = TRUE
	category = INTERACTION_CAT_NONE
	message = "%USER% snaps to a salute for %TARGET%!"

/datum/interaction/salute/allow_act(mob/living/user, mob/living/target)
	return user.has_active_hand()

/datum/interaction/handshake/fistbumb
	name = "Fistbump"
	category = INTERACTION_CAT_NONE
	message = "%USER% bumbs %TARGET%'s fist with theirs!"
