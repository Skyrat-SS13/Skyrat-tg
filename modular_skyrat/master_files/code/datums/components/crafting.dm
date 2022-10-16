/datum/mind/proc/unteach_crafting_recipe(recipe)
	if(!learned_recipes)
		return
	learned_recipes &= ~recipe
