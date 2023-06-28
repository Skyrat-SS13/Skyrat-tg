/mob/living/silicon/Login()
	if(mind)
		mind?.remove_antags_for_borging()
<<<<<<< HEAD
	// SKYRAT EDIT BEGIN - Let people set a TTS voice for their silicon characters and pAIs
	if(SStts.tts_enabled)
		var/voice_to_use = client?.prefs.read_preference(/datum/preference/choiced/voice)
		if(voice_to_use)
			voice = voice_to_use
	// SKYRAT EDIT END
=======
	if(SStts.tts_enabled)
		var/voice_to_use = client?.prefs.read_preference(/datum/preference/choiced/voice)
		var/pitch_to_use = client?.prefs.read_preference(/datum/preference/numeric/tts_voice_pitch)
		if(voice_to_use)
			voice = voice_to_use
		if(pitch_to_use)
			pitch = pitch_to_use
>>>>>>> a159b52e85a (TTS Improvements: Improved Audio Quality, Pitch Adjustment, Preference Silicon Voices, Per-Character Voice Disable Toggle, Tongue Voice Filters, Reworked Silicon and Vending Machine Filters (#76129))
	return ..()


/mob/living/silicon/auto_deadmin_on_login()
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_silicons) || (client.prefs?.toggles & DEADMIN_POSITION_SILICON))
		return client.holder.auto_deadmin()
	return ..()
