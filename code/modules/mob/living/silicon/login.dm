/mob/living/silicon/Login()
	if(mind)
		mind?.remove_antags_for_borging()
	// SKYRAT EDIT BEGIN - Let people set a TTS voice for their silicon characters and pAIs
	if(SStts.tts_enabled)
		var/voice_to_use = client?.prefs.read_preference(/datum/preference/choiced/voice)
		if(voice_to_use)
			voice = voice_to_use
	// SKYRAT EDIT END
	return ..()


/mob/living/silicon/auto_deadmin_on_login()
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_silicons) || (client.prefs?.toggles & DEADMIN_POSITION_SILICON))
		return client.holder.auto_deadmin()
	return ..()
