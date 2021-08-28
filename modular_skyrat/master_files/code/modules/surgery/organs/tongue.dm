/obj/item/organ/tongue/abductor/handle_speech(datum/source, list/speech_args)
	//Hacks
	var/message = speech_args[SPEECH_MESSAGE]

	if(length(message) > 1)
		var/key = message[1]
		if(key == "@")
			message = trim_left(copytext_char(message, 1))
			var/mob/living/carbon/human/user = source
			var/rendered = span_abductor("<b>[user.real_name]:</b> [message]")
			user.log_talk(message, LOG_SAY, tag="abductor")
			for(var/mob/living/carbon/human/living_mob in GLOB.alive_mob_list)
				var/obj/item/organ/tongue/abductor/tongue = living_mob.getorganslot(ORGAN_SLOT_TONGUE)
				if(!istype(tongue))
					continue
				if(mothership == tongue.mothership)
					to_chat(living_mob, rendered)

			for(var/mob/dead_mob in GLOB.dead_mob_list)
				var/link = FOLLOW_LINK(dead_mob, user)
				to_chat(dead_mob, "[link] [rendered]")

			speech_args[SPEECH_MESSAGE] = ""
