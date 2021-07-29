//SKYRAT NEGATIVE TRAITS

/datum/quirk/alexithymia
	name = "Alexithymia"
	desc = "You cannot accurately assess your feelings."
	value = -4
	mob_trait = TRAIT_MOOD_NOEXAMINE
	medical_record_text = "Patient is incapable of communicating their emotions."

/datum/quirk/sensitivesnout
	name = "Sensitive Snout"
	desc = "Your face has always been sensitive, and it really hurts when someone pokes it!"
	gain_text = "<span class='notice'>Your face is awfully sensitive.</span>"
	lose_text = "<span class='notice'>Your face feels numb.</span>"
	medical_record_text = "Patient's nose seems to have a cluster of nerves in the tip, would advise against direct contact."
	value = -2
	mob_trait = TRAIT_SENSITIVESNOUT

/datum/quirk/monophobia
	name = "Monophobia"
	desc = "You will become increasingly stressed when not in company of others, triggering panic reactions ranging from sickness to heart attacks."
	value = -6
	gain_text = "<span class='danger'>You feel really lonely...</span>"
	lose_text = "<span class='notice'>You feel like you could be safe on your own.</span>"
	medical_record_text = "Patient feels sick and distressed when not around other people, leading to potentially lethal levels of stress."

/datum/quirk/monophobia/post_add()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/monophobia/remove()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H?.cure_trauma_type(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)
