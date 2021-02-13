/datum/speech_mod/impediment_rl
	soundtext = "mispronouncing \"r\" as \"l\""

/datum/speech_mod/impediment_rl/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "l")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "L")

/datum/speech_mod/impediment_lw
	soundtext = "mispronouncing \"l\" as \"w\""

/datum/speech_mod/impediment_lw/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "l", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "L", "W")

/datum/speech_mod/impediment_rw
	soundtext = "mispronouncing \"r\" as \"w\""

/datum/speech_mod/impediment_rw/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "W")

/datum/speech_mod/impediment_rw_lw
	soundtext = "mispronouncing \"r\" and \"l\" as \"w\""

/datum/speech_mod/impediment_rw_lw/handle_speech(datum/source, list/speech_args)
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "r", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "R", "W")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "l", "w")
	speech_args[SPEECH_MESSAGE] = replacetext(speech_args[SPEECH_MESSAGE], "L", "W")
