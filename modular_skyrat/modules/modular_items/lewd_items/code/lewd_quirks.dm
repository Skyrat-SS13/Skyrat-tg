//////////////////////////
///CODE FOR LEWD QUIRKS///
//////////////////////////

/////////////////
///NYMPHOMANIA///
/////////////////

/datum/quirk/nymphomania
	name = "Nymphomania"
	desc = "You have an overwhelming urge to have sex with someone. Constantly."
	value = -2 //This gives you uncomfortable stuff. But you can change it to 0. Don't change to positive values, it will be dumb.
	mob_trait = TRAIT_NYMPHOMANIA
	gain_text = "<font color=purple>You feel yourself much more hornier than before...</font>"
	lose_text = "<span class='notice'>A pleasant coolness spreads through the body. You are in control of your sexual desires again.</font>"
	medical_record_text = "Subject has nymphomania."
	var/obj/item/sextoy
	var/where

//nymphomania players need to satisfy lust, so they need "tools" to "cool" them from time to time. In case if there is NO PLAYERS AROUND.
/datum/quirk/nymphomania/add_unique()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/sextoy_type
	var/obj/item/organ/genital/vagina = quirk_holder.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/penis = quirk_holder.getorganslot(ORGAN_SLOT_PENIS)
	if(vagina && penis)
		sextoy_type = /obj/item/clothing/sextoy/magic_wand
	else if(penis)
		sextoy_type = /obj/item/clothing/sextoy/fleshlight
	else if(vagina)
		sextoy_type = /obj/item/clothing/sextoy/dildo
	else
		sextoy_type = /obj/item/clothing/sextoy/magic_wand

	sextoy = new sextoy_type(get_turf(quirk_holder))
	H.put_in_hands(sextoy)

/datum/quirk/nymphomania/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/special/nymphomania, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/nymphomania/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/special/nymphomania, TRAUMA_RESILIENCE_ABSOLUTE)

//Brain trauma for quirk
//Nymphomania brain trauma code

/datum/brain_trauma/special/nymphomania
	name = "Nymphomania"
	desc = "The patient constantly feels aroused and supposed to satisfy their sexual desires."
	scan_desc = "constant sexual arousal"
	gain_text = "<font color=purple>You feel yourself much more hornier than before...</font>"
	lose_text = "<span class='notice'>A pleasant coolness spreads through the body. You are in control of your sexual desires again.</font>"
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE
	var/satisfaction = 100
	var/stress = 0

/datum/brain_trauma/special/nymphomania/on_gain()
	owner.set_nymphomania(TRUE)

/datum/brain_trauma/special/nymphomania/on_lose()
	owner.set_nymphomania(FALSE)

/datum/brain_trauma/special/nymphomania/on_life(delta_time, times_fired)
	if(owner.stat != CONSCIOUS)
		return

	if(satisfaction <= 0)
		switch(rand(1,6))
			if(1)
				if(stress >= 100)
					to_chat(owner, "<font color=purple>You feel slightly aroused...</font>")
				else
					to_chat(owner, "<font color=purple>Lust spreads over your body!</font>")
					owner.emote("moan")
			if(2)
				if(stress >= 100)
					to_chat(owner, "<font color=purple>You can't stop shaking...</font>")
					owner.do_jitter_animation(20)
				else
					to_chat(owner, "<font color=purple>You feel hot and seduced!</font>")
					owner.dizziness += 20
					owner.add_confusion(20)
					owner.Jitter(20)
					owner.do_jitter_animation(20)
					owner.adjustStaminaLoss(50)
			if(3, 4)
				if(stress >= 100)
					to_chat(owner, "<font color=purple>You bring your hips together in lust.</font>")
				else
					to_chat(owner, "<font color=purple>Desire driving you mad!</font>")
					owner.hallucination += 30
			if(5)
				if(stress >= 100)
					to_chat(owner, "<font color=purple>You feel like your genitalias are burning...</font>")
					owner.adjustOxyLoss(8)
					owner.blur_eyes(10)
				else
					to_chat(owner, "<font color=purple>You need something to satisfy this desire! Something... Or someone?</font>")
					owner.adjustOxyLoss(16)
					owner.blur_eyes(15)
					owner.visible_message(pick("<font color=purple>[owner] seductively wags the hips.</font>\n",
										"<font color=purple>[owner] moans in lust!</font>\n",
										"<font color=purple>[owner] touches themselves in intimate places...</font>\n",
										"<font color=purple>[owner] trembling longingly.</font>\n",
										"<font color=purple>[owner] moans indecently!</font>\n"))

	if(in_company() && satisfaction >= 0.15)
		satisfaction -= 0.15

	if(in_company() && satisfaction <= 0.15)
		if(stress <= 100)
			stress +=1

	if(in_company() && owner.has_status_effect(/datum/status_effect/climax))
		stress = 0
		satisfaction = 100

/datum/brain_trauma/special/nymphomania/proc/in_company()
	if(HAS_TRAIT(owner, TRAIT_BLIND))
		return FALSE
	for(var/mob/living/carbon/human/M in oview(owner, 4))
		if(!isliving(M)) //ghosts ain't people
			continue
		if(istype(M))
			return TRUE
	return FALSE

//////////////////////
///SEXUAL OBSESSION///
//////////////////////
/*
/datum/quirk/sexual_obsession
	name = "Sexual obsession"
	desc = "You have an overwhelming urge to have sex with random people. Constantly."
	value = -6 //This gives you uncomfortable stuff. But you can change it to 0. Don't change to positive values, it will be dumb.
	mob_trait = TRAIT_SOBSESSED
	gain_text = "<font color=purple>You feel yourself much more hornier than before...</font>"
	lose_text = "<span class='notice'>A pleasant coolness spreads through the body. You are in control of your sexual desires again.</font>"
	medical_record_text = "Subject has sexual obsession."
	var/obj/item/sextoy
	var/where

//nymphomania players need to satisfy lust, so they need "tools" to "cool" them from time to time. In case if there is NO PLAYERS AROUND.
/datum/quirk/sexual_obsession/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/sextoy_type
	var/obj/item/organ/genital/vagina = quirk_holder.getorganslot(ORGAN_SLOT_VAGINA)
	var/obj/item/organ/genital/penis = quirk_holder.getorganslot(ORGAN_SLOT_PENIS)
	if(vagina && penis)
		sextoy_type = /obj/item/magic_wand
	else if(penis)
		sextoy_type = /obj/item/fleshlight
	else if(vagina)
		sextoy_type = /obj/item/dildo
	else
		sextoy_type = /obj/item/magic_wand

	sextoy = new sextoy_type(get_turf(quirk_holder))
	H.put_in_hands(sextoy)

/datum/quirk/sexual_obsession/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/special/sexual_obsession, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/sexual_obsession/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/special/sexual_obsession, TRAUMA_RESILIENCE_ABSOLUTE)

Removed it as quirk because it can cause huge disaster and furry massacre.
I already saw enough in "Long digger" video

But i keeped it as unobtainable breain trauma, so admins can add it through VV *IN VERY SPECIFIC SITUATIONS*. If you're not lazy you can add it as smite, but i wouldn't recommend it.
*/


/datum/brain_trauma/special/sexual_obsession
	name = "Sexual obsession"
	desc = "The patient obsessed with having sex with random people."
	scan_desc = "sexual obsession"
	gain_text = ""
	lose_text = "<span class='notice'>You feel yourself much more calmer than before. You don't feel the need to harass anybody.</font>"
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
	gain_text = "<font color=purple>You feel indescribable needing to have a sex with someone...</font>"
	ADD_TRAIT(owner,TRAIT_SOBSESSED,APHRO_TRAIT)

/datum/brain_trauma/special/sexual_obsession/on_lose()
	REMOVE_TRAIT(owner,TRAIT_SOBSESSED,APHRO_TRAIT)

/datum/brain_trauma/special/sexual_obsession/on_life(delta_time, times_fired)
	if(satisfaction <= 0)
		if(stress <= 100)
			stress +=1
		switch(rand(1,6))
			if(1)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You feel slightly aroused...</font>")
				else
					to_chat(owner, "<font color=purple>Lust spreads over your body!</font>")
					owner.emote("moan")
			if(2)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You can't stop shaking...</font>")
					owner.do_jitter_animation(20)
				else
					to_chat(owner, "<font color=purple>You feel hot and seduced!</font>")
					owner.dizziness += 20
					owner.add_confusion(20)
					owner.Jitter(20)
					owner.do_jitter_animation(20)
					owner.adjustStaminaLoss(50)

			if(3, 4)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You bring your hips together in lust.</font>")
				else
					to_chat(owner, "<font color=purple>Desire driving you mad!</font>")
					owner.hallucination += 30

			if(5)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You feel like your genitalias are burning...</font>")
					owner.adjustOxyLoss(8)
					owner.blur_eyes(10)
				else
					to_chat(owner, "<font color=purple>You need something to satisfy this desire! Something... Or someone?</font>")
					owner.adjustOxyLoss(16)
					owner.blur_eyes(10)
					owner.visible_message(pick("<font color=purple>[owner] seductively wags the hips.</font>\n",
										"<font color=purple>[owner] moans in lust!</font>\n",
										"<font color=purple>[owner] touches themselves in intimate places...</font>\n",
										"<font color=purple>[owner] trembling longingly.</font>\n",
										"<font color=purple>[owner] moans indecently!</font>\n"))
	if(satisfaction >= 0.15)
		satisfaction -= 0.15

	if(satisfaction <= 0.15)
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
		owner.adjustArousal(3) //Nymph looking at their target and get aroused. Everything logical.

/datum/brain_trauma/special/sexual_obsession/proc/stare(datum/source, mob/living/examining_mob, triggering_examiner)
	SIGNAL_HANDLER
	if(examining_mob != owner || !triggering_examiner || prob(80))
		return
	addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, obsession, "<span class='warning'>You catch [examining_mob] lustfully staring at you...</span>", 3))
	return COMSIG_BLOCK_EYECONTACT

/datum/brain_trauma/special/sexual_obsession/proc/find_obsession()
	var/list/viable_minds = list() //The first list, which excludes hijinks
	var/list/possible_targets = list() //The second list, which filters out silicons and simplemobs
	var/list/special_pool = list() //The special list, for quirk-based
	var/chosen_victim  //The obsession target

	for(var/mob/Player in GLOB.player_list)//prevents crewmembers falling in love with nuke ops they never met, and other annoying hijinks
		if(Player.mind && Player.stat != DEAD && !isnewplayer(Player) && !isbrain(Player) && Player.client && Player != owner && SSjob.GetJob(Player.mind.assigned_role))
			if(Player.client.prefs?.erp_pref == "Yes" && Player.client.prefs?.noncon_pref == "Yes")
				viable_minds += Player.mind
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
	gain_text = "<font color=purple>Your thoughts get cloudy, but it seems like it turns you on as hell.</font>"
	lose_text = "<span class='warning'>A pleasant coolness spreads through your body, You are thinking clearly again.</span>"
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	var/satisfaction = 100
	var/stress = 0

/datum/brain_trauma/special/bimbo/on_life()
	if(satisfaction > 0.1)
		satisfaction -=0.1
	owner.adjustArousal(10)
	if(owner.pleasure < 70)
		owner.adjustPleasure(5)
	if(satisfaction <= 0.1)
		if(stress <= 100)
			stress +=1
		switch(rand(1,6))
			if(1)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You feel slightly aroused...</font>")
				else
					to_chat(owner, "<font color=purple>Lust spreads over your body!</font>")
					owner.emote("moan")
			if(2)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You can't stop shaking...</font>")
					owner.do_jitter_animation(20)
				else
					to_chat(owner, "<font color=purple>You feel hot and seduced!</font>")
					owner.dizziness += 20
					owner.add_confusion(20)
					owner.Jitter(20)
					owner.do_jitter_animation(20)
					owner.adjustStaminaLoss(50)

			if(3, 4)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You bring your hips together in lust.</font>")
				else
					to_chat(owner, "<font color=purple>Desire driving you mad!</font>")
					owner.hallucination += 30

			if(5)
				if(stress < 95)
					to_chat(owner, "<font color=purple>You feel like your genitalias are burning...</font>")
					owner.adjustOxyLoss(8)
					owner.blur_eyes(10)
				else
					to_chat(owner, "<font color=purple>You need something to satisfy this desire! Something... Or someone?</font>")
					owner.adjustOxyLoss(16)
					owner.blur_eyes(10)
					owner.visible_message(pick("<font color=purple>[owner] seductively wags the hips.</font>\n",
										"<font color=purple>[owner] moans in lust!</font>\n",
										"<font color=purple>[owner] touches themselves in intimate places...</font>\n",
										"<font color=purple>[owner] trembling longingly.</font>\n",
										"<font color=purple>[owner] moans indecently!</font>\n"))

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
	owner.set_masochism(TRUE)
	owner.set_nymphomania(TRUE)

/datum/brain_trauma/special/bimbo/on_lose()
	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "bimbo", /datum/mood_event/bimbo)
	REMOVE_TRAIT(owner,TRAIT_BIMBO, APHRO_TRAIT)
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	owner.set_masochism(FALSE)
	owner.set_nymphomania(FALSE)

//Mood boost
/datum/mood_event/bimbo
	description = "<font color=purple>So-o... Help..less... Lo-ve it!</font>\n"
	mood_change = 20

///////////////
///MASOCHISM///
///////////////

/datum/quirk/masochism
	name = "Masochism"
	desc = "Pain brings you indescribable pleasure."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_MASOCHISM
	gain_text = "<span class='danger'>You feel youself much more perverted to pain...</font>"
	lose_text = "<span class='notice'>Ouch! Pain is... Painful again! Ou-ou-ouch!</font>"
	medical_record_text = "Subject has masochism."

/datum/quirk/masochism/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.set_masochism(TRUE)

/datum/quirk/masochism/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.set_masochism(FALSE)

////////////////
///NEVERBONER///
////////////////

/datum/brain_trauma/special/neverboner
	name = "Loss of libido"
	desc = "The patient has completely lost sexual interest."
	scan_desc = "lack of libido"
	gain_text = "<span class='notice'>You don't feel yourself horny anymore.</font>"
	lose_text = "<span class='notice'>Pleasant warmth spreads over your body.</font>"
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/special/neverboner/on_gain()
	owner.set_neverboner(TRUE)

/datum/brain_trauma/special/neverboner/on_lose()
	owner.set_neverboner(FALSE)

////////////
///SADISM///
////////////

/datum/quirk/sadism
	name = "Sadism"
	desc = "You feel pleasure when you see someone in agony."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_SADISM
	gain_text = "<span class='danger'>You feel more pleasured when someone feeling pain.</font>"
	lose_text = "<span class='notice'>Pain doesn't satisfy you anymore.</font>"
	medical_record_text = "Subject has sadism."

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
	gain_text = "<font color=purple>You feel like you need to hurt somebody.</font>"
	lose_text = "<span class='notice'>You feel compassion again.</font>"
	can_gain = TRUE
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/special/sadism/on_life(delta_time, times_fired)
	var/mob/living/carbon/human/H = owner
	if(someone_suffering() && H.client?.prefs.erp_pref == "Yes")
		owner.adjustArousal(2)
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

//Mood boost
/datum/mood_event/sadistic
	description = "<font color=purple>Someone else's suffering makes me happier</font>\n"
	mood_change = 4

//////////////////
///EMPATH BOUNS///
//////////////////
/mob/living/carbon/human/examine(mob/user)
	.=..()
	var/t_He = p_they(TRUE)
	var/t_his = p_their()
	var/t_is = p_are()
	var/mob/living/U = user

	if(stat != DEAD && !HAS_TRAIT(src, TRAIT_FAKEDEATH) && src != U)
		if(src != user)
			if(HAS_TRAIT(U, TRAIT_EMPATH))
				switch(arousal)
					if(11 to 21)
						. += "<font color=purple>[t_He] [t_is] excited.</font>\n"
					if(21.01 to 41)
						. += "<font color=purple>[t_He] [t_is] slightly blushed.</font>\n"
					if(41.01 to 51)
						. += "<font color=purple>[t_He] [t_is] quite aroused and seems to be stirring up lewd thoughts in [t_his] head.</font>\n"
					if(51.01 to 61)
						. += "<font color=purple>[t_He] [t_is] very aroused and [t_his] movements are seducing.</font>\n"
					if(61.01 to 91)
						. += "<font color=purple>[t_He] looks aroused as hell.</font>\n"
					if(91.01 to INFINITY)
						. += "<font color=purple>[t_He] [t_is] extremely excited, exhausting from entolerable desire.</font>\n"
