/* SKYRAT EDIT REMOVAL START
/datum/preference/choiced/monkey_tail
	savefile_key = "feature_monkey_tail"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_external_organ = /obj/item/organ/external/tail/monkey
	can_randomize = FALSE

/datum/preference/choiced/monkey_tail/init_possible_values()
	return assoc_to_keys_features(SSaccessories.tails_list_monkey)

/datum/preference/choiced/monkey_tail/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["tail_monkey"] = value

/datum/preference/choiced/monkey_tail/create_default_value()
<<<<<<< HEAD
	var/datum/sprite_accessory/tails/monkey/default/tail = /datum/sprite_accessory/tails/monkey/default
	return initial(tail.name)
*/ // SKYRAT EDIT REMOVAL END
=======
	return /datum/sprite_accessory/tails/monkey/default::name
>>>>>>> 5b3c32e5cf1f (Adds informed default values for a bunch of preferences (to produce less outlandish random characters) (#84726))
