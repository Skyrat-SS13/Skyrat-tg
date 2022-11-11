/*
	Very Impactful:
		Stories that will likely impact multiple departments and the crew in general. If you don't keep a finger on the station's pulse, you could miss these, but it's
		unlikely the crew won't have some idea this is going on.
*/



/datum/story_type/very_impactful
	impact = STORY_VERY_IMPACTFUL

/*
	The Deal
		Plot Summary:
			Two opposing gangs are on the station, the Reds and the Blues.
			The Reds have a briefcase of "the goods", and the Blues have a briefcase of "the paper".
			It's a mutually beneficial deal, but hey, if one side could walk away with both, it'd all be worth it, wouldn't it?
		Actors:
			Crew:
				Red Leader (1)
				Red (2)
				Blue Leader (1)
				Blue (2)
*/
/datum/story_type/very_impactful/the_deal
	name = "The Deal"
	desc = "Two opposing gangs are looking to make a deal with each other for some goods."
	actor_datums_to_make = list(
		/datum/story_actor/crew/gangster/red/boss = 1,
		/datum/story_actor/crew/gangster/blue/boss = 1,
		/datum/story_actor/crew/gangster/red = 2,
		/datum/story_actor/crew/gangster/blue = 2,
	)

	/// Where is the deal taking place
	var/deal_location

	/// Possible choices for where the deal can happen
	var/static/list/possible_deal_locations = list(
		"the Bar",
		"the Cargo Lobby",
		"the Chapel",
		"outside the Bridge",
		"the Kitchen",
		"the lobby of Medbay",
	) // all fairly public spaces


/datum/story_type/very_impactful/the_deal/execute_story()
	deal_location = pick(possible_deal_locations)

	return ..()


/datum/story_type/very_impactful/the_deal/execute_roundstart_story()
	deal_location = pick(possible_deal_locations)

	return ..()
