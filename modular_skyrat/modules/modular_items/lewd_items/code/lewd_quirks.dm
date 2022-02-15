//////////////////////////
///CODE FOR LEWD QUIRKS///
//////////////////////////

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
	var/mob/living/carbon/human/affected_human = quirk_holder
	ADD_TRAIT(affected_human, TRAIT_MASOCHISM, LEWDQUIRK_TRAIT)
	affected_human.pain_limit = 60

/datum/quirk/masochism/remove()
	. = ..()
	var/mob/living/carbon/human/affected_human = quirk_holder
	REMOVE_TRAIT(affected_human, TRAIT_MASOCHISM, LEWDQUIRK_TRAIT)
	affected_human.pain_limit = 0

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
	var/mob/living/carbon/human/affected_human = owner
	ADD_TRAIT(affected_human, TRAIT_NEVERBONER, APHRO_TRAIT)

/datum/brain_trauma/special/neverboner/on_lose()
	var/mob/living/carbon/human/affected_human = owner
	REMOVE_TRAIT(affected_human, TRAIT_NEVERBONER, APHRO_TRAIT)

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
