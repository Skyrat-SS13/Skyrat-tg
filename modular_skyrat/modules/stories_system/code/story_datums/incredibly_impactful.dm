/*
	Incredibly Impactful:
		Stories that will likely impact the entire station. It'll be hard for someone to be out of the way of this. They're loud, they're important, and they're
		going to have consequences.
*/

/datum/story_type/incredibly_impactful
	impact = STORY_INCREDIBLY_IMPACTFUL

<<<<<<< HEAD
/*
	Tourism Overload:
		Bad news for the crew, great news for Nanotrasen; After some clever bargaining, Nanotrasen managed to make bank on a great deal to encourage tourism at the station. The travel agency is sending
		over 15 tourists to the station. Brace for impact.
		Actors:
			Ghost:
				5x Obnoxious Tourist
				2x Monolingual Tourist
				3x Wealthy Tourist
				2x Broke Tourist
				3x "Tourist"
*/
/datum/story_type/incredibly_impactful/obnoxious_tourist
	name = "Tourism Overload"
	desc = "A very large amount of tourists are coming to the station. Be afraid."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist = 5,
=======


/*
	Tourism Overload
		Plot Summary:
			Bad news for the crew, great news for Nanotrasen; After some clever bargaining, Nanotrasen managed to make bank on a great deal to encourage tourism at the station. The travel agency is sending
			over 15 tourists to the station. Brace for impact.
		Actors:
			Ghost:
				Obnoxious Tourist (5)
				Monolingual Tourist (2)
				Wealthy Tourist (3)
				Broke Tourist (2)
				"Tourist" (3)
*/
/datum/story_type/incredibly_impactful/tourism_overload
	name = "Tourism Overload"
	desc = "A swarm of up to 15 tourists come to the station."
	actor_datums_to_make = list(
>>>>>>> e3bef5a336e7f5d7c1682f18c0878d79e8acbf4c
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual = 2,
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/wealthy = 3,
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/broke = 2,
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/syndicate = 3,
<<<<<<< HEAD
	)
	maximum_execute_times = 1
=======
		/datum/story_actor/ghost/spawn_in_arrivals/tourist = 5,
	)
>>>>>>> e3bef5a336e7f5d7c1682f18c0878d79e8acbf4c
