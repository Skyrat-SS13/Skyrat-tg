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
	maximum_execute_times = 3

/datum/story_type/unimpactful/tourist_syndicate
	name = "\"Tourist\""
	desc = "A syndicate agent disguised as a tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/syndicate = 1
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/broke_tourist
	name = "Broke Tourist"
	desc = "A broke tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/broke = 1
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/wealthy_tourist
	name = "Wealthy Tourist"
	desc = "A wealthy tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/wealthy = 1
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/monolingual_tourist
	name = "Monolingual Tourist"
	desc = "A monolingual tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual = 1
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/drinking_with_the_boss
	name = "Drinking With The Boss"
	desc = "Some salarymen and their boss are coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/salaryman_boss = 1,
		/datum/story_actor/ghost/salaryman_drinking_with_boss = 3,
	)
	maximum_execute_times = 1
	/// Ref to the boss
	var/mob/living/carbon/human/boss

/datum/story_type/unimpactful/drinking_with_the_boss/Destroy(force, ...)
	boss = null
	return ..()

/datum/story_type/unimpactful/monolingual_tourist
	name = "Shore Leave"
	desc = "A few Nanotrasen Fleet Ensigns are arriving on the station on shore leave."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/shore_leave = 3
	)
	maximum_execute_times = 1
