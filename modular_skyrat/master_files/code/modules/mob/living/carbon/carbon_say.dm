/mob/living/carbon/radio(message, list/message_mods = list(), list/spans, language)
	if((message_mods[MODE_HEADSET] || message_mods[RADIO_EXTENSION])) //SKYRAT EDIT CHANGE BEGIN
		if(handcuffed)// If we're handcuffed, we can't press the button
			to_chat(src, "<span class='warning'>You can't use the radio while handcuffed!</span>")
			return ITALICS | REDUCE_RANGE
		if(pulledby && pulledby.grab_state)
			to_chat(src, "<span class='warning'>You can't use the radio while aggressively grabbed!</span>")
			return ITALICS | REDUCE_RANGE //SKYRAT EDIT END
	return ..()
