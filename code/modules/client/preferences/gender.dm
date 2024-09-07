/// Gender preference
/datum/preference/choiced/gender
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "gender"
	priority = PREFERENCE_PRIORITY_GENDER

/datum/preference/choiced/gender/init_possible_values()
	return list(MALE, FEMALE, PLURAL, NEUTER)

/datum/preference/choiced/gender/apply_to_human(mob/living/carbon/human/target, value)
<<<<<<< HEAD
	/* SKYRAT EDIT REMOVAL START - Did you just assume my gender???
	if(!target.dna.species.sexes)
		value = PLURAL //disregard gender preferences on this species
	*/ // SKYRAT EDIT REMOVAL END
=======
	if(!target.dna.species.sexes)
		value = PLURAL //disregard gender preferences on this species
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
	target.gender = value

/datum/preference/choiced/gender/create_informed_default_value(datum/preferences/preferences)
	// The only reason I'm limiting this to male or female
	// is that hairstyle randomization handles enbies poorly
	return pick(MALE, FEMALE)
