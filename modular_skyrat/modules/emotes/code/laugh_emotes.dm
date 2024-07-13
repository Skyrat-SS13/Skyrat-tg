/datum/emote/living/laugh
	key = "laugh"
	key_third_person = "laughs"
	message = "laughs."
	message_mime = "laughs silently!"
	emote_type = EMOTE_AUDIBLE
	audio_cooldown = 5 SECONDS
	vary = TRUE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/laugh/get_sound(mob/living/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/H = user
		if(isnull(H.selected_laugh)) //For things that don't have a selected laugh(npcs)
			if(user.gender == MALE)
				return pick('sound/voice/human/manlaugh1.ogg',
						'sound/voice/human/manlaugh2.ogg')
			else
				return pick('modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_1.ogg',
					'modular_skyrat/modules/emotes/sound/emotes/female/female_giggle_2.ogg')
		if(user.gender == MALE || !LAZYLEN(H.selected_laugh.female_laughsounds))
			return pick(H.selected_laugh.male_laughsounds)
		else
			return pick(H.selected_laugh.female_laughsounds)
	return
