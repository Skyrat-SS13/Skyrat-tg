/obj/item/organ/internal/tongue/fluffy
	name = "fluffy tongue"
	desc = "OwO what's this?"
	icon = 'modular_tannhauser/modules/CitOwOChems/art/tonguefluffy.dmi'
	icon_state = "tonguefluffy"
	taste_sensitivity = 10 // extra sensitive and inquisitive uwu
	modifies_speech = TRUE

/obj/item/organ/internal/tongue/fluffy/modify_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "ne", "nye")
		message = replacetext(message, "nu", "nyu")
		message = replacetext(message, "na", "nya")
		message = replacetext(message, "no", "nyo")
		message = replacetext(message, "ove", "uv")
		message = replacetext(message, "l", "w")
		message = replacetext(message, "r", "w")
	speech_args[SPEECH_MESSAGE] = lowertext(message)
