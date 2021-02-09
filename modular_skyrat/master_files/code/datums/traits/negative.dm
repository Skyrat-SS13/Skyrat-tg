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
