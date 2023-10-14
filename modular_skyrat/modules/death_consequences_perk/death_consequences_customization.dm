/// List of all death consequence preference typepaths.
GLOBAL_LIST_INIT_TYPED(death_consequences_prefs, /datum/preference, generate_death_consequences_prefs_list())

/proc/generate_death_consequences_prefs_list()
	RETURN_TYPE(/list/datum/preference)

	var/list/datum/preference/pref_list = list()

	for (var/datum/preference/possible_dc_pref_type as anything in (subtypesof(/datum/preference/numeric/death_consequences) + subtypesof(/datum/preference/toggle/death_consequences)))
		if (initial(possible_dc_pref_type.abstract_type) == possible_dc_pref_type)
			continue
		pref_list += possible_dc_pref_type

	return pref_list

/// Dummy preference that allows our config link to appear in char creation FUCKING SHIT I HATE THIS
/datum/preference/dc_dummy_pref
	savefile_key = "dc_config"
	savefile_identifier = PREFERENCE_CHARACTER

	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	can_randomize = FALSE

/datum/preference/dc_dummy_pref/is_accessible(datum/preferences/preferences)
	. = ..()

	if (!.)
		return FALSE

	return (DEATH_CONSEQUENCES_QUIRK_NAME in preferences.all_quirks)

/datum/preference/dc_dummy_pref/apply_to_human(mob/living/carbon/human/target, value)
	return

/datum/preference/dc_dummy_pref/serialize(input, datum/preferences/preferences)
	return

/datum/preference/dc_dummy_pref/deserialize(input, datum/preferences/preferences)
	return

/datum/preference/dc_dummy_pref/create_default_value(datum/preferences/preferences)
	return null

/datum/preference/dc_dummy_pref/is_valid(value)
	return TRUE

// god i fucking hate this but the only other option is making a ton of TSX types, a global list, or typechecking constantly and slapping var/name on EVERY DC pref
/datum/preference
	/// The name to be displayed in config windows. ONLY USED IN DEATH CONSEQUENCES RIGHT NOW
	var/config_name
	/// The description to be displayed in config windows. ONLY USED IN DEATH CONSEQUENCES RIGHT NOW
	var/config_desc

/datum/preference/numeric/death_consequences
	abstract_type = /datum/preference/numeric/death_consequences
	category = PREFERENCE_CATEGORY_NON_CONTEXTUAL
	savefile_identifier = PREFERENCE_CHARACTER

	step = 0.01

/datum/preference/numeric/death_consequences/should_show_on_page(preferences_page)
	return FALSE

/datum/preference/numeric/death_consequences/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/numeric/death_consequences/starting_degradation
	savefile_key = "dc_starting_degradation"

	minimum = 0
	maximum = DEATH_CONSEQUENCES_MAXIMUM_THEORETICAL_DEGRADATION

	config_name = "Starting degradation"
	config_desc = "The degradation you will start with when you spawn in."

/datum/preference/numeric/death_consequences/starting_degradation/create_default_value()
	return minimum

/datum/preference/numeric/death_consequences/max_degradation
	savefile_key = "dc_max_degradation"

	minimum = 0
	maximum = DEATH_CONSEQUENCES_MAXIMUM_THEORETICAL_DEGRADATION

	config_name = "Max degradation"
	config_desc = "The absolute maximum degradation you can sustain."

/datum/preference/numeric/death_consequences/max_degradation/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_MAX_DEGRADATION

/datum/preference/numeric/death_consequences/living_degradation_recovery_per_second
	savefile_key = "dc_living_degradation_recovery_per_second"

	minimum = -100 // if you want, you can just die slowly
	maximum = 1000

	config_name = "Degradation recovery per second while alive"
	config_desc = "While alive, your degradation will be reduced by this much per second. If negative, this will cause you to slowly die."

/datum/preference/numeric/death_consequences/living_degradation_recovery_per_second/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_LIVING_DEGRADATION_RECOVERY

/datum/preference/numeric/death_consequences/dead_degradation_per_second
	savefile_key = "dc_dead_degradation_per_second"

	minimum = 0
	maximum = 1000

	config_name = "Degradation increase per second while dead"
	config_desc = "While dead, your degradation will increase by this much per second."

/datum/preference/numeric/death_consequences/dead_degradation_per_second/create_default_value()
	return 0

/datum/preference/numeric/death_consequences/degradation_on_death
	savefile_key = "dc_degradation_on_death"

	minimum = 0
	maximum = 1000

	config_name = "Immediate degradation on death"
	config_desc = "When you die, your degradation will immediately increase by this amount."

/datum/preference/numeric/death_consequences/degradation_on_death/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_DEGRADATION_ON_DEATH

/datum/preference/numeric/death_consequences/formeldahyde_dead_degradation_mult
	savefile_key = "dc_formeldahyde_dead_degradation_mult"

	minimum = 0
	maximum = 1

	config_name = "Formeldahyde death degradation mult"
	config_desc = "If you are organic and have formeldahyde in your system, any passive degradation caused by being dead will be multiplied against this."

/datum/preference/numeric/death_consequences/formeldahyde_dead_degradation_mult/create_default_value()
	return 0

/datum/preference/numeric/death_consequences/stasis_dead_degradation_mult
	savefile_key = "dc_stasis_dead_degradation_mult"

	minimum = 0
	maximum = 1

	config_name = "On stasis degradation mult"
	config_desc = "If you are on stasis, any form of passive degradation (ex. being dead) will be multiplied against this."

/datum/preference/numeric/death_consequences/stasis_dead_degradation_mult/create_default_value()
	return 0

/datum/preference/numeric/death_consequences/rezadone_living_degradation_reduction
	savefile_key = "dc_rezadone_living_degradation_reduction"

	minimum = 0
	maximum = 500

	config_name = "Pure rezadone degradation reduction"
	config_desc = "If you are organic, alive, and metabolizing rezadone at 100% purity, you will passively recover from degradation at this rate per second."

/datum/preference/numeric/death_consequences/rezadone_living_degradation_reduction/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_REZADONE_DEGRADATION_REDUCTION

/datum/preference/numeric/death_consequences/strange_reagent_degradation_reduction
	savefile_key = "dc_strange_reagent_degradation_reduction"

	minimum = 0
	maximum = 500

	config_name = "Strange reagent degradation reduction"
	config_desc = "If you are organic, alive, and metabolizing strange reagent, you will passively recover from degradation at this rate per second."

/datum/preference/numeric/death_consequences/strange_reagent_degradation_reduction/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_STRANGE_REAGENT_DEGRADATION_REDUCTION

/datum/preference/numeric/death_consequences/sansufentanyl_living_degradation_reduction
	savefile_key = "dc_sansufentanyl_living_degradation_reduction"

	minimum = 0
	maximum = 500

	config_name = "Sansufentanyl degradation reduction"
	config_desc = "If you are organic, alive, and metabolizing sansufentanyl, you will passively recover from degradation at this rate per second."

/datum/preference/numeric/death_consequences/sansufentanyl_living_degradation_reduction/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_SANSUFENTANYL_DEGRADATION_REDUCTION

/datum/preference/numeric/death_consequences/eigenstasium_degradation_reduction
	savefile_key = "dc_eigenstasium_degradation_reduction"

	minimum = 0
	maximum = 5000

	config_name = "Eigenstasium degradation reduction"
	config_desc = "If you have eigenstasium in your system, you will passively recover from degradation at this rate per second. This works for synths, and while dead."

/datum/preference/numeric/death_consequences/eigenstasium_degradation_reduction/create_default_value()
	return DEATH_CONSEQUENCES_DEFAULT_EIGENSTASIUM_DEGRADATION_REDUCTION

/datum/preference/numeric/death_consequences/crit_threshold_reduction_min_percent_of_max
	savefile_key = "dc_crit_threshold_reduction_min_percent_of_max"

	minimum = 0
	maximum = 100

	config_name = "Crit threshold reduction: Beginning degradation percent"
	config_desc = "Crit threshold will begin decreasing when degradation is this percent to its maximum possible value."

/datum/preference/numeric/death_consequences/crit_threshold_reduction_min_percent_of_max/create_default_value()
	return 0 // percent

/datum/preference/numeric/death_consequences/crit_threshold_reduction_percent_of_max
	savefile_key = "dc_crit_threshold_reduction_percent_of_max"

	minimum = 0
	maximum = 100

	config_name = "Crit threshold reduction: Ending degradation percent"
	config_desc = "Crit threshold will stop decreasing and reach its maximum reduction when degradation is at this percent."

/datum/preference/numeric/death_consequences/crit_threshold_reduction_percent_of_max/create_default_value()
	return 100 // percent

/datum/preference/numeric/death_consequences/max_crit_threshold_reduction
	savefile_key = "dc_max_crit_threshold_reduction"

	minimum = 0
	maximum = MAX_LIVING_HEALTH

	config_name = "Crit threshold reduction: Maximum reduction"
	config_desc = "When at the ending degradation percent, crit threshold will be reduced by this, \
	with lower percentages causing equally displaced reducions, such as having 50% degradation causing 50% of this to be applied."

/datum/preference/numeric/death_consequences/max_crit_threshold_reduction/create_default_value()
	return 30

/datum/preference/numeric/death_consequences/stamina_damage_percent_of_max/create_default_value()
	return 100 // percent

/datum/preference/numeric/death_consequences/stamina_damage_min_percent_of_max
	savefile_key = "dc_stamina_damage_min_percent_of_max"

	minimum = 0
	maximum = 100

	config_name = "Stamina damage: Beginning degradation percent"
	config_desc = "Minimum stamina damage will begin increasing when degradation is at this percent."

/datum/preference/numeric/death_consequences/stamina_damage_percent_of_max
	savefile_key = "dc_stamina_damage_percent_of_max"

	minimum = 0
	maximum = 100

	config_name = "Stamina damage: Ending degradation percent"
	config_desc = "Minimum stamina damage will stop increasing when degradation is at this percent, and will reach its maximum value."

/datum/preference/numeric/death_consequences/stamina_damage_min_percent_of_max/create_default_value()
	return 20 // percent

/datum/preference/numeric/death_consequences/max_stamina_damage
	savefile_key = "dc_max_stamina_damage"

	minimum = 0
	maximum = 150

	config_name = "Crit threshold reduction: Maximum reduction"
	config_desc = "When at the ending degradation percent, crit threshold will be reduced by this, \
	with lower percentages causing equally displaced reducions, such as having 50% degradation causing 50% of this to be applied."

/datum/preference/numeric/death_consequences/max_stamina_damage/create_default_value()
	return 80

// BOOLEANS

/datum/preference/toggle/death_consequences
	abstract_type = /datum/preference/toggle/death_consequences
	category = "Test"
	savefile_identifier = PREFERENCE_CHARACTER

	/// The name to be shown in the config window.
	var/name
	/// The description to be shown in the config window.
	var/desc

/datum/preference/toggle/death_consequences/should_show_on_page(preferences_page)
	return FALSE

/datum/preference/toggle/death_consequences/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return FALSE

/datum/preference/toggle/death_consequences/permakill_at_max
	savefile_key = "dc_permakill_at_max"

	default_value = FALSE // lets not be too cruel here

	config_name = "Permakill at maximum degradation"
	config_desc = "If true, you will be permanently ghosted if your degradation reaches its maximum possible value."

/datum/preference/toggle/death_consequences/force_death_if_permakilled
	savefile_key = "dc_force_death_if_permakilled"

	default_value = FALSE

	config_name = "Force death if permakilled"
	config_desc = "If true, you will be permanently killed on permaghost as well."
