/obj/item/trim_token
	name = "generic trim token"
	desc = "Base for other trim tokens, if you somehow find this, yell at your local coders."
	icon = 'icons/obj/economy.dmi'
	icon_state = "coin_valid"
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = INDESTRUCTIBLE
	usesound = 'sound/weapons/taserhit.ogg'
	// Name of the job of that trim. I tried to do it otherwise but it was annoying so this is how it's going to be.
	var/assignment = "Unassigned"
	// Trim to add to the ID.
	var/datum/id_trim/token_trim
	// List of trim paths of trims of which this token can be used. Respect of that requirement is based on the following variable.
	var/list/valid_trims_paths = list()
	// List of trims of which this token can be used. Respect of that requirement is based on the following variable.
	// Generated in Initialize(), as such DO NOT ADD ANYTHING TO THIS, ADD TO valid_trims_paths
	var/list/valid_trims = list()
	// Do we need to follow the required trim? FALSE by default.
	var/has_required_trim = FALSE
	// Do we force the access update? TRUE by default.
	var/force_access = TRUE
	// Does it have multiple uses? 1 by default, set to INFINITE (so -1, not any lower) to not have it be consumed.
	var/uses = 1

/obj/item/trim_token/Initialize(mapload)
	. = ..()
	// Making sure we have actual paths to avoid issues
	if(length(valid_trims_paths))
		for(var/trim_path in valid_trims_paths)
			// This is needed because trims are working off of singletons, which mean there's technically only one of each trim
			// Complicated to explain in a comment but this should work.
			valid_trims += list(SSid_access.trim_singletons_by_path[trim_path])
