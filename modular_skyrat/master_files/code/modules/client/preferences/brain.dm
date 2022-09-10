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

	var/obj/old_brain = target.getorganslot(ORGAN_SLOT_BRAIN)
	if(!new_brain || new_brain == old_brain.type)
		return

	new_brain = new new_brain()
	new_brain.Insert(target, TRUE, FALSE)
