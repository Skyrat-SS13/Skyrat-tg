// For crew, see /datum/controller/subsystem/ticker/proc/equip_characters and /mob/dead/new_player/proc/AttemptLateSpawn.

// For ghost roles
/obj/effect/mob_spawn/ghost_role/human/special(mob/living/spawned_mob, mob/mob_possessor)
	. = ..()
	var/mob/living/carbon/human/human = spawned_mob
	human.origin = mob_possessor.client.prefs.origin
	human.social_background = mob_possessor.client.prefs.social_background
	human.employment = mob_possessor.client.prefs.employment
	human.give_passport(mob_possessor.client)
