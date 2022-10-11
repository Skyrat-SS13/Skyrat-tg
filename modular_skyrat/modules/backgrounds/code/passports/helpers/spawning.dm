// For crew, see /datum/controller/subsystem/ticker/proc/equip_characters and /mob/dead/new_player/proc/AttemptLateSpawn.

// For ghost roles
/obj/effect/mob_spawn/ghost_role/human/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	var/mob/living/carbon/human/human = spawned_mob
	human.give_passport(mob_possessor.client)
	human.origin = mob_possessor.client.prefs.origin
	human.social_background = mob_possessor.client.prefs.social_background
	human.employment = mob_possessor.client.prefs.employment

/// Tries to give a passport to a human mob. If the user hasn't selected a social backgound, they'll spawn with the default passport.
/mob/living/carbon/human/proc/give_passport(client/player_client)
	if(!player_client && !client)
		return
	if(!player_client)
		player_client = client

	var/obj/item/passport/passport = /obj/item/passport
	if(player_client.prefs.social_background)
		var/datum/background_info/social_background/faction = GLOB.social_backgrounds[player_client.prefs.social_background]
		passport = faction.passport

	passport = new passport()
	passport.imprint_owner(src)
	if(!equip_to_slot_if_possible(passport, ITEM_SLOT_PASSPORT, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial = TRUE) && !dropItemToGround(passport, force = TRUE, silent = TRUE))
		log_world("ERROR: Unable to drop item [passport] from [src] (\ref[src])!")
		message_admins("ERROR: Unable to drop item [passport] from [src] (\ref[src])!")
		// Not qdeleting cause admins might want to debug this.
