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
	if(!preferences.food)
		return

	if(length(preferences.food[FOOD_LIKED]) > MAXIMUM_LIKES || length(preferences.food[FOOD_DISLIKED]) < MINIMUM_REQUIRED_DISLIKES || length(preferences.food[FOOD_TOXIC]) < MINIMUM_REQUIRED_TOXICS)
		to_chat(preferences.parent, span_doyourjobidiot("You set up your liked foods in such a way that they can't be applied! Please check your preferences!")) // Sorry, but I don't want folk sleeping on this.
		return

	var/datum/species/species = target.dna.species
	species.liked_food = NONE
	species.disliked_food = NONE
	species.toxic_food = NONE

	for(var/food in preferences.food[FOOD_LIKED])
		species.liked_food |= GLOB.food_flag_to_bitflag[food]

	for(var/food in preferences.food[FOOD_DISLIKED])
		species.disliked_food |= GLOB.food_flag_to_bitflag[food]

	for(var/food in preferences.food[FOOD_TOXIC])
		species.disliked_food |= GLOB.food_flag_to_bitflag[food]

/// Food prefs menu datum. Global datum for performance and memory reasons.
/datum/food_prefs_menu/ui_interact(mob/dead/new_player/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FoodPreferences", "Food Preferences")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/food_prefs_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	..()

	var/datum/preferences/preferences = ui?.user?.client?.prefs

	if(action == "reset")
		QDEL_NULL(preferences.food)
		return

	var/food_name = params["food_name"]
	var/food_flag = params["food_flag"]

	if(!food_name || !preferences)
		return TRUE

	if(!food_flag)
		if(preferences.food)
			preferences.food[FOOD_LIKED] -= food_name
			preferences.food[FOOD_DISLIKED] -= food_name
			preferences.food[FOOD_TOXIC] -= food_name
		return TRUE

	if(!(food_flag in list(FOOD_LIKED, FOOD_DISLIKED, FOOD_TOXIC)))
		return TRUE

	var/liked_food_length = length(preferences?.food[FOOD_LIKED])

	if(food_flag == FOOD_LIKED && liked_food_length >= MAXIMUM_LIKES)
		if(preferences.food && liked_food_length > MAXIMUM_LIKES)
			var/list/food_list = preferences.food[FOOD_LIKED]
			food_list.Cut(MAXIMUM_LIKES + 1) // Yeet extra likes!
		return TRUE

	if(!preferences.food)
		preferences.food = list(
			FOOD_LIKED = list(),
			FOOD_DISLIKED = list(),
			FOOD_TOXIC = list(),
		)

	preferences.food[food_flag] += food_name
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
