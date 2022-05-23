// SKYRAT NEGATIVE TRAITS

/datum/quirk/alexithymia
	name = "Alexithymia"
	desc = "You cannot accurately assess your feelings."
	value = -4
	mob_trait = TRAIT_MOOD_NOEXAMINE
	medical_record_text = "Patient is incapable of communicating their emotions."
	icon = "question-circle"

/datum/quirk/fragile
	name = "Fragility"
	desc = "You feel incredibly fragile. Burns and bruises hurt you more than the average person!"
	value = -6
	medical_record_text = "Patient's body has adapted to low gravity. Sadly low-gravity environments are not conducive to strong bone development."
	icon = "tired"

/datum/quirk/fragile/post_add()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user.physiology.brute_mod *= 1.25
	user.physiology.burn_mod *= 1.2

/datum/quirk/fragile/remove()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user.physiology.brute_mod /= 1.25
	user.physiology.burn_mod /= 1.2

/datum/quirk/sensitivesnout
	name = "Sensitive Snout"
	desc = "Your face has always been sensitive, and it really hurts when someone pokes it!"
	gain_text = span_notice("Your face is awfully sensitive.")
	lose_text = span_notice("Your face feels numb.")
	medical_record_text = "Patient's nose seems to have a cluster of nerves in the tip, would advise against direct contact."
	value = -2
	mob_trait = TRAIT_SENSITIVESNOUT
	icon = "fingerprint"

/datum/quirk/monophobia
	name = "Monophobia"
	desc = "You will become increasingly stressed when not in company of others, triggering panic reactions ranging from sickness to heart attacks."
	value = -6
	gain_text = span_danger("You feel really lonely...")
	lose_text = span_notice("You feel like you could be safe on your own.")
	medical_record_text = "Patient feels sick and distressed when not around other people, leading to potentially lethal levels of stress."
	icon = "people-arrows"

/datum/quirk/monophobia/post_add()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user.gain_trauma(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/monophobia/remove()
	. = ..()
	var/mob/living/carbon/human/user = quirk_holder
	user?.cure_trauma_type(/datum/brain_trauma/severe/monophobia, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/ashwalkertalons
	name = "Chunky Fingers"
	desc = "Your digits are thick and tough and unable to use modular computers including tablets, certain devices like laser pointers, and non-adapted firearms."
	gain_text = span_notice("Your fingers feel thicker and slightly less dextrous. You expect you'll have a difficult time using computers, certain small devices and firearms.")
	lose_text = span_notice("Your digits feel lithe and capable once more.")
	medical_record_text = "Patient's digits are thick and lack the dexterity for operating some small devices, computers and non-adapted firearms."
	value = -8
	mob_trait = TRAIT_CHUNKYFINGERS
	icon = "hand-middle-finger"

/datum/quirk/no_guns
	name = "No Guns"
	desc = "For whatever reason, you are unable to use guns. The reasoning may vary, but is up to you to decide."
	gain_text = span_notice("You feel like you won't be able to use guns anymore...")
	lose_text = span_notice("You suddenly feel like you can use guns again!")
	medical_record_text = "Patient is unable to use firearms. Reasoning unknown."
	value = -4
	mob_trait = TRAIT_NOGUNS
	icon = "none"

/datum/quirk/mute
	name = "Mute"
	desc = "Due to some accident, medical condition, or simply by choice, you are completely unable to speak."
	value = -2 // HALP MAINTS
	gain_text = span_danger("You find yourself unable to speak!")
	lose_text = span_notice("You feel a growing strength in your vocal chords.")
	medical_record_text = "Functionally mute, patient is unable to use their voice in any capacity."

/datum/quirk/mute/add()
	var/mob/living/carbon/human/user = quirk_holder
	user.gain_trauma(new /datum/brain_trauma/severe/mute, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/mute/remove()
	var/mob/living/carbon/human/user = quirk_holder
	user?.cure_trauma_type(/datum/brain_trauma/severe/mute, TRAUMA_RESILIENCE_ABSOLUTE)
