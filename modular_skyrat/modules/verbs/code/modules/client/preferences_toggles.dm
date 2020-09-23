
/client/verb/listen_looc()
	set name = "Show/Hide LOOC"
	set category = "Preferences"
	set desc = "Toggles seeing LocalOutOfCharacter chat"
	usr.client.prefs.skyrat_toggles ^= CHAT_LOOC
	usr.client.prefs.save_preferences()
	to_chat(usr, "You will [(usr.client.prefs.skyrat_toggles & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel.")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Seeing LOOC", "[usr.client.prefs.skyrat_toggles & CHAT_LOOC ? "Enabled" : "Disabled"]"))
