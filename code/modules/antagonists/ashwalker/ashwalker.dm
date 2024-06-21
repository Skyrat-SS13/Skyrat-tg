/datum/antagonist/ashwalker
	name = "\improper Ash Walker"
	job_rank = ROLE_LAVALAND
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	prevent_roundtype_conversion = FALSE
	antagpanel_category = ANTAG_GROUP_ASHWALKERS
	suicide_cry = "I HAVE NO IDEA WHAT THIS THING DOES!!"
	count_against_dynamic_roll_chance = FALSE
	var/datum/team/ashwalkers/ashie_team

/datum/antagonist/ashwalker/create_team(datum/team/ashwalkers/ashwalker_team)
	if(ashwalker_team)
		ashie_team = ashwalker_team
		objectives |= ashie_team.objectives
	else
		ashie_team = new

/datum/antagonist/ashwalker/get_team()
	return ashie_team

/datum/antagonist/ashwalker/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	UnregisterSignal(old_body, COMSIG_MOB_EXAMINATE)
	RegisterSignal(new_body, COMSIG_MOB_EXAMINATE, PROC_REF(on_examinate))

/datum/antagonist/ashwalker/on_gain()
	. = ..()
	RegisterSignal(owner.current, COMSIG_MOB_EXAMINATE, PROC_REF(on_examinate))
	//owner.teach_crafting_recipe(/datum/crafting_recipe/skeleton_key) //SKYRAT EDIT REMOVAL - ASH RITUALS

/datum/antagonist/ashwalker/on_removal()
	. = ..()
	UnregisterSignal(owner.current, COMSIG_MOB_EXAMINATE)

/datum/antagonist/ashwalker/proc/on_examinate(datum/source, atom/A)
	SIGNAL_HANDLER

	if(istype(A, /obj/structure/headpike))
		owner.current.add_mood_event("oogabooga", /datum/mood_event/sacrifice_good)

/datum/team/ashwalkers
	name = "Ash Walker Tribe"
	member_name = "Ash Walker"
	///A list of "worthy" (meat-bearing) sacrifices made to the Necropolis
	var/sacrifices_made = 0
	///A list of how many eggs were created by the Necropolis
	var/eggs_created = 0

/datum/team/ashwalkers/roundend_report()
	var/list/report = list()

	report += span_header("An Ash Walker Tribe inhabited the wastes...</span><br>")
	if(length(members)) //The team is generated alongside the tendril, and it's entirely possible that nobody takes the role.
		report += "The [member_name]s were:"
		report += printplayerlist(members)

		var/datum/objective/protect_object/necropolis_objective = locate(/datum/objective/protect_object) in objectives

		if(necropolis_objective)
			objectives -= necropolis_objective //So we don't count it in the check for other objectives.
			report += "<b>The [name] was tasked with defending the Necropolis:</b>"
			if(necropolis_objective.check_completion())
				report += span_greentext("<span class='header'>The nest stands! Glory to the Necropolis!</span><br>")
			else
				report += span_redtext("<span class='header'>The Necropolis was destroyed, the tribe has fallen...</span><br>")

		if(length(objectives))
			report += span_header("The [name]'s other objectives were:")
			printobjectives(objectives)

		report += "The [name] managed to perform <b>[sacrifices_made]</b> sacrifices to the Necropolis. From this, the Necropolis produced <b>[eggs_created]</b> Ash Walker eggs."

	else
		report += "<b>But none of its eggs hatched!</b>"

	return "<div class='panel redborder'>[report.Join("<br>")]</div>"
