/obj/effect/mob_spawn/ghost_role/create(mob/mob_possessor, newname)
	var/load_prefs = FALSE
	//if we can load our own appearance and its not restricted, try
	if(!random_appearance && mob_possessor?.client)
		//if we have gotten to this point, they have already waived their species pref.-- they were told they need to use the specific species already
		if((restricted_species && (mob_possessor?.client?.prefs?.read_preference(/datum/preference/choiced/species) in restricted_species)) || !restricted_species)
			var/appearance_choice = tgui_alert(mob_possessor, "Use currently loaded character preferences?", "Appearance Type", list("Yes", "No"))
			if(appearance_choice == "Yes")
				load_prefs = TRUE

	var/mob/living/carbon/human/spawned_human = ..(mob_possessor, newname, load_prefs)

	if(!load_prefs)
		return spawned_human

	spawned_human?.client?.prefs?.safe_transfer_prefs_to(spawned_human)
	spawned_human.dna.update_dna_identity()

	if(quirks_enabled)
		SSquirks.AssignQuirks(spawned_human, spawned_human.client)

	if(loadout_enabled)
		spawned_human.equip_outfit_and_loadout(outfit, spawned_human.client.prefs)
	else
		equip(spawned_human)

	return spawned_human

/// This edit would cause somewhat ugly diffs, so I'm just replacing it.
/// Original proc in code/modules/mob_spawn/mob_spawn.dm ~line 39.
/obj/effect/mob_spawn/create(mob/mob_possessor, newname, is_pref_loaded)
	var/mob/living/spawned_mob = new mob_type(get_turf(src)) //living mobs only
	name_mob(spawned_mob, newname)
	special(spawned_mob, mob_possessor)
	if(!is_pref_loaded)
		equip(spawned_mob)
	return spawned_mob
