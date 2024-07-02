/datum/preference/toggle/naga_soles
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_key = "naga_sole"
	savefile_identifier = PREFERENCE_CHARACTER
	priority = PREFERENCE_PRIORITY_BODYPARTS + 0.1
	default_value = FALSE

/datum/preference/toggle/naga_soles/is_accessible(datum/preferences/preferences)
	if (!..())
		return FALSE

	var/datum/sprite_accessory/taur_mode = SSaccessories.sprite_accessories["taur"][preferences.read_preference(/datum/preference/choiced/mutant_choice/taur)]
	return (istype(taur_mode, /datum/sprite_accessory/taur/naga) || istype(taur_mode, /datum/sprite_accessory/taur/synthliz/synthnaga))

/datum/preference/toggle/naga_soles/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if (value)
		return
	var/obj/item/organ/external/taur_body/serpentine/snake_body = target.get_organ_slot(ORGAN_SLOT_EXTERNAL_TAUR)
	if (istype(snake_body))
		snake_body.add_hardened_soles(target)
