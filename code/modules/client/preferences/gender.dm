/// Gender preference
/datum/preference/choiced/gender
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "gender"
	priority = PREFERENCE_PRIORITY_GENDER

/datum/preference/choiced/gender/init_possible_values()
	return list(MALE, FEMALE, PLURAL)

/datum/preference/choiced/gender/apply_to_human(mob/living/carbon/human/target, value)
	/* SKYRAT REMOVAL START - Did you just assume my gender???
	if(!target.dna.species.sexes)
		value = PLURAL //disregard gender preferences on this species
	*/ // SKYRAT REMOVAL END
	target.gender = value
