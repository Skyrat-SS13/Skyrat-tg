/datum/story_actor/crew

/datum/story_actor/crew/handle_spawning(mob/living/carbon/human/picked_spawner)
	. = ..()
	if(!.)
		return FALSE
	if(length(actor_outfits))
		picked_spawner.equipOutfit(pick(actor_outfits))



/datum/story_actor/crew/mob_debt
	name = "Mob Debtor"
	actor_info = "You were in a bit of a rough spot, so you got a loan from a guy you knew's friend, more than you could ever pay back. Not like they'll be looking for you all the way out here, heheh."
