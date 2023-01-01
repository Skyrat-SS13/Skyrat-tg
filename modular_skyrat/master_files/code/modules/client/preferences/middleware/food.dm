/// To make this system not a massive meta-pick for gamers, while still allowing plenty of room for unique combinations.
#define MINIMUM_REQUIRED_TOXICS 1
#define MINIMUM_REQUIRED_DISLIKES 2
#define MAXIMUM_LIKES 1

GLOBAL_DATUM_INIT(food_prefs_menu, /datum/food_prefs_menu, new)

GLOBAL_LIST_INIT(food_flag_to_bitflag, list(
	"MEAT" = MEAT,
	"VEGETABLES" = VEGETABLES,
	"RAW" = RAW,
	"JUNKFOOD" = JUNKFOOD,
	"GRAIN" = GRAIN,
	"FRUIT" = FRUIT,
	"DAIRY" = DAIRY,
	"FRIED" = FRIED,
	"ALCOHOL" = ALCOHOL,
	"SUGAR" = SUGAR,
	"GROSS" = GROSS,
	"TOXIC" = TOXIC,
	"PINEAPPLE" = PINEAPPLE,
	"BREAKFAST" = BREAKFAST,
	"CLOTH" = CLOTH,
	"NUTS" = NUTS,
	"SEAFOOD" = SEAFOOD,
	"ORANGES" = ORANGES,
	"BUGS" = BUGS,
	"GORE" = GORE,
))

// Hahahaha, it LIVES!

/datum/preference_middleware/food/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences)
	if(!length(preferences.food))
		return

	var/liked_food_length = 0
	var/disliked_food_length = 0
	var/toxic_food_length = 0

	for(var/item in preferences.food)
		if(preferences.food[item] == FOOD_LIKED)
			liked_food_length++
		if(preferences.food[item] == FOOD_DISLIKED)
			disliked_food_length++
		if(preferences.food[item] == FOOD_TOXIC)
			toxic_food_length++

	if(liked_food_length > MAXIMUM_LIKES || disliked_food_length < MINIMUM_REQUIRED_DISLIKES || toxic_food_length < MINIMUM_REQUIRED_TOXICS)
		to_chat(preferences.parent, span_doyourjobidiot("You set up your liked foods in such a way that they can't be applied! Please check your preferences!")) // Sorry, but I don't want folk sleeping on this.
		return

	var/datum/species/species = target.dna.species
	species.liked_food = NONE
	species.disliked_food = NONE
	species.toxic_food = NONE

	for(var/item in preferences.food)
		if(preferences.food[item] == FOOD_LIKED)
			species.liked_food |= GLOB.food_flag_to_bitflag[item]
		if(preferences.food[item] == FOOD_DISLIKED)
			species.disliked_food |= GLOB.food_flag_to_bitflag[item]
		if(preferences.food[item] == FOOD_TOXIC)
			species.toxic_food |= GLOB.food_flag_to_bitflag[item]

/// Food prefs menu datum. Global datum for performance and memory reasons.
/datum/food_prefs_menu/ui_interact(mob/dead/new_player/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FoodPreferences", "Food Preferences")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/food_prefs_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()

	var/datum/preferences/preferences = ui?.user?.client?.prefs

	if(action == "reset")
		QDEL_NULL(preferences.food)
		preferences.food = list()
		return TRUE

	if(action != "change_food")
		return .

	var/food_name = params["food_name"]
	var/food_flag = params["food_flag"]

	world.log << "[food_name] | [food_flag]"

	if(!food_name || !preferences)
		return TRUE

	if(!food_flag)
		preferences.food.Remove(food_name)
		return TRUE

	if(!(food_flag in list(FOOD_LIKED, FOOD_DISLIKED, FOOD_TOXIC)))
		return TRUE

	// Do some simple validation.
	var/liked_food_length = 0

	for(var/item in preferences.food)
		if(preferences.food[item] == FOOD_LIKED)
			liked_food_length++
			if(liked_food_length > MAXIMUM_LIKES)
				preferences.food.Remove(item)

	if(food_flag == FOOD_LIKED ? liked_food_length > MAXIMUM_LIKES : liked_food_length >= MAXIMUM_LIKES) // Equals as well, cause we're presumably setting something!
		return TRUE // Fuck you, look your mistakes in the eye.

	LAZYINITLIST(preferences.food)

	preferences.food[food_name] = food_flag
	return TRUE

/datum/preferences/ui_state(mob/user)
	return GLOB.always_state

/datum/food_prefs_menu/ui_status(mob/user, datum/ui_state/state)
	return user?.client ? UI_INTERACTIVE : UI_CLOSE // Prefs can be accessed from anywhere.

/datum/food_prefs_menu/ui_static_data(mob/user)
	return list(
		"food_types" = FOOD_FLAGS_IC
	)

/datum/food_prefs_menu/ui_data(mob/user)
	var/datum/preferences/preferences = user.client.prefs

	if(preferences.read_preference(/datum/preference/choiced/species) == /datum/species/fly)
		return list("pref_literally_does_nothing" = TRUE)

	return list("selection" = preferences.food)

#undef MINIMUM_REQUIRED_TOXICS
#undef MINIMUM_REQUIRED_DISLIKES
#undef MAXIMUM_LIKES
