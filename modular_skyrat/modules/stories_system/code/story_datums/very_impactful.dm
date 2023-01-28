/*
	Very Impactful:
		Stories that will likely impact multiple departments and the crew in general. If you don't keep a finger on the station's pulse, you could miss these, but it's
		unlikely the crew won't have some idea this is going on.
*/



/datum/story_type/very_impactful
	impact = STORY_VERY_IMPACTFUL

/*
	Contractors:
		Nanotrasen sold a chunk of the station's hallways to the highest bidder for a tidy sum. As a result, a team of unionized construction workers and their union rep are on the station about to tear up
		a section of your hallways to build a business for their capitalist overlords. The station's engineers and it's crew will have to contend with this construction project, the zoning requirements,
		and all that hassle, all while dodging union recruitment attempts by their union rep.
		Actors:
			Ghost:
				Small Business Owner
				Construction Foreman
				Construction Union Rep
				3x Construction Workers
*/

/datum/story_type/very_impactful/contractors
	name = "Contractors"
	desc = "A small business owner has purchased a chunk of the station's hallways for business development. The buyer has arrived with a unionized construction crew \
	to build their new business right in the middle of traffic on the station."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/small_business_owner = 1,
		/datum/story_actor/ghost/spawn_in_arrivals/construction_foreman = 1,
		/datum/story_actor/ghost/spawn_in_arrivals/union_rep = 1,
		/datum/story_actor/ghost/spawn_in_arrivals/construction_worker = 3,
	)

/*
	Management Overload (Multiple Departments):
		Nanotrasen has seen fit to send A LOT middle management for a department to help efficiently operationalize our strategy to invest in world class technology and leverage our core competencies in order to holistically
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

/datum/story_type/very_impactful/tps_reports_security
	name = "Management Overload (Security)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/security = 1,
	)

/datum/story_type/very_impactful/tps_reports_service
	name = "Management Overload (Service)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/service = 5,
	)

/datum/story_type/very_impactful/tps_reports_science
	name = "Management Overload (Science)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/science = 5,
	)

/datum/story_type/very_impactful/tps_reports_engineering
	name = "Management Overload (Engineering)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/engineering = 5,
	)

/datum/story_type/very_impactful/tps_reports_medbay
	name = "Management Overload (Medbay)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/medbay = 5,
	)

/datum/story_type/very_impactful/tps_reports_cargo
	name = "Management Overload (Cargo)"
	desc = "Nanotrasen has seen fit to send middle management for a department to help efficiently operationalize our strategy to invest in world class technology \
	and leverage our core competencies in order to holistically administrate exceptional synergy."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/spawn_in_arrivals/middle_management/cargo = 5,
	)

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
