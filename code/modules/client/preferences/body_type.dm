<<<<<<< HEAD
/* SKYRAT EDIT REMOVAL
=======
#define USE_GENDER "Use gender"

>>>>>>> 0ab5f14870b (Allows any character to use the body type setting regardless of gender (#62733))
/datum/preference/choiced/body_type
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	priority = PREFERENCE_PRIORITY_BODY_TYPE
	savefile_key = "body_type"
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/choiced/body_type/init_possible_values()
	return list(USE_GENDER, MALE, FEMALE)

/datum/preference/choiced/body_type/create_default_value()
	return USE_GENDER

/datum/preference/choiced/body_type/apply_to_human(mob/living/carbon/human/target, value)
	if (value == USE_GENDER)
		target.body_type = target.gender
	else
		target.body_type = value

/datum/preference/choiced/body_type/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

<<<<<<< HEAD
	var/gender = preferences.read_preference(/datum/preference/choiced/gender)
	return gender != MALE && gender != FEMALE
*/
=======
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	return initial(species.sexes)

#undef USE_GENDER
>>>>>>> 0ab5f14870b (Allows any character to use the body type setting regardless of gender (#62733))
