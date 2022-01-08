/decl/communication_channel/necrochat
	name = "Necrochat"
	expected_communicator_type = list(/client, /datum)
	flags = COMMUNICATION_NO_GUESTS
	log_proc = /proc/log_necro
	show_preference_setting = /datum/client_preference/show_necrochat
	message_type = MESSAGE_TYPE_RADIO

/decl/communication_channel/necrochat/can_ignore(var/client/C)
	.=..()
	if (.)
		if (C.mob && C.mob.is_necromorph())
			return FALSE	//Necromorphs must listen to the necrochat


/decl/communication_channel/necrochat/can_communicate(var/A, var/message)
	. = ..()
	if(!.)
		return
	if (istype(A, /client))
		var/client/C = A
		if(!C.holder)	//Admins are exempt
			if (!C.mob || !C.mob.is_necromorph()) //Gotta be a necromorph to use this
				return FALSE


/decl/communication_channel/necrochat/do_communicate(A, var/message, var/sender_override = null)

	var/list/messaged = list()	//Clients we've already sent to. Used to prevent doublesending to admins who are also playing necromorphs

	var/style = "necromorph"
	var/sender_name = ""
	if (sender_override)
		sender_name = sender_override
	else if (isclient(A))
		var/client/C = A
		if (C && C.mob)

			if (issignal(C.mob))


				if (is_marker_master(C.mob))
					style = "necromarker"
					sender_name = "Marker([C.ckey])"
				else
					style = "necrosignal"
					sender_name = "Signal([C.ckey])"
			else
				sender_name = C.mob.name


	message = "<span class='[style]'>[sender_name ? sender_name+": ":""][message]</span>"

	for (var/ckey in SSnecromorph.necromorph_players)
		var/datum/player/P = SSnecromorph.necromorph_players[ckey]
		if (!P)
			//Shouldn't happen
			log_debug("Found invalid necromorph player key with no associated player datum [ckey]")
			SSnecromorph.necromorph_players -= ckey
			continue
		var/client/target = P.get_client()
		if (!target)
			continue
		if ((!P.is_necromorph() && !target.mob) || (target.mob && !target.mob.is_necromorph()))
			log_debug("Found non-necromorph [ckey] (as [target.mob]) in necromorphs player list, please gather more info from them!")
			SSnecromorph.necromorph_players -= ckey
			continue
		receive_communication(A, target, message)
		messaged += target

	var/list/valid_admins = GLOB.admins - messaged
	for(var/client/target in valid_admins)
		receive_communication(A, target, message)




/mob/dead/observer/eye/signal/say(var/message)
	sanitize_and_communicate(/decl/communication_channel/necrochat, client, message)


/*
/mob/living/carbon/human/necromorph/say(var/message)
	sanitize_and_communicate(/decl/communication_channel/necrochat, client, message)

	if(prob(species.speech_chance) && check_audio_cooldown(SOUND_SPEECH))
		set_audio_cooldown(SOUND_SPEECH, 5 SECONDS)
		play_species_audio(src, SOUND_SPEECH, VOLUME_LOW, TRUE)
*/

/mob/living/simple_animal/necromorph/say(var/message)
	sanitize_and_communicate(/decl/communication_channel/necrochat, client, message)

	if(LAZYLEN(attack_sounds) && check_audio_cooldown(SOUND_SPEECH))
		set_audio_cooldown(SOUND_SPEECH, 5 SECONDS)
		playsound(src, pick(attack_sounds), VOLUME_MID, TRUE)



/*
	Necromorph language interface
*/
/datum/language/necromorph
	name = LANGUAGE_NECROCHAT
	desc = "A psychic hivemind between marker signals and their necromorph vessels"
	speech_verb = "groans"
	ask_verb = "wails"
	exclaim_verb = "screams"
	colour = "soghun"
	key = "q"
	flags = RESTRICTED | HIVEMIND
	syllables = list("hs","zt","kr","st","sh")
	shorthand = "RT"

/datum/language/necromorph/broadcast(var/mob/living/speaker,var/message,var/speaker_mask)

	/*
	*/
	sanitize_and_communicate(/decl/communication_channel/necrochat, speaker.client, message)

	var/datum/species/S = speaker.get_mental_species_datum()
	if(prob(S.speech_chance) && speaker.check_audio_cooldown(SOUND_SPEECH))
		speaker.set_audio_cooldown(SOUND_SPEECH, 5 SECONDS)
		S.play_species_audio(speaker, SOUND_SPEECH, VOLUME_LOW, TRUE)

	//log_say("[key_name(speaker)] : ([name]) [message]")





