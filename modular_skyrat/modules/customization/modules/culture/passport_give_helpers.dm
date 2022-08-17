
// For stationside crew
/datum/job/after_spawn(mob/living/spawned_mob, client/player_client)
	. = ..()
	if(player_client.prefs.culture_faction)
		var/datum/cultural_info/faction/faction = GLOB.culture_factions[player_client.prefs.culture_faction]
		var/obj/item/passport/passport = new faction.passport()
		passport.imprint_owner(spawned_mob)
		if(!spawned_mob.equip_to_slot_if_possible(passport, ITEM_SLOT_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial = TRUE) && !spawned_mob.dropItemToGround(passport, force = TRUE, silent = TRUE))
			log_world("ERROR: Unable to drop item [passport] from [spawned_mob]!")
			message_admins("ERROR: Unable to drop item [passport] from [spawned_mob]!")
			qdel(passport)

// For ghost roles
/obj/effect/mob_spawn/ghost_role/human/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	var/client/player_client = mob_possessor.client
	if(player_client.prefs.culture_faction)
		var/datum/cultural_info/faction/faction = GLOB.culture_factions[player_client.prefs.culture_faction]
		var/obj/item/passport/passport = new faction.passport()
		passport.imprint_owner(spawned_mob)
		if(!spawned_mob.equip_to_slot_if_possible(passport, ITEM_SLOT_BACKPACK, disable_warning = TRUE, bypass_equip_delay_self = TRUE, initial = TRUE) && !spawned_mob.dropItemToGround(passport, force = TRUE, silent = TRUE))
			log_world("ERROR: Unable to drop item [passport] from [spawned_mob]!")
			message_admins("ERROR: Unable to drop item [passport] from [spawned_mob]!")
			qdel(passport)
