/datum/borer_focus
	/// Name of the focus
	var/name = ""
	/// Cost of the focus
	var/cost = 5

/// Effects to take when the focus is added
/datum/borer_focus/proc/on_add(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	return

/// Effects to take when the focus is removed
/datum/borer_focus/proc/on_remove(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	return

/datum/borer_focus/head
	name = "head focus"

/datum/borer_focus/head/on_add(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("Your eyes begin to feel strange..."))
	if(!HAS_TRAIT(host, TRAIT_NOFLASH))
		ADD_TRAIT(host, TRAIT_NOFLASH, borer)
	if(!HAS_TRAIT(host, TRAIT_TRUE_NIGHT_VISION))
		ADD_TRAIT(host, TRAIT_TRUE_NIGHT_VISION, borer)
	if(!HAS_TRAIT(host, TRAIT_KNOW_ENGI_WIRES))
		ADD_TRAIT(host, TRAIT_KNOW_ENGI_WIRES, borer)

/datum/borer_focus/head/on_remove(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("Your eyes begin to return to normal..."))
	if(HAS_TRAIT_FROM(host, TRAIT_NOFLASH, borer))
		REMOVE_TRAIT(host, TRAIT_NOFLASH, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_TRUE_NIGHT_VISION, borer))
		REMOVE_TRAIT(host, TRAIT_TRUE_NIGHT_VISION, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_KNOW_ENGI_WIRES, borer))
		REMOVE_TRAIT(host, TRAIT_KNOW_ENGI_WIRES, borer)
	host.update_sight()

/datum/borer_focus/chest
	name = "chest focus"

/datum/borer_focus/chest/on_add(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("Your chest begins to slow down..."))
	if(!HAS_TRAIT(host, TRAIT_NOBREATH))
		ADD_TRAIT(host, TRAIT_NOBREATH, borer)
	if(!HAS_TRAIT(host, TRAIT_NOHUNGER))
		ADD_TRAIT(host, TRAIT_NOHUNGER, borer)
	if(!HAS_TRAIT(host, TRAIT_STABLEHEART))
		ADD_TRAIT(host, TRAIT_STABLEHEART, borer)

/datum/borer_focus/chest/on_remove(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("Your chest begins to heave again..."))
	if(HAS_TRAIT_FROM(host, TRAIT_NOBREATH, borer))
		REMOVE_TRAIT(host, TRAIT_NOBREATH, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_NOHUNGER, borer))
		REMOVE_TRAIT(host, TRAIT_NOHUNGER, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_STABLEHEART, borer))
		REMOVE_TRAIT(host, TRAIT_STABLEHEART, borer)

/datum/borer_focus/arms
	name = "arm focus"

/datum/borer_focus/arms/on_add(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("Your arms start to feel funny..."))
	borer.human_host.add_actionspeed_modifier(/datum/actionspeed_modifier/borer_speed)
	if(!HAS_TRAIT(host, TRAIT_QUICKER_CARRY))
		ADD_TRAIT(host, TRAIT_QUICKER_CARRY, borer)
	if(!HAS_TRAIT(host, TRAIT_QUICK_BUILD))
		ADD_TRAIT(host, TRAIT_QUICK_BUILD, borer)
	if(!HAS_TRAIT(host, TRAIT_SHOCKIMMUNE))
		ADD_TRAIT(host, TRAIT_SHOCKIMMUNE, borer)

/datum/borer_focus/arms/on_remove(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("Your arms start to feel normal again..."))
	borer.human_host.remove_actionspeed_modifier(ACTIONSPEED_ID_BORER)
	if(HAS_TRAIT_FROM(host, TRAIT_QUICK_BUILD, borer))
		REMOVE_TRAIT(host, TRAIT_QUICK_BUILD, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_QUICKER_CARRY, borer))
		REMOVE_TRAIT(host, TRAIT_QUICKER_CARRY, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_SHOCKIMMUNE, borer))
		REMOVE_TRAIT(host, TRAIT_SHOCKIMMUNE, borer)

/datum/borer_focus/legs
	name = "leg focus"

/datum/borer_focus/legs/on_add(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("You feel faster..."))
	host.add_movespeed_modifier(/datum/movespeed_modifier/borer_speed)
	if(!HAS_TRAIT(host, TRAIT_LIGHT_STEP))
		ADD_TRAIT(host, TRAIT_LIGHT_STEP, borer)
	if(!HAS_TRAIT(host, TRAIT_FREERUNNING))
		ADD_TRAIT(host, TRAIT_FREERUNNING, borer)
	if(!HAS_TRAIT(host, TRAIT_SILENT_FOOTSTEPS))
		ADD_TRAIT(host, TRAIT_SILENT_FOOTSTEPS, borer)

/datum/borer_focus/legs/on_remove(mob/living/carbon/human/host, mob/living/simple_animal/cortical_borer/borer)
	to_chat(host, span_notice("You feel slower..."))
	host.remove_movespeed_modifier(/datum/movespeed_modifier/borer_speed)
	if(HAS_TRAIT_FROM(host, TRAIT_LIGHT_STEP, borer))
		REMOVE_TRAIT(host, TRAIT_LIGHT_STEP, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_FREERUNNING, borer))
		REMOVE_TRAIT(host, TRAIT_FREERUNNING, borer)
	if(HAS_TRAIT_FROM(host, TRAIT_SILENT_FOOTSTEPS, borer))
		REMOVE_TRAIT(host, TRAIT_SILENT_FOOTSTEPS, borer)
