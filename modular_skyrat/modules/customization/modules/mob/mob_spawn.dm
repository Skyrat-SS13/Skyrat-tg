/// Allows for prefloaded characters.
/obj/effect/mob_spawn/ghost_role/equip(mob/living/spawned_mob)
	if(!random_appearance && ishuman(spawned_mob) && spawned_mob.client)
		var/appearance_choice = tgui_alert(spawned_mob, "Use currently loaded character preferences?", "Appearance Type", list("Yes", "No"))
		if(appearance_choice == "Yes")
			var/mob/living/carbon/human/spawned_human = spawned_mob
			spawned_mob?.client?.prefs?.safe_transfer_prefs_to(spawned_human)
			spawned_human.dna.update_dna_identity()
			if(quirks_enabled)
				SSquirks.AssignQuirks(spawned_human, spawned_mob.client)
			if(loadout_enabled)
				spawned_human.equip_outfit_and_loadout(outfit, spawned_mob.client.prefs, outfit_override = outfit_override)
			return
	. = ..()
