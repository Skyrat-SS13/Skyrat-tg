
// For stationside crew
/datum/job/after_spawn(mob/living/spawned_mob, client/player_client)
	. = ..()
	give_passport(spawned_mob, player_client)

// For ghost roles
/obj/effect/mob_spawn/ghost_role/human/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	give_passport(spawned_mob, mob_possessor.client)

/// Tries to give a passport to a living mob. If the user hasn't selected an origin, they'll spawn with the default passport.
/proc/give_passport(mob/living/spawned_mob, client/player_client)
	var/obj/item/passport/passport = /obj/item/passport
	if(player_client.prefs.social_background)
		var/datum/background_info/social_background/faction = GLOB.social_backgrounds[player_client.prefs.social_background]
		passport = faction.passport

	passport = new passport()
	passport.imprint_owner(spawned_mob)
	if(!spawned_mob.equip_to_slot_if_possible(passport, ITEM_SLOT_PASSPORT, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial = TRUE) && !spawned_mob.dropItemToGround(passport, force = TRUE, silent = TRUE))
		log_world("ERROR: Unable to drop item [passport] from [spawned_mob]!")
		message_admins("ERROR: Unable to drop item [passport] from [spawned_mob]!")
		qdel(passport)
