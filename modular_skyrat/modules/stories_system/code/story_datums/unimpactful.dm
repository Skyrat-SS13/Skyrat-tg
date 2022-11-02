/*
	Unimpactful:
		Stories that will impact a few people. Easily missable by the crew, but those involved will be aware they're involved when the story makes itself known.
*/

/datum/story_type/unimpactful
	impact = STORY_UNIMPACTFUL

/datum/story_type/unimpactful/obnoxious_tourist
	name = "Obnoxious Tourist"
	desc = "An obnoxious tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist = 1
	)

/datum/story_type/unimpactful/tourist_syndicate
	name = "\"Tourist\""
	desc = "A syndicate agent disguised as a tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/syndicate = 1
	)

/datum/story_type/unimpactful/broke_tourist
	name = "Broke Tourist"
	desc = "A broke tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/broke = 1
	)

/datum/story_type/unimpactful/wealthy_tourist
	name = "Wealthy Tourist"
	desc = "A wealthy tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/wealthy = 1
	)

/datum/story_type/unimpactful/monolingual_tourist
	name = "Monolingual Tourist"
	desc = "A monolingual tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual = 1
	)

