// To make this system not a massive meta-pick for gamers, while still allowing plenty of room for unique combinations.
#define MINIMUM_REQUIRED_TOXICS 2
#define MINIMUM_REQUIRED_DISLIKES 3
#define MAXIMUM_LIKES 3

// Performance and RAM friendly menu. You can thank me later.
GLOBAL_DATUM_INIT(food_prefs_menu, /datum/food_prefs_menu, new)

// Hahahaha, it LIVES!

/datum/preference_middleware/food/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences)
	if(!length(preferences.food) || isdummy(target))
		return

	var/fail_reason = GLOB.food_prefs_menu.is_food_invalid(preferences)
	if(fail_reason)
		to_chat(preferences.parent, span_doyourjobidiot("Your food preferences can't be set because of [fail_reason] choices! Please check your preferences!")) // Sorry, but I don't want folk sleeping on this.
		return

	var/datum/species/species = target.dna.species
	species.liked_food = NONE
	species.disliked_food = NONE
	species.toxic_food = NONE

	for(var/food_entry in GLOB.food_ic_flag_to_point_values)
		var/list/food_points_entry = GLOB.food_ic_flag_to_point_values[food_entry]
		var/food_preference = preferences.food[food_entry] || food_points_entry["[FOOD_DEFAULT]"]

		switch(food_preference) // Doesn't use defines cause I need them in string form
			if("1")
				species.liked_food |= GLOB.food_ic_flag_to_bitflag[food_entry]
			if("2")
				species.disliked_food |= GLOB.food_ic_flag_to_bitflag[food_entry]
			if("3")
				species.toxic_food |= GLOB.food_ic_flag_to_bitflag[food_entry]

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

	switch(action)
		if("reset")
			qdel(preferences.food)
			preferences.food = list()
			return TRUE

		if("toggle")
			preferences.food["enabled"] = !preferences.food["enabled"]
			return TRUE

		if("change_food")

			var/food_name = params["food_name"]
			var/food_flag = params["food_flag"]

			if(!food_name || !preferences || !food_flag || !(food_flag in list("[FOOD_LIKED]", "[FOOD_NEUTRAL]", "[FOOD_DISLIKED]", "[FOOD_TOXIC]")))
				return TRUE

			// Do some simple validation for max liked foods. Full validation is done on spawn and in the actual menu.
			var/liked_food_length = 0

			for(var/food_entry in preferences.food)
				var/list/food_points_entry = GLOB.food_ic_flag_to_point_values[food_entry]
				if(food_points_entry["[FOOD_OBSCURE]"])
					continue

				if(preferences.food[food_entry] == "[FOOD_LIKED]")
					liked_food_length++
					if(liked_food_length > MAXIMUM_LIKES)
						preferences.food.Remove(food_entry)

			if(food_flag == "[FOOD_LIKED]" ? liked_food_length >= MAXIMUM_LIKES : liked_food_length > MAXIMUM_LIKES) // Equals as well, if we're setting a liked food!
				return TRUE // Fuck you, look your mistakes in the eye.

			preferences.food[food_name] = food_flag
			return TRUE

/datum/preferences/ui_state(mob/user)
	return GLOB.always_state

/datum/food_prefs_menu/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE // Prefs can be accessed from anywhere.

/datum/food_prefs_menu/ui_static_data(mob/user)
	return list(
		"food_types" = GLOB.food_ic_flag_to_point_values,
	)

/datum/food_prefs_menu/ui_data(mob/user)
	var/datum/preferences/preferences = user.client.prefs

	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)

	return list(
		"selection" = preferences.food,
		"points" = calculate_points(preferences),
		"enabled" = preferences.food["enabled"],
		"invalid" = is_food_invalid(preferences),
		"pref_literally_does_nothing" = !initial(species.allow_food_preferences),
	)

/// Checks the provided preferences datum to make sure the food pref values are valid. Does not check if the food preferences value is null.
/datum/food_prefs_menu/proc/is_food_invalid(datum/preferences/preferences)
	var/liked_food_length = 0
	var/disliked_food_length = 0
	var/toxic_food_length = 0

	for(var/food_entry in GLOB.food_ic_flag_to_point_values)
		var/list/food_points_entry = GLOB.food_ic_flag_to_point_values[food_entry]
		var/food_preference = preferences.food[food_entry] || food_points_entry["[FOOD_DEFAULT]"]

		if(food_points_entry["[FOOD_OBSCURE]"])
			continue

		switch(food_preference) // Doesn't use defines cause I need this in string form.
			if("1")
				liked_food_length++
			if("2")
				disliked_food_length++
			if("3")
				toxic_food_length++

	if(liked_food_length > MAXIMUM_LIKES)
		return "too many like choices"
	if(disliked_food_length < MINIMUM_REQUIRED_DISLIKES)
		return "too few dislike choices"
	if(toxic_food_length < MINIMUM_REQUIRED_TOXICS)
		return "too few toxic choices"
	if(calculate_points(preferences) < 0)
		return "not enough points"

/// Calculates the deviance points for food.
/datum/food_prefs_menu/proc/calculate_points(datum/preferences/preferences)
	var/points = 0

	for(var/food_entry in preferences.food)
		var/list/food_flag = preferences.food[food_entry]
		var/list/food_points_entry = GLOB.food_ic_flag_to_point_values[food_entry]
		if(!food_points_entry)
			continue

		var/default_food_flag = food_points_entry["[FOOD_DEFAULT]"]
		var/point_value = food_points_entry[food_flag]

		if(point_value && (GLOB.food_flag_to_order_value[food_flag] > GLOB.food_flag_to_order_value[default_food_flag]))
			points -= point_value
		else
			points += point_value

	return points

#undef MINIMUM_REQUIRED_TOXICS
#undef MINIMUM_REQUIRED_DISLIKES
#undef MAXIMUM_LIKES
