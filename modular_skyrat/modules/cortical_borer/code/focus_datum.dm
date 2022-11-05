/datum/borer_focus
	/// Name of the focus
	var/name = ""
	/// Cost of the focus
	var/cost = 5
	/// Traits to add/remove
	var/list/traits = list()

/// Effects to take when the focus is added
/datum/borer_focus/proc/on_add(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	SHOULD_CALL_PARENT(TRUE)
	for(var/trait in traits)
		if(HAS_TRAIT(host, trait))
			continue
		ADD_TRAIT(host, trait, borer)

/// Effects to take when the focus is removed
/datum/borer_focus/proc/on_remove(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	SHOULD_CALL_PARENT(TRUE)
	for(var/trait in traits)
		if(!HAS_TRAIT_FROM(host, trait, borer))
			continue
		REMOVE_TRAIT(host, trait, borer)

/datum/borer_focus/head
	name = "head focus"
	traits = list(TRAIT_NOFLASH, TRAIT_TRUE_NIGHT_VISION, TRAIT_KNOW_ENGI_WIRES)

/datum/borer_focus/head/on_add(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("Your eyes begin to feel strange..."))
	return ..()

/datum/borer_focus/head/on_remove(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("Your eyes begin to return to normal..."))
	host.update_sight()
	return ..()

/datum/borer_focus/chest
	name = "chest focus"
	traits = list(TRAIT_NOBREATH, TRAIT_NOHUNGER, TRAIT_STABLEHEART)

/datum/borer_focus/chest/on_add(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("Your chest begins to slow down..."))
	host.nutrition = NUTRITION_LEVEL_WELL_FED
	return ..()

/datum/borer_focus/chest/on_remove(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("Your chest begins to heave again..."))
	return ..()

/datum/borer_focus/arms
	name = "arm focus"
	traits = list(TRAIT_QUICKER_CARRY, TRAIT_QUICK_BUILD, TRAIT_SHOCKIMMUNE)

/datum/borer_focus/arms/on_add(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("Your arms start to feel funny..."))
	borer.human_host.add_actionspeed_modifier(/datum/actionspeed_modifier/focus_speed)
	return ..()

/datum/borer_focus/arms/on_remove(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("Your arms start to feel normal again..."))
	borer.human_host.remove_actionspeed_modifier(ACTIONSPEED_ID_BORER)
	return ..()

/datum/borer_focus/legs
	name = "leg focus"
	traits = list(TRAIT_LIGHT_STEP, TRAIT_FREERUNNING, TRAIT_SILENT_FOOTSTEPS)

/datum/borer_focus/legs/on_add(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("You feel faster..."))
	host.add_movespeed_modifier(/datum/movespeed_modifier/focus_speed)
	return ..()

/datum/borer_focus/legs/on_remove(mob/living/carbon/human/host, mob/living/basic/cortical_borer/borer)
	to_chat(host, span_notice("You feel slower..."))
	host.remove_movespeed_modifier(/datum/movespeed_modifier/focus_speed)
	return ..()
