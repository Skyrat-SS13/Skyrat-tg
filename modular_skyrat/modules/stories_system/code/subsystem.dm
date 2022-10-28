SUBSYSTEM_DEF(stories)
	name = "Stories"
	wait = 5 MINUTES
	flags = SS_TICKER
	priority = FIRE_PRIORITY_MOUSE_ENTERED
	runlevels = RUNLEVELS_DEFAULT

	/// List of story TYPEPATHS to pick from, these are the ones that haven't been used yet
	var/list/to_use_stories

	/// List of intialized types of stories that have already been used
	var/list/used_stories = list()

	/// How much budget the story system has to work with
	var/budget = 0

	/// The last probability without the divisor
	var/last_prob = 2

/datum/controller/subsystem/stories/Initialize()
	to_use_stories = subtypesof(/datum/story_type) - list(/datum/story_type/somewhat_impactful)
	budget = rand(CONFIG_GET(number/minimum_story_budget), CONFIG_GET(number/maximum_story_budget))
	return SS_INIT_SUCCESS

/datum/controller/subsystem/stories/fire(resumed)
	if(!length(to_use_stories) || !budget || (length(used_stories) >= CONFIG_GET(number/maximum_story_amount)))
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
		if(initial(picked_story.impact) > budget)
			continue
		var/datum/story_type/initialized_story = new picked_story
		if(!initialized_story.execute_story())
			message_admins("Story [initialized_story] failed to run; budget staying at [budget].")
			return
		else
			budget -= initialized_story.impact
			to_use_stories -= picked_story
			used_stories += initialized_story
			message_admins("Story [initialized_story] executed; budget is now at [budget].")
			return
