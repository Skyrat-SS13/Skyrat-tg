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
	TPS Reports (Multiple Departments):
		Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology and leverage our core competencies in order to holistically
		administrate exceptional synergy. We'll set a brand trajectory using management philosophies to advance our marketshare vis-a-vis via proven methodologies with strong committment to quality effectively enhancing
		corporate synergy. They will transition the department by awareness of functionality to promote viability providing their supply chain with diversity to distill their identity through client-centric solutions and synergy.
		At the end of the day, the department must monetize their assets via the fundamentals of change to visualize a value added experience that will grow the business infrastructure to monetize their assets. These managers
		will bring to the table our capitalized reputation proactively overseeing day to day operations, services and deliverables with cross-platform innovation, and networking will bring seamless integration in a robust and
		scalable bleeding edge and next generation, best of breed, will succeed in the department achieving globalization and gaining traction in the marketplace in a mission critical incentivized flexible solution for our customer
		base with a paradigm shift.
		Actors:
			Ghost:
				Middle Management
*/

/datum/story_type/unimpactful/tps_reports_security
	name = "TPS Reports (Security)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/security = 1,
	)

/datum/story_type/unimpactful/tps_reports_service
	name = "TPS Reports (Service)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/service = 1,
	)

/datum/story_type/unimpactful/tps_reports_science
	name = "TPS Reports (Science)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/science = 1,
	)

/datum/story_type/unimpactful/tps_reports_engineering
	name = "TPS Reports (Engineering)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/engineering = 1,
	)

/datum/story_type/unimpactful/tps_reports_medbay
	name = "TPS Reports (Medbay)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/medbay = 1,
	)

/datum/story_type/unimpactful/tps_reports_cargo
	name = "TPS Reports (Cargo)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/cargo = 1,
	)
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
