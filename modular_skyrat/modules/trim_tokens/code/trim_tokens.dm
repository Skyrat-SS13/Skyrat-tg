/obj/item/trim_token
	name = "generic trim token"
	desc = "Base for other trim tokens, if you somehow find this, yell at your local coders."
	icon = 'icons/obj/economy.dmi'
	icon_state = "coin_valid"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = INDESTRUCTIBLE
	usesound = 'sound/weapons/taserhit.ogg'
	// Trim to add to the ID.
	var/datum/id_trim/token_trim
	// List of trims of which this token can be used. Respect of that requirement is based on the following variable.
	var/list/valid_trims = list()
	// Do we need to follow the required trim? FALSE by default.
	var/has_required_trim = FALSE
	// Do we force the access update? TRUE by default.
	var/force_access = TRUE
	// Does it have multiple uses? 1 by default, set to INFINITE (so -1, not any lower) to not have it be consumed.
	var/uses = 1

/obj/item/trim_token/Initialize()
	. = ..()

/obj/item/trim_token/security_sergeant
	name = "security sergeant trim token"
	desc = "A token awarded to those seen fit to take the role of Security Sergeant."
	token_trim = /datum/id_trim/job/security_sergeant
	valid_trims = list(/datum/id_trim/job/security_officer)
	has_required_trim = TRUE
