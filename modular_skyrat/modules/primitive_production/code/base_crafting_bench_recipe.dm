/datum/crafting_bench_recipe
	/// The name of the recipe to show
	var/recipe_name = "generic debug recipe"
	/// The items required to create the resulting item
	var/list/recipe_requirements
	/// What the end result of this recipe should be
	var/resulting_item = /obj/item/forging
	/// If we use the materials from the component parts
	var/transfers_materials = TRUE
	/// What types we should not transfer materials from
	var/list/types_to_not_take_materials_from = list()
	/// What type of tool do we need to use to complete this recipe
	var/required_tool_type
	/// How many times should you have to swing the hammer to finish this item
	var/required_good_hits = 6
	/// What skill is relevant to the creation of this item?
	var/relevant_skill = /datum/skill/gaming
	/// How much experience in our relevant skill do we give upon completion?
	var/relevant_skill_reward = 30
