/datum/team/ashwalkers
	name = "Ashwalkers"
	show_roundend_report = FALSE
	var/list/players_spawned = new

/datum/antagonist/ashwalker
	name = "\improper Ash Walker"
	job_rank = ROLE_LAVALAND
	show_in_antagpanel = FALSE
	show_to_ghosts = TRUE
	prevent_roundtype_conversion = FALSE
	antagpanel_category = "Ash Walkers"
	suicide_cry = "I HAVE NO IDEA WHAT THIS THING DOES!!"
	count_against_dynamic_roll_chance = FALSE
	var/datum/team/ashwalkers/ashie_team
	//SKYRAT EDIT: Recipes for Tribals
	///The list of recipes that will be learned on inheriting the antag datum
	var/static/list/antag_recipes = list(
		/datum/crafting_recipe/skeleton_key,
		/datum/crafting_recipe/ashnecklace,
		/datum/crafting_recipe/bonesword,
		/datum/crafting_recipe/ash_recipe/macahuitl,
		/datum/crafting_recipe/boneaxe,
		/datum/crafting_recipe/bonespear,
		/datum/crafting_recipe/bonedagger,
	)
	//SKYRAT EDIT: Recipes for Tribals

/datum/antagonist/ashwalker/create_team(datum/team/team)
	if(team)
		ashie_team = team
		objectives |= ashie_team.objectives
	else
		ashie_team = new

/datum/antagonist/ashwalker/get_team()
	return ashie_team

/datum/antagonist/ashwalker/on_body_transfer(mob/living/old_body, mob/living/new_body)
	. = ..()
	UnregisterSignal(old_body, COMSIG_MOB_EXAMINATE)
	RegisterSignal(new_body, COMSIG_MOB_EXAMINATE, .proc/on_examinate)

/datum/antagonist/ashwalker/on_gain()
	. = ..()
	RegisterSignal(owner.current, COMSIG_MOB_EXAMINATE, .proc/on_examinate)
	//SKYRAT EDIT: Recipes for Tribals
	for(var/recipe_datum in antag_recipes)
		owner.teach_crafting_recipe(recipe_datum)
	//SKYRAT EDIT: Recipes for Tribals

/datum/antagonist/ashwalker/on_removal()
	. = ..()
	UnregisterSignal(owner.current, COMSIG_MOB_EXAMINATE)

/datum/antagonist/ashwalker/proc/on_examinate(datum/source, atom/A)
	SIGNAL_HANDLER

	if(istype(A, /obj/structure/headpike))
		SEND_SIGNAL(owner.current, COMSIG_ADD_MOOD_EVENT, "oogabooga", /datum/mood_event/sacrifice_good)
