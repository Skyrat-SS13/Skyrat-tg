/*
/*
*	BIMBO
*/

/datum/brain_trauma
	///Whether the trauma will be displayed on a scanner or kiosk
	var/display_scanner = TRUE

/datum/brain_trauma/special/bimbo
	name = "Permanent hormonal disruption"
	desc = "The patient has completely lost the ability to form speech and seems extremely aroused."
	scan_desc = "permanent hormonal disruption"
	gain_text = span_purple("Your thoughts get cloudy, but it turns you on like hell.")
	lose_text = span_warning("A pleasant coolness spreads throughout your body, You are thinking clearly again.")
	//people need to be able to gain it through the chemical OD
	can_gain = TRUE
	//people should not be able to randomly get this trauma
	random_gain = FALSE
	//we don't want this to be displayed on a scanner
	display_scanner = FALSE
	resilience = TRAUMA_RESILIENCE_LOBOTOMY
	///how satisfied the person is, gained through climaxing
	//max is 300, min is 0
	var/satisfaction = 300
	///how stressed the person is, gained through zero satisfaction
	//max is 300, min is 0
	var/stress = 0

	COOLDOWN_DECLARE(desire_cooldown)
	///The time between each desire message within company
	var/desire_cooldown_number = 30 SECONDS
	///The list of manual emotes that will be done when unsatisfied
	var/static/list/lust_emotes = list(
		"pants as their body trembles lightly.",
		"lightly touches themselves up and down, feeling every inch.",
		"puts their finger in their mouth and slightly bites down.",
		"places their hands on their hip as they slowly gyrate.",
		"moans, their head tilted slightly."
	)

/**
 * If we are not satisfied, this will be ran through
 */
/datum/brain_trauma/special/bimbo/proc/try_unsatisfied()
	var/mob/living/carbon/human/human_owner = owner
	//we definitely need an owner; but if you are satisfied, just return
	if(satisfaction || !human_owner)
		return FALSE
	//we need to feel consequences for being unsatisfied
	//the message that will be sent to the owner at the end
	var/lust_message = "Your breath begins to feel warm..."
	//we are using if statements so that it slowly becomes more and more to the person
	human_owner.manual_emote(pick(lust_emotes))
	if(stress >= 60)
		human_owner.set_timed_status_effect(40 SECONDS, /datum/status_effect/jitter, only_if_higher = TRUE)
		lust_message = "You feel a static sensation all across your skin..."
	if(stress >= 120)
		human_owner.blur_eyes(10)
		lust_message = "You vision begins to blur, the heat beginning to rise..."
	if(stress >= 180)
		owner.hallucination += 30
		lust_message = "You begin to fantasize of what you could do to someone..."
	if(stress >= 240)
		human_owner.adjustStaminaLoss(30)
		lust_message = "You body feels so very hot, almost unwilling to cooperate..."
	if(stress >= 300)
		human_owner.adjustOxyLoss(40)
		lust_message = "You feel your neck tightening, straining..."
	to_chat(human_owner, span_purple(lust_message))
	return TRUE

/**
 * If we have climaxed, return true
 */
/datum/brain_trauma/special/bimbo/proc/check_climaxed()
	if(owner.has_status_effect(/datum/status_effect/climax))
		stress = 0
		satisfaction = 300
		return TRUE
	return FALSE

/datum/brain_trauma/special/bimbo/on_life()
	var/mob/living/carbon/human/human_owner = owner

	//Check if we climaxed, if so, just stop for now
	if(check_climaxed())
		return
	//if we are satisfied, slowly lower satisfaction as well as stress
	if(satisfaction)
		satisfaction = clamp(satisfaction - 1, 0, 300)
		stress = clamp(stress - 1, 0, 300)
	//since we are not satisfied, increase our stress
	else
		stress = clamp(stress + 1, 0, 300)

	human_owner.adjustArousal(10)
	if(human_owner.pleasure < 80)
		human_owner.adjustPleasure(5)

	//Anything beyond this obeys a cooldown system because we don't want to spam it
	if(!COOLDOWN_FINISHED(src, desire_cooldown))
		return
	COOLDOWN_START(src, desire_cooldown, desire_cooldown_number)

	//if we are unsatisfied, do this code block and then stop
	if(try_unsatisfied())
		return

	//Anything beyond this requires company
	if(!in_company())
		//since you aren't within company, you won't be satisfied
		satisfaction = clamp(satisfaction - 1, 0, 1000)
		to_chat(human_owner, span_purple("You feel so alone without someone..."))
		return

	switch(satisfaction)
		if(0 to 100)
			to_chat(human_owner, span_purple("You can't STAND it, you need a partner NOW!"))
		if(101 to 150)
			to_chat(human_owner, span_purple("You'd hit that. Yeah. That's at least a six."))
		if(151 to 200)
			to_chat(human_owner, span_purple("Your clothes are feeling tight."))
		if(201 to 250)
			to_chat(human_owner, span_purple("Desire fogs your decisions."))
		if(251 to 1000)
			to_chat(human_owner, span_purple("Jeez, it's hot in here.."))

/**
 * If we have another human in view, return true
 */
/datum/brain_trauma/special/bimbo/proc/in_company()
	for(var/mob/living/carbon/human/human_check in oview(owner, 4))
		if(!istype(human_check))
			continue
		return TRUE
	return FALSE

/datum/brain_trauma/special/bimbo/handle_speech(datum/source, list/speech_args)
	if(!HAS_TRAIT(owner, TRAIT_BIMBO)) //You have the trauma but not the trait, go ahead and fail here
		return ..()
	var/message = speech_args[SPEECH_MESSAGE]
	var/list/split_message = splittext(message, " ") //List each word in the message
	for (var/i in 1 to length(split_message))
		if(findtext(split_message[i], "*") || findtext(split_message[i], ";") || findtext(split_message[i], ":"))
			continue
		if(prob(10))
			var/insert_muffle = pick("... Mmmph...", "... Hmmphh...", "... Gmmmh...", "... Fmmmmph...")
			split_message[i] = split_message[i] + insert_muffle

	message = jointext(split_message, " ")
	speech_args[SPEECH_MESSAGE] = message

/datum/brain_trauma/special/bimbo/on_gain()
	SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "bimbo", /datum/mood_event/bimbo)
	if(!HAS_TRAIT_FROM(owner, TRAIT_BIMBO, LEWDCHEM_TRAIT))
		ADD_TRAIT(owner, TRAIT_BIMBO, LEWDCHEM_TRAIT)
	RegisterSignal(owner, COMSIG_MOB_SAY, .proc/handle_speech)
	if(!HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, APHRO_TRAIT))
		ADD_TRAIT(owner, TRAIT_MASOCHISM, APHRO_TRAIT)

/datum/brain_trauma/special/bimbo/on_lose()
	SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "bimbo", /datum/mood_event/bimbo)
	if(HAS_TRAIT_FROM(owner, TRAIT_BIMBO, LEWDCHEM_TRAIT))
		REMOVE_TRAIT(owner, TRAIT_BIMBO, LEWDCHEM_TRAIT)
	UnregisterSignal(owner, COMSIG_MOB_SAY)
	if(HAS_TRAIT_FROM(owner, TRAIT_MASOCHISM, APHRO_TRAIT))
		REMOVE_TRAIT(owner, TRAIT_MASOCHISM, APHRO_TRAIT)

//Mood boost
/datum/mood_event/bimbo
	description = span_purple("So-o... Help..less... Lo-ve it!\n")

/*
*	MASOCHISM
*/

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
	var/mob/living/carbon/human/affected_human = quirk_holder
	ADD_TRAIT(affected_human, TRAIT_MASOCHISM, LEWDQUIRK_TRAIT)
	affected_human.pain_limit = 60

/datum/quirk/masochism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	REMOVE_TRAIT(affected_human, TRAIT_MASOCHISM, LEWDQUIRK_TRAIT)
	affected_human.pain_limit = 0

/*
*	NEVERBONER
*/

/datum/brain_trauma/special/neverboner
	name = "Loss of libido"
	desc = "The patient has completely lost sexual interest."
	scan_desc = "lack of libido"
	gain_text = span_notice("You don't feel horny anymore.")
	lose_text = span_notice("A pleasant warmth spreads over your body.")
	random_gain = FALSE
	resilience = TRAUMA_RESILIENCE_ABSOLUTE

/datum/brain_trauma/special/neverboner/on_gain()
	var/mob/living/carbon/human/affected_human = owner
	ADD_TRAIT(affected_human, TRAIT_NEVERBONER, APHRO_TRAIT)

/datum/brain_trauma/special/neverboner/on_lose()
	var/mob/living/carbon/human/affected_human = owner
	REMOVE_TRAIT(affected_human, TRAIT_NEVERBONER, APHRO_TRAIT)

/*
*	SADISM
*/

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
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human.gain_trauma(/datum/brain_trauma/special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/sadism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	affected_human?.cure_trauma_type(/datum/brain_trauma/special/sadism, TRAUMA_RESILIENCE_ABSOLUTE)

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
	var/mob/living/carbon/human/affected_mob = owner
	if(someone_suffering() && affected_mob.client?.prefs?.read_preference(/datum/preference/toggle/erp))
		affected_mob.adjustArousal(2)
		SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "sadistic", /datum/mood_event/sadistic)
	else
		SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "sadistic", /datum/mood_event/sadistic)

/datum/brain_trauma/special/sadism/proc/someone_suffering()
	if(HAS_TRAIT(owner, TRAIT_BLIND))
		return FALSE
	for(var/mob/living/carbon/human/iterated_mob in oview(owner, 4))
		if(!isliving(iterated_mob)) //ghosts ain't people
			continue
		if(istype(iterated_mob) && iterated_mob.pain >= 10)
			return TRUE
	return FALSE

//Shibari update quirks: Rope bunny and rigger. One have additional mood bonus (0) and exist for same reason as ananas affinity, other one can faster tie ropes on character because why not.
//Rope bunny code
/datum/quirk/ropebunny
	name = "Rope bunny"
	desc = "You love being tied up."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_ROPEBUNNY
	gain_text = span_danger("You really want to be restrained for some reason.")
	lose_text = span_notice("Being restrained doesn't arouse you anymore.")
	icon = "link"

/datum/quirk/ropebunny/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_ROPEBUNNY, LEWDQUIRK_TRAIT)

/datum/quirk/ropebunny/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_ROPEBUNNY, LEWDQUIRK_TRAIT)

//Rigger code
/datum/quirk/rigger
	name = "Rigger"
	desc = "You find the weaving of rope knots on the body wonderful."
	value = 0 //ERP Traits don't have price. They are priceless. Ba-dum-tss
	mob_trait = TRAIT_RIGGER
	gain_text = span_danger("Suddenly you understand rope weaving much better than before.")
	lose_text = span_notice("Rope knots looks complicated again.")
	icon = "chain-broken"

/datum/quirk/rigger/post_add()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	ADD_TRAIT(affected_mob, TRAIT_RIGGER, LEWDQUIRK_TRAIT)

/datum/quirk/rigger/remove()
	. = ..()
	var/mob/living/carbon/human/affected_mob = quirk_holder
	REMOVE_TRAIT(affected_mob, TRAIT_RIGGER, LEWDQUIRK_TRAIT)
/datum/mood_event/sadistic
	description = span_purple("Others' suffering makes me happier\n")

/*
*	EMPATH BONUS
*/

/mob/living/carbon/human/examine(mob/user)
	. = ..()
	var/mob/living/examiner = user
	if(stat != DEAD && !HAS_TRAIT(src, TRAIT_FAKEDEATH) && src != examiner)
		if(src != user)
			if(HAS_TRAIT(examiner, TRAIT_EMPATH))
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
*/
