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

/datum/quirk/ashwalkertalons
	name = "Chunky Fingers"
	desc = "Your digits are thick and tough and unable to use modular computers including tablets, certain devices like laser pointers, and non-adapted firearms."
	gain_text = "<span class='notice'>Your fingers feel thicker and slightly less dextrous. You expect you'll have a difficult time using computers, certain small devices and firearms.</span>"
	lose_text = "<span class='notice'>Your digits feel lithe and capable once more.</span>"
	medical_record_text = "Patient's digits are thick and lack the dexterity for operating some small devices, computers and non-adapted firearms."
	value = -8
	mob_trait = TRAIT_CHUNKYFINGERS

/datum/quirk/airhead
	name = "Airhead"
	desc = "You are exceptionally airheaded... but who cares?"
	value = -6
	mob_trait = TRAIT_DUMB
	medical_record_text = "Patient exhibits rather low mental capabilities."

/datum/quirk/disaster_artist
	name = "Clumsy"
	desc = "You always manage to wreak havoc on everything you touch."
	value = -8
	mob_trait = TRAIT_CLUMSY
	medical_record_text = "Patient lacks proper spatial awareness."

/datum/quirk/hemophiliac
	name = "Hemophiliac"
	desc = "Your body is bad at coagulating blood. Bleeding will always be two times worse when compared to the average person."
	value = -5
	mob_trait = TRAIT_HEMOPHILIA
	medical_record_text = "Patient exhibits abnormal blood coagulation behavior."

/datum/quirk/noggie
	name = "Frail Head"
	desc = "Being noogied hurts a lot! Probably because of a sensible head or antenna."
	value = -2
	mob_trait = TRAIT_ANTENNAE
	medical_record_text = "Patient has an frail head."

/datum/quirk/flash
	name = "Flash Sensitive"
	desc = "You can be flashed from any direction."
	value = -3
	mob_trait = TRAIT_FLASH_SENSITIVE
	medical_record_text "Patient is sensitive to flash."
