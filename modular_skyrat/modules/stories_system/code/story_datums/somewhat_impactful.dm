/*
	Unimpactful:
		Stories that will impact around a department of people or so. People in the group will notice, and people really paying attention to the crew will likely see the results.
		Consider it a B-plot.


	Stories:
	Bureaucratic Overload
		Plot Summary:
			Central Command has sent extra middle management to oversee %DEPARTMENT%.
			A few managers will arrive on the station to efficiently operationalize our strategies, invest in world class technologies, and
			leverage our core competencies in order to holistically administrate exceptional synergy. By using management philosophies, they
			will set a brand trajectory, advancing the market-share vis-a-vis, a proven methodology with a strong committment to quality effectively
			enhancing corporate synergy.
		Actors:
			Ghost:
				Middle Manager (5)
	Labor Agitator
		Plot Summary:
			A man of the people has arrived. A real working class kinda spaceman. Really believes in the struggle of the proletariat. And he's here on the station, ready to
			ask the crew if they've considered joining a union. Coincidentally, there's a fresh faced middle manager looking to make his quarterly report extra profitable, by
			any means necessary.
		Actors:
			Ghost:
				Pick From:
					Labor Organizer
					Direct Action Labor Rights Activist
					Work-To-Rule Advocate
				Middle Manager
	Football Hooligans:
		Plot Summary:
			A group of the good old boys who just got here on their drunken parade from a game of footy between Terry F.C. and Manchester United. Terry F.C. went five nil as
			they usually do, and the boys are going wild as usual. The crew is going to have their hands full with the partying football hooligans and the sports-patriotism
			they'll get up to this shift.
		Actors:
			Ghost:
				Football Hooligans (3)


*/


/datum/story_type/somewhat_impactful
	impact = STORY_SOMEWHAT_IMPACTFUL


/*
	Central Command Inspector
		Plot Summary:
			CentCom has a funny habit of sending down "surprise" inspectors to see what the station's up to,
			despite them rarely liking the results of said inspection. Regardless, they've sent one to make sure things
			are in... some sort of shape, if not good shape.
		Actors:
			Ghost:
				Central Command Inspector (1)
*/
/datum/story_type/somewhat_impactful/centcom_inspector
	name = "Central Command Inspector"
	desc = "A Central Command inspector has come to make sure the station is in... if not good shape, a shape."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/centcom_inspector = 1,
	)

/datum/story_type/somewhat_impactful/centcom_inspector/execute_story()
	. = ..()
	if(!.)
		return FALSE
	addtimer(CALLBACK(src, .proc/inform_station), 3 MINUTES)

/datum/story_type/somewhat_impactful/centcom_inspector/proc/inform_station()
	print_command_report("Hello, an inspector will be arriving shortly for a surprise inspection, ensure they have a pleasant report.", announce = TRUE)


/*
	Syndicate Central Command Inspector
		Plot Summary:
			CentCom has a funny habit of sending down "surprise" inspectors to see what the station's up to,
			which provides an opening for a Syndicate agent to slip in, knock out the real inspector, and assume
			their identity. Very handy when there's things to do and items of value to be stolen, especially %ITEM%.
		Actors:
			Ghost:
				Syndicate Central Command Inspector (1)
*/
/datum/story_type/somewhat_impactful/centcom_inspector/syndicate
	name = "Syndicate Central Command Inspector"
	desc = "A Syndicate agent has impersonated a CentCom inspector, to steal a high-value item while maintaining their cover."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/centcom_inspector/syndicate = 1,
	)

/*
	Mob Money
		Plot Summary:
			A crewmember, %NAME%, has taken out a loan from the space mafia.
			However, their fundamental issue with the plan is that they never paid back, and now the space mafia's looking to collect,
			so they sent a few goons out to the station to shake 'em down for the 20 grand they owe the boss. Good thing for the collectors,
			immediate skeletal repositioning is a valid method of money collection.
		Actors:
			Ghost:
				Mafioso (2)
			Crew:
				Debtor (1)
*/

/datum/story_type/somewhat_impactful/mob_money
	name = "Mob Money"
	desc = "Some crewman's gotten themselves involved in organized crime, and now owes 20k to some mafiosos."
	actor_datums_to_make = list(
		/datum/story_actor/ghost/mafioso = 2,
		/datum/story_actor/crew/mob_debt = 1,
	)
	/// Ref of the guy the mafiosos are hunting
	var/mob/living/carbon/human/poor_sod

/datum/story_type/somewhat_impactful/mob_money/Destroy(force, ...)
	poor_sod = null
	return ..()

