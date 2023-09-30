/datum/preference/toggle/expand_death_consequences_options // simple filler option that lets you expand all the below
	savefile_key = "dc_expand_options"

	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

	default_value = FALSE

/datum/preference/toggle/expand_death_consequences_options/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	return DEATH_CONSEQUENCES_QUIRK_NAME in preferences.all_quirks

/datum/preference/toggle/expand_death_consequences_options/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/death_consequences/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/death_consequences
	abstract_type = /datum/preference/numeric/death_consequences
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

	step = 0.01

/datum/preference/numeric/death_consequences/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	if (!(DEATH_CONSEQUENCES_QUIRK_NAME in preferences.all_quirks))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/expand_death_consequences_options)

/datum/preference/numeric/death_consequences/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/death_consequences/starting_degradation
	savefile_key = "dc_starting_degradation"

	minimum = 0
	maximum = DEATH_CONSEQUENCES_MAXIMUM_THEORETICAL_DEGRADATION

/datum/preference/numeric/death_consequences/starting_degradation/create_default_value()
	return minimum

/datum/preference/numeric/death_consequences/max_degradation
	savefile_key = "dc_max_degradation"

	minimum = 0
	maximum = DEATH_CONSEQUENCES_MAXIMUM_THEORETICAL_DEGRADATION

/datum/preference/numeric/death_consequences/max_degradation/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_MAX_DEGRADATION

/datum/preference/numeric/death_consequences/living_degradation_recovery_per_second
	savefile_key = "dc_living_degradation_recovery_per_second"

	minimum = -100 // if you want, you can just die slowly
	maximum = 1000

/datum/preference/numeric/death_consequences/living_degradation_recovery_per_second/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_LIVING_DEGRADATION_RECOVERY

/datum/preference/numeric/death_consequences/dead_degradation_per_second
	savefile_key = "dc_dead_degradation_per_second"

	minimum = 0
	maximum = 1000

/datum/preference/numeric/death_consequences/dead_degradation_per_second/create_default_value()
	return 0

/datum/preference/numeric/death_consequences/degradation_on_death
	savefile_key = "dc_degradation_on_death"

	minimum = 0
	maximum = 1000

/datum/preference/numeric/death_consequences/degradation_on_death/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_DEGRADATION_ON_DEATH

/datum/preference/numeric/death_consequences/formeldahyde_dead_degradation_mult
	savefile_key = "dc_formeldahyde_dead_degradation_mult"

	minimum = 0
	maximum = 1

/datum/preference/numeric/death_consequences/formeldahyde_dead_degradation_mult/create_default_value()
	return 0

/datum/preference/numeric/death_consequences/stasis_dead_degradation_mult
	savefile_key = "dc_stasis_dead_degradation_mult"

	minimum = 0
	maximum = 1

/datum/preference/numeric/death_consequences/stasis_dead_degradation_mult/create_default_value()
	return 0

/datum/preference/numeric/death_consequences/rezadone_living_degradation_reduction
	savefile_key = "dc_rezadone_living_degradation_reduction"

	minimum = 0
	maximum = 500

/datum/preference/numeric/death_consequences/rezadone_living_degradation_reduction/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_REZADONE_DEGRADATION_REDUCTION

/datum/preference/numeric/death_consequences/crit_threshold_reduction_min_percent_of_max
	savefile_key = "dc_crit_threshold_reduction_min_percent_of_max"

	minimum = 0
	maximum = 100

/datum/preference/numeric/death_consequences/crit_threshold_reduction_min_percent_of_max/create_default_value()
	return 0 // percent

/datum/preference/numeric/death_consequences/crit_threshold_reduction_percent_of_max
	savefile_key = "dc_crit_threshold_reduction_percent_of_max"

	minimum = 0
	maximum = 100

/datum/preference/numeric/death_consequences/crit_threshold_reduction_percent_of_max/create_default_value()
	return 100 // percent

/datum/preference/numeric/death_consequences/max_crit_threshold_reduction
	savefile_key = "dc_max_crit_threshold_reduction"

	minimum = 0
	maximum = MAX_LIVING_HEALTH

/datum/preference/numeric/death_consequences/max_crit_threshold_reduction/create_default_value()
	return 30

/datum/preference/numeric/death_consequences/stamina_damage_percent_of_max
	savefile_key = "dc_stamina_damage_percent_of_max"

	minimum = 0
	maximum = 100

/datum/preference/numeric/death_consequences/stamina_damage_percent_of_max/create_default_value()
	return 100 // percent

/datum/preference/numeric/death_consequences/stamina_damage_min_percent_of_max
	savefile_key = "dc_stamina_damage_min_percent_of_max"

	minimum = 0
	maximum = 100

/datum/preference/numeric/death_consequences/stamina_damage_min_percent_of_max/create_default_value()
	return 20 // percent

/datum/preference/numeric/death_consequences/max_stamina_damage
	savefile_key = "dc_max_stamina_damage"

	minimum = 0
	maximum = 150

/datum/preference/numeric/death_consequences/max_stamina_damage/create_default_value()
	return 80

// BOOLEANS

/datum/preference/toggle/death_consequences
	abstract_type = /datum/preference/toggle/death_consequences
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

/datum/preference/toggle/death_consequences/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	if (!(DEATH_CONSEQUENCES_QUIRK_NAME in preferences.all_quirks))
		return FALSE

	return preferences.read_preference(/datum/preference/toggle/expand_death_consequences_options)

/datum/preference/toggle/death_consequences/permakill_at_max
	savefile_key = "dc_permakill_at_max"

	default_value = FALSE // lets not be too cruel here

/datum/preference/toggle/death_consequences/force_death_if_permakilled
	savefile_key = "dc_force_death_if_permakilled"

	default_value = FALSE

/datum/preference/toggle/death_consequences/force_death_if_permakilled/is_accessible(datum/preferences/preferences)
	. = ..()
	if (!.)
		return FALSE

	var/can_be_permakilled = preferences.read_preference(/datum/preference/toggle/death_consequences/permakill_at_max)
	return can_be_permakilled
