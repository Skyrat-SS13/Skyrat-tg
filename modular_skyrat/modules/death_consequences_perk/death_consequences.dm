/datum/quirk/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = "Every time you die, your body suffers long-term damage that can't easily be repaired."
	medical_record_text = DEATH_CONSEQUENCES_QUIRK_DESC
	icon = FA_ICON_BRAIN


/datum/quirk/death_consequences/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.gain_trauma(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/death_consequences/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)
