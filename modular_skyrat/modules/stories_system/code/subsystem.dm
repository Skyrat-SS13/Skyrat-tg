SUBSYSTEM_DEF(stories)
	name = "Stories"
	wait = 5 MINUTES
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	/// List of initialized story types to pick from, these are the ones that haven't been used yet
	var/list/to_use_stories = list()

	/// List of intialized types of stories that have already been used
	var/list/used_stories = list()

	/// How much budget the story system has to work with
	var/budget = 0

	/// The last probability without the divisor
	var/last_prob = 1

/datum/controller/subsystem/stories/Initialize()
	for(var/type in subtypesof(/datum/story_type) - list(/datum/story_type/somewhat_impactful))
		to_use_stories += new type
	budget = rand(0, 10)//rand(CONFIG_GET(number/minimum_story_budget), CONFIG_GET(number/maximum_story_budget))
	return SS_INIT_SUCCESS

/datum/controller/subsystem/stories/fire(resumed)
	if(!length(to_use_stories) || !budget)// || (length(used_stories) >= CONFIG_GET(number/maximum_story_amount)))
		return

	var/exponent_divisor = 1
	if(length(used_stories))
		var/datum/story_type/last_used_story = used_stories[length(used_stories)]
		exponent_divisor = last_used_story.impact
	else
		exponent_divisor = STORY_SOMEWHAT_IMPACTFUL

	last_prob *= 2
	if(!prob(last_prob / exponent_divisor))
		return //Add log or smth later
	last_prob = initial(last_prob) // Reset if we make a story

	var/list/copied_to_use_stories = to_use_stories.Copy()

	while(length(copied_to_use_stories))
		var/datum/story_type/picked_story = pick_n_take(copied_to_use_stories)
		if(!picked_story.can_execute())
			continue
		if(!picked_story.execute_story())
			message_admins("Story [picked_story] failed to run; budget staying at [budget].")
			return
		else
			budget -= picked_story.impact
			to_use_stories -= picked_story
			used_stories += picked_story
			message_admins("Story [picked_story] executed; budget is now at [budget].")
			return

/// Gets info of all currently running stories and who is involved
/datum/controller/subsystem/stories/proc/get_stories_info()
	var/list/returned_html = list("<br>")

	returned_html += "<b>Active Stories</b>"

	for(var/datum/story_type/used_story as anything in used_stories)
		returned_html += " - [used_story.build_html_panel_entry()]"

	return returned_html.Join("<br>")

/// Attempts to potentially execute a story roundstart
/datum/controller/subsystem/stories/proc/execute_roundstart_story()
	if(!budget || !length(to_use_stories) || !prob(100)) //make prob chance cfg later
		return FALSE

	var/list/copied_to_use_stories = to_use_stories.Copy()

	while(length(copied_to_use_stories))
		var/datum/story_type/picked_story = pick_n_take(copied_to_use_stories)
		if(!picked_story.roundstart_eligible || !picked_story.can_execute())
			continue
		if(!picked_story.execute_roundstart_story())
			message_admins("Roundstart story [picked_story] failed to run; budget staying at [budget].")
			return
		else
			budget -= picked_story.impact
			to_use_stories -= picked_story
			used_stories += picked_story
			message_admins("Roundstart story [picked_story] executed; budget is now at [budget].")
			return
