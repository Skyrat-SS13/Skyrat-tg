/// How many planks of wood are required to complete a weapon?
#define WEAPON_COMPLETION_WOOD_AMOUNT 2

/// The number of hits you are set back when a bad hit is made
#define BAD_HIT_PENALTY 3

/obj/structure/crafting_bench
	name = "generic workbench"
	desc = "A crafting bench fitted with tools, securing mechanisms, and a steady surface for... something?"
	icon = 'modular_skyrat/modules/primitive_production/icons/forge_structures.dmi'
	icon_state = "forging_bench"

	anchored = TRUE
	density = TRUE

	/// What the currently picked recipe is
	var/datum/crafting_bench_recipe/selected_recipe
	/// How many successful hits towards completion of the item have we done
	var/current_hits_to_completion = 0
	/// The cooldown from the last hit before we allow another 'good hit' to happen
	COOLDOWN_DECLARE(hit_cooldown)
	/// What recipes are we allowed to choose from?
	var/list/allowed_choices = list()
	/// Radial options for recipes in the allowed_choices list, populated by populate_radial_choice_list
	var/list/radial_choice_list = list()
	/// An associative list of names --> recipe path that the radial recipe picker will choose from later
	var/list/recipe_names_to_path = list()

/obj/structure/crafting_bench/Initialize(mapload)
	. = ..()
	populate_radial_choice_list()

/obj/structure/crafting_bench/proc/populate_radial_choice_list()
	if(!length(allowed_choices))
		return

	if(length(radial_choice_list) && length(recipe_names_to_path)) // We already have both of these and don't need it, if this is called after these are generated for some reason
		return

	for(var/recipe in allowed_choices)
		var/datum/crafting_bench_recipe/recipe_to_take_from = new recipe()
		var/obj/recipe_resulting_item = recipe_to_take_from.resulting_item
		radial_choice_list[recipe_to_take_from.recipe_name] = image(icon = initial(recipe_resulting_item.icon), icon_state = initial(recipe_resulting_item.icon_state))
		recipe_names_to_path[recipe_to_take_from.recipe_name] = recipe
		qdel(recipe_to_take_from)


/obj/structure/crafting_bench/examine(mob/user)
	. = ..()

	if(!selected_recipe)
		return

	var/obj/resulting_item = selected_recipe.resulting_item
	. += span_notice("The selected recipe's resulting item is: <b>[initial(resulting_item.name)]</b> <br>")
	var/obj/required_tool = selected_recipe.required_tool_type
	. += span_notice("Gather the required materials, listed below, <b>near the bench</b>, then use a [initial(required_tool.name)] to complete it! <br>")

	if(!length(selected_recipe.recipe_requirements))
		. += span_boldwarning("Somehow, this recipe has no requirements, report this as this shouldn't happen.")
		return

	for(var/obj/requirement_item as anything in selected_recipe.recipe_requirements)
		if(!selected_recipe.recipe_requirements[requirement_item])
			. += span_boldwarning("[requirement_item] does not have an amount required set, this should not happen, report it.")
			continue

		. += span_notice("<b>[selected_recipe.recipe_requirements[requirement_item]]</b> - [initial(requirement_item.name)]")

	return .

/obj/structure/crafting_bench/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	update_appearance()

	if(selected_recipe)
		clear_recipe()
		balloon_alert_to_viewers("recipe cleared")
		update_appearance()
		return

	var/chosen_recipe = show_radial_menu(user, src, radial_choice_list, radius = 38, require_near = TRUE, tooltips = TRUE)

	if(!chosen_recipe)
		balloon_alert(user, "no recipe choice")
		return

	var/datum/crafting_bench_recipe/recipe_to_use = recipe_names_to_path[chosen_recipe]
	selected_recipe = new recipe_to_use

	balloon_alert(user, "recipe chosen")
	update_appearance()

/// Clears the current recipe and sets hits to completion to zero
/obj/structure/crafting_bench/proc/clear_recipe()
	QDEL_NULL(selected_recipe)
	current_hits_to_completion = 0

/obj/structure/crafting_bench/attackby(obj/item/attacking_item, mob/user, params)
	if(!selected_recipe)
		return ..()

	if(!istype(attacking_item, selected_recipe.required_tool_type))
		return ..()

	if(!can_we_craft_this(selected_recipe.recipe_requirements))
		balloon_alert(user, "missing ingredients")
		return TRUE

	if(selected_recipe.sound_the_tool_makes)
		playsound(src, selected_recipe.sound_the_tool_makes, 50, TRUE)

	if(!COOLDOWN_FINISHED(src, hit_cooldown)) // If you hit it before the cooldown is done, you get a bad hit, setting you back three good hits
		current_hits_to_completion -= BAD_HIT_PENALTY

		if(current_hits_to_completion <= -(selected_recipe.required_good_hits))
			balloon_alert_to_viewers("recipe failed")
			clear_recipe()
			return TRUE

		balloon_alert(user, "bad hit")
		user.changeNext_move(CLICK_CD_RAPID)
		return TRUE

	if((current_hits_to_completion >= selected_recipe.required_good_hits) && !length(contents))
		var/list/things_to_use = can_we_craft_this(selected_recipe.recipe_requirements, return_ingredients_list = TRUE)

		create_thing_from_requirements(things_to_use, selected_recipe, user, selected_recipe.relevant_skill, selected_recipe.relevant_skill_reward)
		return TRUE

	current_hits_to_completion++
	user.changeNext_move(CLICK_CD_RAPID)
	balloon_alert(user, "good hit")
	user.mind.adjust_experience(selected_recipe.relevant_skill, selected_recipe.relevant_skill_reward / 15) // Good hits towards the current item grants experience in that skill

	var/skill_modifier = user.mind.get_skill_modifier(selected_recipe.relevant_skill, SKILL_SPEED_MODIFIER) * 1 SECONDS
	COOLDOWN_START(src, hit_cooldown, skill_modifier)

	return TRUE

/obj/structure/crafting_bench/wrench_act(mob/living/user, obj/item/tool)
	tool.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return TOOL_ACT_TOOLTYPE_SUCCESS

/// Takes the given list of item requirements and checks the surroundings for them, returns TRUE unless return_ingredients_list is set, in which case a list of all the items to use is returned
/obj/structure/crafting_bench/proc/can_we_craft_this(list/required_items, return_ingredients_list = FALSE)
	if(!length(required_items))
		message_admins("[src] just tried to check for ingredients nearby without having a list of items to check for!")
		return FALSE

	var/list/surrounding_items = list()
	var/list/requirement_items = list()

	for(var/obj/item/potential_requirement in get_environment())
		surrounding_items += potential_requirement

	for(var/obj/item/requirement_path as anything in required_items)
		var/required_amount = required_items[requirement_path]

		for(var/obj/item/nearby_item as anything in surrounding_items)
			if(!istype(nearby_item, requirement_path))
				continue

			if(isstack(nearby_item)) // If the item is a stack, check if that stack has enough material in it to fill out the amount
				var/obj/item/stack/nearby_stack = nearby_item
				if(required_amount > 0)
					requirement_items += nearby_item
				required_amount -= nearby_stack.amount
			else // Otherwise, we still exist and should subtract one from the required number of items
				if(required_amount > 0)
					requirement_items += nearby_item
				required_amount -= 1

		if(required_amount > 0)
			return FALSE

	if(return_ingredients_list)
		return requirement_items
	else
		return TRUE

/// Passes the list of found ingredients + the recipe to use_or_delete_recipe_requirements, then spawns the given recipe's result
/obj/structure/crafting_bench/proc/create_thing_from_requirements(list/things_to_use, datum/crafting_bench_recipe/recipe_to_follow, mob/living/user, datum/skill/skill_to_grant, skill_amount)

	if(!recipe_to_follow)
		message_admins("[src] just tried to complete a recipe without having a recipe!")
		return

	if(!length(things_to_use))
		message_admins("[src] just tried to craft something from requirements, but was not given a list of requirements!")

	recipe_to_follow.before_finishing(things_to_use)

	var/materials_to_transfer = list()
	var/list/temporary_materials_list = use_or_delete_recipe_requirements(things_to_use, recipe_to_follow)
	for(var/material as anything in temporary_materials_list)
		materials_to_transfer[material] += temporary_materials_list[material]

	var/obj/newly_created_thing = new recipe_to_follow.resulting_item(get_turf(src))

	if(!newly_created_thing)
		message_admins("[src] just failed to create something while crafting!")
		return

	if(recipe_to_follow.transfers_materials)
		newly_created_thing.set_custom_materials(materials_to_transfer, multiplier = 1)

	user.mind.adjust_experience(skill_to_grant, skill_amount)

	clear_recipe()
	update_appearance()

/// Takes the given list, things_to_use, compares it to recipe_to_follow's requirements, then either uses items from a stack, or deletes them otherwise. Returns custom material of forge items in the end.
/obj/structure/crafting_bench/proc/use_or_delete_recipe_requirements(list/things_to_use, datum/crafting_bench_recipe/recipe_to_follow)
	var/list/materials_to_transfer = list()

	for(var/obj/requirement_item as anything in things_to_use)
		if(isstack(requirement_item))
			var/stack_type
			for(var/recipe_thing_to_reference as anything in recipe_to_follow.recipe_requirements)
				if(!istype(requirement_item, recipe_thing_to_reference))
					continue
				stack_type = recipe_thing_to_reference
				break

			var/obj/item/stack/requirement_stack = requirement_item

			if(requirement_stack.amount < recipe_to_follow.recipe_requirements[stack_type])
				recipe_to_follow.recipe_requirements[stack_type] -= requirement_stack.amount
				if(check_if_we_use_this_things_materials(recipe_to_follow, requirement_stack))
					for(var/custom_material as anything in requirement_item.custom_materials)
						materials_to_transfer += custom_material
				requirement_stack.use(requirement_stack.amount)
				continue

			if(check_if_we_use_this_things_materials(recipe_to_follow, requirement_stack))
				for(var/custom_material as anything in requirement_stack.custom_materials)
					materials_to_transfer += custom_material[MINERAL_MATERIAL_AMOUNT * recipe_to_follow.recipe_requirements[stack_type]]

			requirement_stack.use(recipe_to_follow.recipe_requirements[stack_type])

		else
			if(check_if_we_use_this_things_materials(recipe_to_follow, requirement_item))
				for(var/custom_material as anything in requirement_item.custom_materials)
					materials_to_transfer += custom_material
			qdel(requirement_item)

	return materials_to_transfer

/// Proc to check all the conditions for if we're using materials from this thing or not
/obj/structure/crafting_bench/proc/check_if_we_use_this_things_materials(datum/crafting_bench_recipe/recipe_to_follow, obj/requirement_item)
	var/list/stuff_to_not_take_materials_from = typecacheof(recipe_to_follow.types_to_not_take_materials_from)

	if(!requirement_item.custom_materials || !recipe_to_follow.transfers_materials)
		return FALSE

	if(length(stuff_to_not_take_materials_from) && is_type_in_typecache(requirement_item, stuff_to_not_take_materials_from))
		return FALSE

	return TRUE

/// Gets movable atoms within one tile of range of the crafting bench
/obj/structure/crafting_bench/proc/get_environment()
	. = list()

	if(!get_turf(src))
		return

	for(var/atom/movable/found_movable_atom in range(1, src))
		if((found_movable_atom.flags_1 & HOLOGRAM_1))
			continue
		. += found_movable_atom
	return .

#undef WEAPON_COMPLETION_WOOD_AMOUNT
