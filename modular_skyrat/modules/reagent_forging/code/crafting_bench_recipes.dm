/datum/crafting_bench_recipe
	/// The items required to create the resulting item
	var/static/list/recipe_requirements = list()
	/// What the end result of this recipe should be
	var/resulting_item
	/// If we use the materials from the component parts
	var/transfers_materials = TRUE
	/// How many times should you have to swing the hammer to finish this item
	var/required_good_hits = 6
	/// What skill is relevant to the creation of this item?
	var/relevant_skill = /datum/skill/smithing
	/// How much experience in our relevant skill do we give upon completion?
	var/relevant_skill_reward = 30
