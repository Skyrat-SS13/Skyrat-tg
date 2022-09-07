/datum/preference/choiced/brain_type
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_key = "brain_type"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_NAMES // Apply after species, cause that's super important.

/datum/preference/choiced/brain_type/init_possible_values()
	return list(ORGAN_PREF_POSI_BRAIN, ORGAN_PREF_MMI_BRAIN, ORGAN_PREF_CIRCUIT_BRAIN)

/datum/preference/choiced/brain_type/create_default_value()
	return ORGAN_PREF_POSI_BRAIN

/datum/preference/choiced/brain_type/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!isrobotic(target))
		return

	var/obj/item/organ/internal/brain/new_brain = prefs_get_brain_to_use(value)

	if(!new_brain)
		return

	new_brain = new new_brain()
	new_brain.Insert(target, TRUE, FALSE)

/proc/prefs_get_brain_to_use(value, is_cyborg = FALSE)
	switch(value)
		if(ORGAN_PREF_POSI_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain : null
		if(ORGAN_PREF_MMI_BRAIN)
			return is_cyborg ? null : /obj/item/organ/internal/brain/ipc_positron/mmi
		if(ORGAN_PREF_CIRCUIT_BRAIN)
			return is_cyborg ? /obj/item/mmi/posibrain/circuit : /obj/item/organ/internal/brain/ipc_positron/circuit

/mob/living/silicon/robot/Initialize(mapload)
	. = ..()
	RegisterSignal(src, COMSIG_MOB_MIND_TRANSFERRED_INTO, .proc/update_brain_type)

/mob/living/silicon/robot/proc/update_brain_type()
	var/obj/item/mmi/new_mmi = prefs_get_brain_to_use(client?.prefs?.read_preference(/datum/preference/choiced/brain_type), TRUE)
	if(!new_mmi)
		return
	new_mmi = new new_mmi()

	new_mmi.brain = mmi.brain
	new_mmi.name = "[initial(mmi.name)]: [real_name]"
	new_mmi.set_brainmob(mmi.brainmob)
	new_mmi.update_appearance()

	QDEL_NULL(mmi)

	mmi = new_mmi

