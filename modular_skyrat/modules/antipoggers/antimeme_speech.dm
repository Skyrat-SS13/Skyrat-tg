/datum/mood_event/memespeak
	description = "<span class='warning'>Why am I saying these shitty memes? I sound so fucking stupid...</span>\n"
	mood_change = -5
	timeout = 2 MINUTES

/proc/antimemespeech(message, M)
	var/oldMessage = message
	message = replacetext(message, "poggers", "shewby") //credit to gummy for coming up with this one
	message = replacetext(message, "pogger", "shewby")
	message = replacetext(message, "pog", "shewb")
	message = replacetext(message, "sussy", "suspicious")
	//theres probably more memes people are gonna say so please fucking think of more and add them

	if(oldMessage!=message)
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			SEND_SIGNAL(H, COMSIG_ADD_MOOD_EVENT, "memespeak", /datum/mood_event/memespeak)
	return message
