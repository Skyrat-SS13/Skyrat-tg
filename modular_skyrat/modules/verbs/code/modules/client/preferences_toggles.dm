
/client/verb/listen_looc()
	set name = "Show/Hide LOOC"
	set category = "Preferences"
	set desc = "Toggles seeing LocalOutOfCharacter chat"
	usr.client.prefs.skyrat_toggles ^= CHAT_LOOC
	usr.client.prefs.save_preferences()
	to_chat(usr, "<span class='infoplain'>You will [(usr.client.prefs.skyrat_toggles & CHAT_LOOC) ? "now" : "no longer"] see messages on the LOOC channel.</span>")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Seeing LOOC", "[usr.client.prefs.skyrat_toggles & CHAT_LOOC ? "Enabled" : "Disabled"]"))

/client/verb/admin_delete_zap_pref()
	set name = "Toggle Delete Sparks"
	set category = "Preferences.Admin"
	set desc = "Toggles the appearance of bluespace zaps when you use the Delete command on stuff. Also applies to simple/advanced/del buildmode."
	if(!holder)
		return
	usr.client.prefs.skyrat_toggles ^= ADMINDEL_ZAP_PREF
	usr.client.prefs.save_preferences()	
	to_chat(usr, "<span class='infoplain'>There will [(usr.client.prefs.skyrat_toggles & ADMINDEL_ZAP_PREF) ? "now" : "no longer"] be bluespace sparks when you Delete objects.</span>")
	SSblackbox.record_feedback("nested tally", "preferences_verb", 1, list("Toggle Delete Sparks", "[usr.client.prefs.skyrat_toggles & ADMINDEL_ZAP_PREF ? "Enabled" : "Disabled"]"))
