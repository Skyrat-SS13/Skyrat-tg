// Start Backgrounds overrides.
/obj/effect/mob_spawn/ghost_role/human/allow_spawn(mob/user, silent = FALSE)
	if(!..())
		return FALSE

	return is_background_valid(user)

/// Checks if a ghost role is allowed in the user's selected backgrounds.
/obj/effect/mob_spawn/ghost_role/human/proc/is_background_valid(mob/user)
	if(!user?.client?.prefs)
		return FALSE

	var/datum/background_info/origin = GLOB.origins[user.client.prefs.origin]
	var/datum/background_info/social_background = GLOB.social_backgrounds[user.client.prefs.social_background]
	var/datum/background_info/employment = GLOB.employments[user.client.prefs.employment]

	if(!origin.is_role_valid(src) || !social_background.is_role_valid(src) || !employment.is_role_valid(src))
		user.show_message(span_warning("Your background doesn't allow for this ghost role!"))

	return TRUE

// End Backgrounds overrides.

/obj/effect/mob_spawn/ghost_role/create(mob/mob_possessor, newname)
	var/load_prefs = FALSE
	//if we can load our own appearance and its not restricted, try
	if(!random_appearance && mob_possessor?.client)
		//if we have gotten to this point, they have already waived their species pref.-- they were told they need to use the specific species already
		if((restricted_species && (mob_possessor?.client?.prefs?.read_preference(/datum/preference/choiced/species) in restricted_species)) || !restricted_species)
			var/appearance_choice = tgui_alert(mob_possessor, "Use currently loaded character preferences?", "Appearance Type", list("Yes", "No"))
			if(appearance_choice == "Yes")
				load_prefs = TRUE

	var/mob/living/carbon/human/spawned_human = ..()

	if(!load_prefs)
		return spawned_human

	spawned_human?.client?.prefs?.safe_transfer_prefs_to(spawned_human)
	spawned_human.dna.update_dna_identity()

	if(quirks_enabled)
		SSquirks.AssignQuirks(spawned_human, spawned_human.client)

	if(loadout_enabled)
		spawned_human.equip_outfit_and_loadout(outfit, spawned_human.client.prefs)

	return spawned_human
