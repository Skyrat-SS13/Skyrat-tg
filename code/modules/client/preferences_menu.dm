/datum/verbs/menu/Preferences/verb/open_character_preferences()
	set category = "OOC"
	set name = "Open Character Preferences"
	set desc = "Open Character Preferences"

	var/datum/preferences/preferences = usr?.client?.prefs
	if (!preferences)
		return

	preferences.current_window = PREFERENCE_TAB_CHARACTER_PREFERENCES
	preferences.update_static_data(usr)
	preferences.ui_interact(usr)

/datum/verbs/menu/Preferences/verb/open_game_preferences()
	set category = "OOC"
	set name = "Open Game Preferences"
	set desc = "Open Game Preferences"

	var/datum/preferences/preferences = usr?.client?.prefs
	if (!preferences)
		return

	preferences.current_window = PREFERENCE_TAB_GAME_PREFERENCES
	preferences.update_static_data(usr)
	preferences.ui_interact(usr)

//SKYRAT EDIT ADDITION - VORE
/datum/verbs/menu/Preferences/verb/open_vore_preferences()
	set category = "OOC"
	set name = "Open Vore Preferences"
	set desc = "Open Vore Preferences"

	var/datum/preferences/preferences = usr?.client?.prefs
	if (!preferences)
		return

	if (!preferences.vr_prefs)
		preferences.vr_prefs = new(usr.client)
	preferences.vr_prefs.update_static_data(usr)
	preferences.vr_prefs.ui_interact(usr)
//SKYRAT EDIT END
