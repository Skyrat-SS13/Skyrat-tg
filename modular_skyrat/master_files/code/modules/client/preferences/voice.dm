/// The option for not having a voice.
#define TTS_VOICE_NONE "None"

/datum/preference/choiced/voice/init_possible_values()
	if(SStts.tts_enabled)
		return list(TTS_VOICE_NONE) + SStts.available_speakers

	if(fexists("data/cached_tts_voices.json"))
		var/list/text_data = rustg_file_read("data/cached_tts_voices.json")
		var/list/cached_data = json_decode(text_data)
		if(!cached_data)
			return list("invalid")

		return list(TTS_VOICE_NONE) + cached_data

	return list("invalid")

/datum/preference/choiced/voice/apply_to_human(mob/living/carbon/human/target, value)
	if(SStts.tts_enabled && !(value in cached_values))
		value = pick(SStts.available_speakers) // As a failsafe

	target.voice = value == TTS_VOICE_NONE ? "" : value

#undef TTS_VOICE_NONE
