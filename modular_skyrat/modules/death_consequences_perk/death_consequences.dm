/datum/quirk/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = "Every time you die, your body suffers long-term damage that can't easily be repaired."
	medical_record_text = DEATH_CONSEQUENCES_QUIRK_DESC
	icon = FA_ICON_BRAIN
	value = 0 // due to its high customization, you can make it realllly good or reallllly bad

/datum/quirk/death_consequences/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.gain_trauma(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)

	add_verb(human_holder, TYPE_VERB_REF(/mob, adjust_degradation))
	add_verb(human_holder, TYPE_VERB_REF(/mob, refresh_death_consequences))

/datum/quirk/death_consequences/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)

	remove_verb(human_holder, TYPE_VERB_REF(/mob, adjust_degradation))
	remove_verb(human_holder, TYPE_VERB_REF(/mob, refresh_death_consequences))

/mob/verb/adjust_degradation(increment as num)
	set name = "Adjust resonance degradation"
	set category = "IC"
	set instant = TRUE

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("You don't have a body with death consequences!"))
		return

	if (!isnum(increment))
		to_chat(usr, span_warning("You can artificially change the degradation of your resonance degradation with this verb. \
		You can use this to cause degradation in ways the customization cannot. <b>You need to enter a number to use this verb.</b>"))
		return

	/*if (increment <= 0)
		to_chat(usr, span_warning("You can only increase the severity of your degradation with this verb!"))
		return*/

	linked_trauma.adjust_degradation(increment)
	to_chat(usr, span_notice("Degradation successfully adjusted!"))

/mob/verb/refresh_death_consequences()
	set name = "Refresh death consequence variables"
	set category = "IC"
	set instant = TRUE

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("You don't have a body with death consequences!"))
		return

	linked_trauma.update_variables()
	to_chat(usr, span_notice("Variables successfully updated!"))

/mob/proc/get_death_consequences_trauma()
	RETURN_TYPE(/datum/brain_trauma/severe/death_consequences)
	if (iscarbon(mind.current))
		var/mob/living/carbon/carbon_body = mind.current
		for (var/datum/brain_trauma/trauma as anything in carbon_body.get_traumas())
			if (istype(trauma, /datum/brain_trauma/severe/death_consequences))
				return trauma
	// else, return null
