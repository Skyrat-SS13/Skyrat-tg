/obj/item/radio/headset
	/// The sound that plays when someone uses the headset
	var/radiosound = 'modular_skyrat/modules/radiosound/sound/radio/common.ogg'
	/// The volume of the radio sound we make
	var/radio_sound_volume = 25

/obj/item/radio/headset/syndicate //disguised to look like a normal headset for stealth ops
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/syndie.ogg'

/obj/item/radio/headset/headset_sec
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/security.ogg'

/obj/item/radio/headset/talk_into(mob/living/mob_in_question, message, channel, list/spans, datum/language/language, list/message_mods, direct = TRUE)
	if(radiosound && listening)
		playsound(mob_in_question, radiosound, radio_sound_volume, TRUE, SHORT_RANGE_SOUND_EXTRARANGE, SOUND_FALLOFF_EXPONENT)
	. = ..()
