/datum/story_actor/crew

/datum/story_actor/crew/handle_spawning(mob/living/carbon/human/picked_spawner, datum/story_type/current_story)
	. = ..()
	if(!.)
		return FALSE
	if(length(actor_outfits))
		picked_spawner.equipOutfit(pick(actor_outfits))
	current_story.mind_actor_list[picked_spawner.mind] = src
	if(inform_player) // If they aren't aware they're in a story, we don't want to spoil it by showing them the info!
		info_button = new(src)
		info_button.Grant(picked_spawner)


/datum/story_actor/crew/mob_debt
	name = "Mob Debtor"
	actor_info = "You were in a bit of a rough spot, so you got a loan from a guy you knew's friend, more than you could ever pay back. Not like they'll be looking for you all the way out here, heheh."

/datum/story_actor/crew/mob_debt/handle_spawning(mob/living/carbon/human/picked_spawner, datum/story_type/current_story)
	. = ..()
	if(istype(current_story, /datum/story_type/somewhat_impactful/mob_money))
		var/datum/story_type/somewhat_impactful/mob_money/mob_plot = current_story
		mob_plot.poor_sod = picked_spawner
