/datum/quirk/death_consequences
	name = DEATH_CONSEQUENCES_QUIRK_NAME
	desc = "Every time you die, your body suffers long-term damage that can't easily be repaired."
	medical_record_text = DEATH_CONSEQUENCES_QUIRK_DESC
	icon = FA_ICON_DNA
	value = 0 // due to its high customization, you can make it really inconsequential

/datum/quirk_constant_data/death_consequences
	associated_typepath = /datum/quirk/death_consequences

/datum/quirk_constant_data/death_consequences/New()
	customization_options = (subtypesof(/datum/preference/numeric/death_consequences) + subtypesof(/datum/preference/toggle/death_consequences))

	return ..()

/datum/quirk/death_consequences/add(client/client_source)
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.gain_trauma(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)
	var/datum/brain_trauma/severe/death_consequences/added_trauma = human_holder.get_death_consequences_trauma()
	if (!isnull(added_trauma))
		added_trauma.update_variables(client_source)

	to_chat(human_holder, span_danger("You suffer from [src]. By default, you will \
		degrade every time you die, and recover very slowly while alive. This may be expedited by resting, sleeping, being buckled \
		to something cozy, or using rezadone.\n\
		As your degradation rises, so too will negative effects, such as stamina damage or a worsened crit threshold.\n\
		You can alter your degradation on the fly via the Adjust death degradation verb, and change your settings via the Refresh death consequence variables verb."))

/datum/quirk/death_consequences/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	human_holder.cure_trauma_type(/datum/brain_trauma/severe/death_consequences, TRAUMA_RESILIENCE_ABSOLUTE)

/// Adjusts the mob's linked death consequences trauma (see get_death_consequences_trauma())'s degradation by increment.
/mob/verb/adjust_degradation(increment as num)
	set name = "Adjust death degradation"
	set category = "IC"
	set instant = TRUE

	if (isnull(mind))
		to_chat(usr, span_warning("You have no mind!"))
		return

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("You don't have a body with death consequences!"))
		return

	if (!isnum(increment))
		to_chat(usr, span_warning("You can artificially change the current level of your death degradation with this verb. \
		You can use this to cause degradation in ways the customization cannot. <b>You need to enter a number to use this verb.</b>"))
		return

	if (linked_trauma.permakill_if_at_max_degradation && ((linked_trauma.current_degradation + increment) >= linked_trauma.max_degradation))
		if (tgui_alert(usr, "This will put you over/at your maximum degradation threshold and PERMANENTLY KILL YOU!!! Are you SURE you want to do this?", "WARNING", list("Yes", "No"), timeout = 7 SECONDS) != "Yes")
			return

	linked_trauma.adjust_degradation(increment)
	to_chat(usr, span_notice("Degradation successfully adjusted!"))

/// Calls update_variables() on this mob's linked death consequences trauma. See that proc for further info.
/mob/verb/refresh_death_consequences()
	set name = "Refresh death consequence variables"
	set category = "IC"
	set instant = TRUE

	if (isnull(mind))
		to_chat(usr, span_warning("You have no mind!"))
		return

	var/datum/brain_trauma/severe/death_consequences/linked_trauma = get_death_consequences_trauma()
	var/mob/living/carbon/trauma_holder = linked_trauma?.owner
	if (isnull(linked_trauma) || isnull(trauma_holder) || trauma_holder != mind.current) // sanity
		to_chat(usr, span_warning("You don't have a body with death consequences!"))
		return

	linked_trauma.update_variables(client)
	to_chat(usr, span_notice("Variables successfully updated!"))

/// Searches mind.current for a death_consequences trauma. Allows this proc to be used on both ghosts and living beings to find their linked trauma.
/mob/proc/get_death_consequences_trauma()
	RETURN_TYPE(/datum/brain_trauma/severe/death_consequences)

	if (isnull(mind))
		return

	if (iscarbon(mind.current))
		var/mob/living/carbon/carbon_body = mind.current
		for (var/datum/brain_trauma/trauma as anything in carbon_body.get_traumas())
			if (istype(trauma, /datum/brain_trauma/severe/death_consequences))
				return trauma
	// else, return null
