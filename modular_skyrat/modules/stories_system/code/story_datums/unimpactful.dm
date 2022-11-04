/*
	Unimpactful:
		Stories that will impact a few people. Easily missable by the crew, but those involved will be aware they're involved when the story makes itself known.
*/

/datum/story_type/unimpactful
	impact = STORY_UNIMPACTFUL

/*
	Tourists
		Plot Summary:
			a litany of different tourists can come to the station, for a variety of reasons. Most of them have a gimmick attached,
			but they're overall pretty unimportant and just exist to interact with and annoy the crew.
		Actors:
			Ghost:
				Varied Tourist (1)
*/
/datum/story_type/unimpactful/obnoxious_tourist
	name = "Obnoxious Tourist"
	desc = "An obnoxious tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist = 1,
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/tourist_syndicate
	name = "\"Tourist\""
	desc = "A syndicate agent disguised as a tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/syndicate = 1,
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/broke_tourist
	name = "Broke Tourist"
	desc = "A broke tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/broke = 1,
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/wealthy_tourist
	name = "Wealthy Tourist"
	desc = "A wealthy tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/wealthy = 1,
	)
	maximum_execute_times = 3

/datum/story_type/unimpactful/monolingual_tourist
	name = "Monolingual Tourist"
	desc = "A monolingual tourist is coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/tourist/monolingual = 1,
	)
	maximum_execute_times = 3

/*
	Drinking With The Boss
		Plot Summary:
			A boss and a few of their worker monkeys are on their after-shift break, coming to the station
			for drinks and rest. They don't do a whole lot but commisserate at the bar and take up more elbow
			room than they deserve.
		Actors:
			Ghost:
				Salaryman (3)
				Boss (1)
*/

/datum/story_type/unimpactful/drinking_with_the_boss
	name = "Drinking With The Boss"
	desc = "Some salarymen and their boss are coming to the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/salaryman_boss = 1,
		/datum/story_actor/ghost/spawn_in_arrivals/salaryman_drinking_with_boss = 3,
	)
	maximum_execute_times = 1
	/// Ref to the boss
	var/mob/living/carbon/human/boss

/datum/story_type/unimpactful/drinking_with_the_boss/Destroy(force, ...)
	boss = null
	return ..()


/*
	Shore Leave
		Plot Summary:
			A group of 3 NT ensigns are on shore leave and decided to come to the nearest station as their
			place of rest. They might get a bit rowdy, but who wouldn't for their first shore leave in a year?
		Actors:
			Ghost:
				Ensign (3)
*/

/datum/story_type/unimpactful/shore_leave
	name = "Shore Leave"
	desc = "A few Nanotrasen Fleet Ensigns are arriving on the station for shore leave."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/shore_leave = 3,
	)
	maximum_execute_times = 1

/*
	Medical Students
		Plot Summary:
			As part of a school funding initiative, various schools in the Spinward Stellar Coalition have partnered with Nanotrasen to get first year medical students some real hands on learning.
			Unfortunately for the station, medical students tend to be very, very unexperienced.
		Actors:
			Ghost:
				Medical Student (3)
*/

/datum/story_type/unimpactful/medical_students
	name = "Medical Students"
	desc = "A group of medical students come to the station for some hands-on learning."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/med_student = 3,
	)
	maximum_execute_times = 2
