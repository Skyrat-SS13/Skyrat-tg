// Poorly balanced relative to stormtrooper aim.

/datum/quirk/no_guns
	name = "No Guns"
	desc = "For whatever reason, you are unable to use guns. The reasoning may vary, but is up to you to decide."
	gain_text = span_notice("You feel like you won't be able to use guns anymore...")
	lose_text = span_notice("You suddenly feel like you can use guns again!")
	medical_record_text = "Patient is unable to use firearms. Reasoning unknown."
	value = -4
	mob_trait = TRAIT_NOGUNS
	icon = "none"
