//////////////////////////
///CODE FOR LEWD QUIRKS///
//////////////////////////

//////////////////////
///SEXUAL OBSESSION///
//////////////////////

/*
Removed it as quirk because it can cause huge disaster and furry massacre.
I already saw enough in "Lone digger" video

But i keeped it as unobtainable breain trauma, so admins can add it through VV *IN VERY SPECIFIC SITUATIONS*. If you're not lazy you can add it as smite, but i wouldn't recommend it.
*/

/datum/brain_trauma/special/sexual_obsession
	name = "Sexual obsession"
	desc = "The patient is obsessed with having sex with random people."
	scan_desc = "sexual obsession"
	gain_text = ""
	lose_text = span_notice("You feel much calmer than before. You don't feel the need to harass anyone.")
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_SURGERY
	var/mob/living/carbon/human/obsession
	var/satisfaction = 100
	var/stress = 0
	var/viewing = FALSE

/datum/brain_trauma/special/sexual_obsession/on_gain()
	if(!obsession)//admins didn't set one
		obsession = find_obsession()
		if(!obsession)//we didn't find one
			lose_text = ""
			qdel(src)
			return
	gain_text = span_purple("You feel an inexplicable desire to have sex with someone...")
	ADD_TRAIT(owner, TRAIT_SOBSESSED, APHRO_TRAIT)

/datum/brain_trauma/special/sexual_obsession/on_lose()
	REMOVE_TRAIT(owner, TRAIT_SOBSESSED, APHRO_TRAIT)

/datum/brain_trauma/special/sexual_obsession/on_life(delta_time, times_fired)
	var/mob/living/carbon/human/H = owner
	if(satisfaction <= 0)
		if(stress <= 100)
			stress +=1
		switch(rand(1,6))
			if(1)
				if(stress < 95)
					to_chat(owner, span_purple("You feel slightly aroused..."))
				else
					to_chat(owner, span_purple("Lust spreads over your body!"))
					owner.emote("moan")
			if(2)
				if(stress < 95)
					to_chat(owner, span_purple("You can't stop shaking..."))
					owner.do_jitter_animation(20)
				else
					to_chat(owner, span_purple("You feel hot and seduced!"))
					owner.dizziness += 20
					owner.add_confusion(20)
					owner.Jitter(20)
					owner.do_jitter_animation(20)
					owner.adjustStaminaLoss(50)

			if(3, 4)
				if(stress < 95)
					to_chat(owner, span_purple("You bring your thighs together in lust."))
				else
					to_chat(owner, span_purple("Desire is driving you mad!"))
					owner.hallucination += 30

			if(5)
				if(stress < 95)
					to_chat(owner, span_purple("You feel like your genitals are burning..."))
					owner.adjustOxyLoss(8)
					owner.blur_eyes(10)
				else
					to_chat(owner, span_purple("You need something to satisfy this desire! Something... Or someone?"))
					owner.adjustOxyLoss(16)
					owner.blur_eyes(10)
					owner.visible_message(pick(span_purple("[owner] seductively wags their hips.") + "\n",
										span_purple("[owner] moans in lust!") + "\n",
										span_purple("[owner] touches [owner.p_them()]self in intimate places...") + "\n",
										span_purple("[owner] trembling longingly.") + "\n",
										span_purple("[owner] moans indecently!") + "\n"))
	if(satisfaction >= 0.20)
		satisfaction -= 0.20

	if(satisfaction <= 0.20)
		if(stress <= 100)
			stress +=1

	if(get_dist(get_turf(owner), get_turf(obsession)) < 2)
		if(obsession.pleasure >= 20 && owner.has_status_effect(/datum/status_effect/climax))
			satisfaction = 100
			stress = 0

	if(!obsession || obsession.stat == DEAD) //being aroused by corpses is kind of sin. It was my opportunity to check if target is dead.
		viewing = FALSE
		return

	if(get_dist(get_turf(owner), get_turf(obsession)) > 7)
		viewing = FALSE //they are further than our viewrange they are not viewing us
		return//so we're not searching everything in view every tick

	if(obsession in view(7, owner))
		viewing = TRUE
	else
		viewing = FALSE
	if(viewing)
		H.adjustArousal(3) //Nymph looking at their target and get aroused. Everything logical.

/datum/brain_trauma/special/sexual_obsession/proc/stare(datum/source, mob/living/examining_mob, triggering_examiner)
	SIGNAL_HANDLER
	if(examining_mob != owner || !triggering_examiner || prob(80))
		return
	addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, obsession, span_warning("You catch [examining_mob] staring at you lustfully..."), 3))
	return COMSIG_BLOCK_EYECONTACT

/datum/brain_trauma/special/sexual_obsession/proc/find_obsession()
	var/list/viable_minds = list() //The first list, which excludes hijinks
	var/list/possible_targets = list() //The second list, which filters out silicons and simplemobs
	var/list/special_pool = list() //The special list, for quirk-based
	var/chosen_victim  //The obsession target

	for(var/mob/player in GLOB.player_list) //prevents crewmembers falling in love with nuke ops they never met, and other annoying hijinks
		if(SSticker.IsRoundInProgress() && istype(get_area(player), /area/centcom/interlink))
			continue
		if(player.mind && player.stat != DEAD && !isnewplayer(player) && !isbrain(player) && player.client && player != owner && SSjob.GetJob(player.mind.assigned_role))
			if(player?.client?.prefs?.read_preference(/datum/preference/toggle/erp/noncon))
				viable_minds += player.mind
	for(var/datum/mind/possible_target in viable_minds)
		if(possible_target != owner && ishuman(possible_target.current))
			possible_targets += possible_target.current

	//Do we have any special target?
	if(length(special_pool))
		chosen_victim = pick(special_pool)
		return chosen_victim

	//If not, pick any other ordinary target
	if(possible_targets.len > 0)
		chosen_victim = pick(possible_targets)
	return chosen_victim

/////////////////
///BIMBO TRAIT///
/////////////////

/datum/brain_trauma/special/bimbo
	name = "Permanent hormonal disruption"
	desc = "The patient has completely lost the ability to form speech and seems extremely aroused."
	scan_desc = "permanent hormonal disruption"
	gain_text = span_purple("Your thoughts get cloudy, but it turns you on like hell.")
	lose_text = span_warning("A pleasant coolness spreads throughout your body, You are thinking clearly again.")
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	var/satisfaction = 1000
	var/stress = 0

/datum/brain_trauma/special/bimbo/on_life()
	var/mob/living/carbon/human/H = owner
	if(satisfaction > 1)
		satisfaction -=1

	H.adjustArousal(10)

	if(H.pleasure < 80)
		H.adjustPleasure(5)

	if(satisfaction <= 0)
		if(prob(10))
			switch(rand(1,6))
				if(1)
					if(stress >= 100)
						to_chat(owner, span_purple("You feel slightly aroused..."))
					else
						to_chat(owner, span_purple("Lust spreads over your body!"))
						owner.emote("moan")
				if(2)
					if(stress >= 100)
						to_chat(owner, span_purple("You can't stop shaking..."))
						owner.do_jitter_animation(20)
					else
						to_chat(owner, span_purple("You feel hot and seduced!"))
						owner.dizziness += 20
						owner.add_confusion(20)
						owner.Jitter(20)
						owner.do_jitter_animation(20)
						owner.adjustStaminaLoss(50)
				if(3, 4)
					if(stress >= 100)
						to_chat(owner, span_purple("You bring your thighs together in lust."))
					else
						to_chat(owner, span_purple("Desire is driving you mad!"))
						owner.hallucination += 30
				if(5)
					if(stress >= 100)
						to_chat(owner, span_purple("You feel like your genitals are burning..."))
						owner.adjustOxyLoss(8)
						owner.blur_eyes(10)
					else
						to_chat(owner, span_purple("You need something to satisfy this desire! Something... Or someone?"))
						owner.adjustOxyLoss(16)
						owner.blur_eyes(15)
						owner.visible_message(pick(span_purple("[owner] wags their hips seductively.") + "\n",
											span_purple("[owner] moans in lust!") + "\n",
											span_purple("[owner] touches [owner.p_them()]self in intimate places...") + "\n",
											span_purple("[owner] trembling longingly.") + "\n",
											span_purple("[owner] moans indecently!") + "\n"))

	if(in_company() && satisfaction >= 0)
		satisfaction -= 1

	if(in_company() && satisfaction == 300)
		to_chat(owner, span_purple("Jeez, it's hot in here.."))

	if(in_company() && satisfaction == 250)
		to_chat(owner, span_purple("Desire fogs your decisions."))

	if(in_company() && satisfaction == 200)
		to_chat(owner, span_purple("Your clothes grow uncomfortable."))

	if(in_company() && satisfaction == 150)
		to_chat(owner, span_purple("You'd hit that. Yeah. That's at least a six."))

	if(in_company() && satisfaction == 100)
		to_chat(owner, span_purple("You can't STAND it, you need a partner NOW!")	)

	if(in_company() && satisfaction <= 0)
		if(stress <= 100)
			stress +=1

	if(in_company() && owner.has_status_effect(/datum/status_effect/climax))
		stress = 0
		satisfaction = 1000

	if(!(in_company()) && owner.has_status_effect(/datum/status_effect/climax) && satisfaction <= 500)
		stress = 0
		satisfaction = 500

/datum/brain_trauma/special/bimbo/proc/in_company()
	if(HAS_TRAIT(owner, TRAIT_BLIND))
		return FALSE
	for(var/mob/living/carbon/human/M in oview(owner, 4))
		if(!isliving(M)) //ghosts ain't people
			continue
		if(istype(M))
			return TRUE
	return FALSE

/datum/brain_trauma/special/bimbo/handle_speech(datum/source, list/speech_args)
	if(HAS_TRAIT(owner, TRAIT_BIMBO))
		var/message = speech_args[SPEECH_MESSAGE]
		var/list/split_message = splittext(message, " ") //List each word in the message
		for (var/i in 1 to length(split_message))
			if(findtext(split_message[i], "*") || findtext(split_message[i], ";") || findtext(split_message[i], ":"))
				continue
			split_message[i] = pick("Mmmph... Guuuh.","Hmmphh","Mmmfhg","Gmmmh...","Hnnnnngh... Ghh","Fmmmmph...")

		message = jointext(split_message, " ")
		speech_args[SPEECH_MESSAGE] = message

/datum/brain_trauma/special/bimbo/on_gain()
	SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "bimbo", /datum/mood_event/bimbo)
	ADD_TRAIT(owner,TRAIT_BIMBO, APHRO_TRAIT)
	RegisterSignal(owner, COMSIG_MOB_SAY, .proc/handle_speech)
	ADD_TRAIT(owner,TRAIT_MASOCHISM, APHRO_TRAIT)

/datum/brain_trauma/special/bimbo/on_lose()
	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "bimbo", /datum/mood_event/bimbo)
	REMOVE_TRAIT(owner,TRAIT_BIMBO, APHRO_TRAIT)
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	REMOVE_TRAIT(owner,TRAIT_MASOCHISM, APHRO_TRAIT)

//Mood boost
/datum/mood_event/bimbo
	description = span_purple("So-o... Help..less... Lo-ve it!\n")

///////////////
///MASOCHISM///
///////////////

/datum/quirk/masochism
	name = "Masochism"
	desc = "Pain brings you indescribable pleasure."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_MASOCHISM
	gain_text = span_danger("You have a sudden desire for pain...")
	lose_text = span_notice("Ouch! Pain is... Painful again! Ou-ou-ouch!")
	medical_record_text = "Subject has masochism."
	icon = "heart-broken"

/datum/quirk/masochism/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	ADD_TRAIT(H,TRAIT_MASOCHISM, LEWDQUIRK_TRAIT)
	H.pain_limit = 60

/datum/quirk/masochism/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	REMOVE_TRAIT(H,TRAIT_MASOCHISM, LEWDQUIRK_TRAIT)
	H.pain_limit = 0

////////////////
///NEVERBONER///
////////////////

/datum/brain_trauma/special/neverboner
	name = "Loss of libido"
	desc = "The patient has completely lost sexual interest."
	scan_desc = "lack of libido"
	gain_text = span_notice("You don't feel horny anymore.")
	lose_text = span_notice("A pleasant warmth spreads over your body.")
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/special/neverboner/on_gain()
	var/mob/living/carbon/human/H = owner
	ADD_TRAIT(H,TRAIT_NEVERBONER, APHRO_TRAIT)

/datum/brain_trauma/special/neverboner/on_lose()
	var/mob/living/carbon/human/H = owner
	REMOVE_TRAIT(H,TRAIT_NEVERBONER, APHRO_TRAIT)

////////////
///SADISM///
////////////

/datum/quirk/sadism
	name = "Sadism"
	desc = "You feel pleasure when you see someone in agony."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_SADISM
	gain_text = span_danger("You feel a sudden desire to inflict pain.")
	lose_text = span_notice("Others' pain doesn't satisfy you anymore.")
	medical_record_text = "Subject has sadism."
	icon = "hammer"

/datum/quirk/sadism/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/sadism/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/brain_trauma/special/sadism
	name = "Sadism"
	desc = "The subject's cerebral pleasure centers are more active when someone is suffering."
	scan_desc = "sadistic tendencies"
	gain_text = span_purple("You feel a desire to hurt somebody.")
	lose_text = span_notice("You feel compassion again.")
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/special/sadism/on_life(delta_time, times_fired)
	var/mob/living/carbon/human/H = owner
	if(someone_suffering() && H.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		H.adjustArousal(2)
		SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "sadistic", /datum/mood_event/sadistic)
	else
		SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "sadistic", /datum/mood_event/sadistic)

/datum/brain_trauma/special/sadism/proc/someone_suffering()
	if(HAS_TRAIT(owner, TRAIT_BLIND))
		return FALSE
	for(var/mob/living/carbon/human/M in oview(owner, 4))
		if(!isliving(M)) //ghosts ain't people
			continue
		if(istype(M) && M.pain >= 10)
			return TRUE
	return FALSE

/datum/mood_event/sadistic
	description = span_purple("Others' suffering makes me happier\n")

//////////////////
///EMPATH BOUNS///
//////////////////
/mob/living/carbon/human/examine(mob/user)
	.=..()
	var/mob/living/U = user

	if(stat != DEAD && !HAS_TRAIT(src, TRAIT_FAKEDEATH) && src != U)
		if(src != user)
			if(HAS_TRAIT(U, TRAIT_EMPATH))
				switch(arousal)
					if(11 to 21)
						. += span_purple("[p_they()] [p_are()] excited.") + "\n"
					if(21.01 to 41)
						. += span_purple("[p_they()] [p_are()] slightly blushed.") + "\n"
					if(41.01 to 51)
						. += span_purple("[p_they()] [p_are()] quite aroused and seems to be stirring up lewd thoughts in [p_their()] head.") + "\n"
					if(51.01 to 61)
						. += span_purple("[p_they()] [p_are()] very aroused and [p_their()] movements are seducing.") + "\n"
					if(61.01 to 91)
						. += span_purple("[p_they()] [p_are()] aroused as hell.") + "\n"
					if(91.01 to INFINITY)
						. += span_purple("[p_they()] [p_are()] extremely excited, exhausting from entolerable desire.") + "\n"
