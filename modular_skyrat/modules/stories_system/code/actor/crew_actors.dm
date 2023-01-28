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

/datum/story_actor/crew/gangster
	name = "Gangster (No Color)"
	actor_info = ""
	/// Name of faction to add to the gangsters
	var/faction_to_add
	/// The type of item to give them
	var/box_to_give

/datum/story_actor/crew/gangster/handle_spawning(mob/living/carbon/human/picked_spawner, datum/story_type/current_story)
	. = ..()
	var/datum/story_type/very_impactful/the_deal/current_deal = current_story
	actor_goal = replacetext(actor_goal, "%LOCATION%", current_deal.deal_location)
	actor_info = replacetext(actor_info, "%LOCATION%", current_deal.deal_location)
	picked_spawner.faction |= faction_to_add
	picked_spawner.put_in_hands(new box_to_give, ignore_animation = TRUE)

/datum/story_actor/crew/gangster/red
	name = "Gangster (Red)"
	actor_info = "You and your buddies are part of the better gang in this station, the Reds. \
	Problem is, the Blues have something the boss wants, so they have a case of cash to give 'em in exchange. \
	The boss needs you there at %LOCATION% as well for muscle, and if anything goes sideways."
	actor_goal = "Support your boss as they have the deal at %LOCATION% with the Blues going down."
	faction_to_add = FACTION_RED
	box_to_give = /obj/item/storage/box/red_clothing

/datum/story_actor/crew/gangster/red/boss
	name = "Gangster (Red Boss)"
	actor_info = "You're the boss of the Red gang on-station, far better than the Blue pricks. \
	Unfortunately, tough times have forced you to make a deal with them for some goods you need. \
	It'll be going down at %LOCATION% soon. \
	Getting the cash wasn't an issue, but it's an awful lot to give to the Blues. \
	Depending on their muscle, it might be possible to pull one over on 'em..."
	actor_goal = "Do the deal at %LOCATION% with the Blues to trade your case of cash for their case of the goods, \
	or attempt to keep both and pull one over on them."
	box_to_give = /obj/item/storage/box/red_clothing/boss


/datum/story_actor/crew/gangster/blue
	name = "Gangster (Blue)"
	actor_info = "You and your buddies are part of the better gang in this station, the Blues. \
	Problem is, you're all a bit strapped for cash, and the Reds came knocking for some goods we got ahold of. \
	There's a deal going down soon at %LOCATION% for the trade, and your boss needs you there for support and muscle."
	actor_goal = "Support your boss as they have the deal at %LOCATION% with the Reds going down."
	faction_to_add = FACTION_BLUE
	box_to_give = /obj/item/storage/box/blue_clothing

/datum/story_actor/crew/gangster/blue/boss
	name = "Gangster (Blue Boss)"
	actor_info = "You're the boss of the Blue gang on-station, far better than the Red cunts. \
	Unfortunately, tough times have forced you to make a deal with them for some cash you need. \
	The deal will happen at %LOCATION% soon. \
	Getting the goods a while back wasn't easy, and it sucks to have to give it up to the Reds. \
	Depending on their muscle, it might be possible to pull one over on 'em..."
	actor_goal = "Do the deal at %LOCATION% with the Reds to trade your case of the goods for their case of cash, \
	or attempt to keep both and pull one over on them."
	box_to_give = /obj/item/storage/box/blue_clothing/boss

/datum/story_actor/crew/ominous
	name = "Ominous"
	actor_info = "You never meant for it to end like that.\n\n\
	You did everything you could, but it still wasn't enough. Even today, the memories of that moment stalk you like a killer. \
	Yet words fail you whenever you try to talk about it, it was just that horrifying. You'll never be the same… and you're certain to make everyone aware of the fact."
	actor_goal = "Survive the shift. Provide helpful advice. Constantly make references to 'the event'."

/datum/story_actor/crew/apprentice
	name = "Apprentice"
	actor_info = "Long have you trained, and at last the day is upon you!\n\n\
	You've scoured the SpaceNet for every crumb of information, thrown yourself at the foot of every Zoldorf machine, and attended one too many Astrology classes. \
	But now, the power rests within you. The pathways of destiny have been made clear, and at last, you understand how to bend fate to your whims… \
	so long as there are some credits to be had."
	actor_goal = "Perform Tarot readings. “Accurately” predict the future. Survive the shift (with pockets full of credits)."

/datum/story_actor/crew/apprentice/handle_spawning(mob/living/carbon/human/picked_spawner, datum/story_type/current_story)
	. = ..()
	picked_spawner.put_in_hands(new /obj/item/toy/cards/deck/tarot, ignore_animation = TRUE)
