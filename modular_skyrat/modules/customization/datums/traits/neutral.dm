/datum/quirk/hypnotic_stupor
	name = "Hypnotic Stupor"
	desc = "Your prone to episodes of extreme stupor that leaves you extremely suggestible."
	value = 0
	human_only = TRUE
	gain_text = null // Handled by trauma.
	lose_text = null
	medical_record_text = "Patient has an untreatable condition with their brain, wiring them to be extreamly suggestible..."

/datum/quirk/hypnotic_stupor/add()
	var/datum/brain_trauma/severe/hypnotic_stupor/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)
