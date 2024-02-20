// To make this system not a massive meta-pick for gamers, while still allowing plenty of room for unique combinations.
#define MINIMUM_REQUIRED_TOXICS 1
#define MINIMUM_REQUIRED_DISLIKES 3
#define MAXIMUM_LIKES 3

// Performance and RAM friendly menu. You can thank me later.
GLOBAL_DATUM_INIT(food_prefs_menu, /datum/food_prefs_menu, new)

// Hahahaha, it LIVES!

/datum/preference_middleware/food/apply_to_human(mob/living/carbon/human/target, datum/preferences/preferences, visuals_only = FALSE)
	if(!length(preferences.food_preferences) || isdummy(target))
		return
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	if(!species.allows_food_preferences())
		qdel(species)
		return
	qdel(species)

	var/fail_reason = GLOB.food_prefs_menu.is_food_invalid(preferences)
	if(fail_reason)
		to_chat(preferences.parent, span_announce("Your food preferences can't be set because of [fail_reason] choices! Please check your preferences!")) // Sorry, but I don't want folk sleeping on this.
		return

	var/obj/item/organ/internal/tongue/target_tongue = target.get_organ_slot(ORGAN_SLOT_TONGUE)

	if(isnull(target_tongue) || !preferences.food_preferences["enabled"])
		return

	target_tongue.liked_foodtypes  = NONE
	target_tongue.disliked_foodtypes  = NONE
	target_tongue.toxic_foodtypes = NONE

	for(var/food_entry in GLOB.food_defaults)
		var/list/food_default = GLOB.food_defaults[food_entry]
		var/food_preference = preferences.food_preferences[food_entry] || food_default

		switch(food_preference)
			if(FOOD_PREFERENCE_LIKED)
				target_tongue.liked_foodtypes |= GLOB.food_ic_flag_to_bitflag[food_entry]
			if(FOOD_PREFERENCE_DISLIKED)
				target_tongue.disliked_foodtypes |= GLOB.food_ic_flag_to_bitflag[food_entry]
			if(FOOD_PREFERENCE_TOXIC)
				target_tongue.toxic_foodtypes |= GLOB.food_ic_flag_to_bitflag[food_entry]

/// Food prefs menu datum. Global datum for performance and memory reasons.
/datum/food_prefs_menu/ui_interact(mob/dead/new_player/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "FoodPreferences", "Food Preferences")
		ui.set_autoupdate(FALSE)
		ui.open()

/datum/food_prefs_menu/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	var/datum/preferences/preferences = ui?.user?.client?.prefs
	if(!preferences)
		return

	switch(action)
		if("reset")
			preferences.food_preferences.Cut()
			preferences.food_preferences = list()
			return TRUE

		if("toggle")
			preferences.food_preferences["enabled"] = !preferences.food_preferences["enabled"]
			return TRUE

		if("change_food")
			var/food_name = params["food_name"]
			var/food_preference = params["food_preference"]

			if(!food_name || !preferences || !food_preference || !(food_preference in list(FOOD_PREFERENCE_LIKED, FOOD_PREFERENCE_NEUTRAL, FOOD_PREFERENCE_DISLIKED, FOOD_PREFERENCE_TOXIC)))
				return TRUE

			// Do some simple validation for max liked foods. Full validation is done on spawn and in the actual menu.
			var/liked_food_length = 0

			for(var/food_entry in preferences.food_preferences)
				if(food_entry in GLOB.obscure_food_types)
					continue

				if(preferences.food_preferences[food_entry] == FOOD_PREFERENCE_LIKED)
					liked_food_length++
					if(liked_food_length > MAXIMUM_LIKES)
						preferences.food_preferences.Remove(food_entry)
				if(liked_food_length > MAXIMUM_LIKES || (food_preference == FOOD_PREFERENCE_LIKED && liked_food_length == MAXIMUM_LIKES)) // Equals as well, if we're setting a liked food!
					if(food_name in GLOB.obscure_food_types)
						return TRUE

			preferences.food_preferences[food_name] = food_preference
			return TRUE

/datum/preferences/ui_state(mob/user)
	return GLOB.always_state

/datum/food_prefs_menu/ui_status(mob/user, datum/ui_state/state)
	return UI_INTERACTIVE // Prefs can be accessed from anywhere.

/datum/food_prefs_menu/ui_static_data(mob/user)
	return list(
		"food_types" = GLOB.food_defaults,
		"obscure_food_types" = GLOB.obscure_food_types,
	)

/datum/food_prefs_menu/ui_data(mob/user)
	var/datum/preferences/preferences = user.client.prefs

	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type

	var/list/data = list(
		"selection" = preferences.food_preferences,
		"enabled" = preferences.food_preferences["enabled"],
		"invalid" = is_food_invalid(preferences),
		"race_disabled" = !species.allows_food_preferences(),
	)
	qdel(species)
	return data

/// Checks the provided preferences datum to make sure the food pref values are valid. Does not check if the food preferences value is null.
/datum/food_prefs_menu/proc/is_food_invalid(datum/preferences/preferences)
	var/liked_food_length = 0
	var/disliked_food_length = 0
	var/toxic_food_length = 0

	for(var/food_entry in GLOB.food_defaults)
		var/list/food_default = GLOB.food_defaults[food_entry]
		var/food_preference = preferences.food_preferences[food_entry] || food_default

		if(food_entry in GLOB.obscure_food_types)
			continue

		switch(food_preference)
			if(FOOD_PREFERENCE_LIKED)
				liked_food_length++
			if(FOOD_PREFERENCE_DISLIKED)
				disliked_food_length++
			if(FOOD_PREFERENCE_TOXIC)
				toxic_food_length++

	if(liked_food_length > MAXIMUM_LIKES)
		return "too many liked choices"
	if(disliked_food_length + toxic_food_length < MINIMUM_REQUIRED_DISLIKES)
		return "too few disliked choices"
	if(toxic_food_length < MINIMUM_REQUIRED_TOXICS)
		return "too few toxic choices"

#undef MINIMUM_REQUIRED_TOXICS
#undef MINIMUM_REQUIRED_DISLIKES
#undef MAXIMUM_LIKES
