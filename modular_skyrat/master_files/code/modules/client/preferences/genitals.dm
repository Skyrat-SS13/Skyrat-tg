// 200 dollars is 200 dollars :(

// ABSTRACT TYPES

/datum/preference/toggle/allow_genitals
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "allow_genitals_toggle"
	default_value = TRUE

/datum/preference/toggle/allow_genitals/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE // we dont actually want this to do anything

/datum/preference/toggle/allow_genitals/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	return erp_allowed && passed_initial_check

/datum/preference/choiced/genital
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	abstract_type = /datum/preference/choiced/genital

	/// Path to the default sprite accessory
	var/datum/sprite_accessory/default_accessory_type

/datum/preference/choiced/genital/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences || !is_visible(target, preferences))
		value = create_default_value()
		. = FALSE

	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = value, MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
		return TRUE

	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value
	return TRUE

/datum/preference/choiced/genital/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	return erp_allowed && (passed_initial_check || allowed)

/**
 * Actually rendered. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns if feature is visible.
 *
 * Arguments:
 * * The character this is being applied to.
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/genital/proc/is_visible(mob/living/carbon/human/target, datum/preferences/preferences)
	if(!preferences.read_preference(/datum/preference/toggle/master_erp_preferences) || !preferences.read_preference(/datum/preference/toggle/allow_genitals))
		return FALSE

	if(preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts))
		return TRUE

	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	species = new species

	return (savefile_key in species.get_features())

/datum/preference/choiced/genital/create_default_value()
	return initial(default_accessory_type.name)

/datum/preference/choiced/genital/init_possible_values()
	return assoc_to_keys_features(SSaccessories.sprite_accessories[relevant_mutant_bodypart])

/datum/preference/toggle/genital_skin_tone
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE
	abstract_type = /datum/preference/toggle/genital_skin_tone
	var/genital_pref_type

/datum/preference/toggle/genital_skin_tone/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/part_name = preferences.read_preference(genital_pref_type)
	var/datum/sprite_accessory/genital/accessory = SSaccessories.sprite_accessories[relevant_mutant_bodypart]?[part_name]
	if(!accessory?.factual || !accessory.has_skintone_shading)
		return FALSE
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	return erp_allowed && (passed_initial_check || allowed)

/datum/preference/toggle/genital_skin_color
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE
	abstract_type = /datum/preference/toggle/genital_skin_color
	var/genital_pref_type

/datum/preference/toggle/genital_skin_color/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/datum/species/species = preferences.read_preference(/datum/preference/choiced/species)
	species = new species
	if(!(TRAIT_USES_SKINTONES in species.inherent_traits))
		return FALSE

	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(genital_pref_type))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/toggle/genital_skin_color/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	// If they're not using skintones, let's not apply this yeah?
	var/datum/species/species = preferences?.read_preference(/datum/preference/choiced/species)
	if(!species)
		return FALSE

	species = new species
	if(!(TRAIT_USES_SKINTONES in species.inherent_traits))
		return FALSE

	return TRUE


/datum/preference/tri_color/genital
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	check_mode = TRICOLOR_CHECK_ACCESSORY
	abstract_type = /datum/preference/tri_color/genital
	var/skin_color_type

/datum/preference/tri_color/genital/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/can_color = TRUE
	/// Checks that the use skin color pref is both enabled and actually accessible. If so, then this is useless.
	if(preferences.read_preference(skin_color_type))
		var/datum/preference/toggle/genital_skin_color/skincolor = GLOB.preference_entries[skin_color_type]
		if(skincolor.is_accessible(preferences))
			can_color = FALSE
	return erp_allowed && can_color && passed_initial_check

/datum/preference/tri_bool/genital
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	check_mode = TRICOLOR_CHECK_ACCESSORY
	abstract_type = /datum/preference/tri_bool/genital
	var/skin_color_type

/datum/preference/tri_bool/genital/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/can_color = TRUE
	/// Checks that the use skin color pref is both enabled and actually accessible. If so, then this is useless.
	if(preferences.read_preference(skin_color_type))
		var/datum/preference/toggle/genital_skin_color/skincolor = GLOB.preference_entries[skin_color_type]
		if(skincolor.is_accessible(preferences))
			can_color = FALSE
	return erp_allowed && can_color && passed_initial_check

// PENIS

/datum/preference/choiced/genital/penis
	savefile_key = "feature_penis"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	default_accessory_type = /datum/sprite_accessory/genital/penis/none

/datum/preference/toggle/genital_skin_tone/penis
	savefile_key = "penis_skin_tone"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	genital_pref_type = /datum/preference/choiced/genital/penis

/datum/preference/toggle/genital_skin_tone/penis/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["penis_uses_skintones"] = value

/datum/preference/toggle/genital_skin_color/penis
	savefile_key = "penis_skin_color"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	genital_pref_type = /datum/preference/choiced/genital/penis

/datum/preference/toggle/genital_skin_color/penis/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!..()) // Don't apply it if it failed the check in the parent.
		value = FALSE

	target.dna.features["penis_uses_skincolor"] = value

/datum/preference/numeric/penis_length
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "penis_length"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	minimum = PENIS_MIN_LENGTH
	maximum = PENIS_MAX_LENGTH

/datum/preference/numeric/penis_length/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/penis))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/numeric/penis_length/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["penis_size"] = value

/datum/preference/numeric/penis_length/create_default_value() // if you change from this to PENIS_MAX_LENGTH the game should laugh at you
	return round(max(PENIS_MIN_LENGTH, PENIS_DEFAULT_LENGTH))

/datum/preference/numeric/penis_girth
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "penis_girth"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	minimum = PENIS_MIN_GIRTH
	maximum = PENIS_MAX_GIRTH

/datum/preference/numeric/penis_girth/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/penis))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/numeric/penis_girth/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["penis_girth"] = value

/datum/preference/numeric/penis_girth/create_default_value()
	return round(max(PENIS_MIN_GIRTH, PENIS_DEFAULT_GIRTH))

/datum/preference/tri_color/genital/penis
	savefile_key = "penis_color"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	type_to_check = /datum/preference/choiced/genital/penis
	skin_color_type = /datum/preference/toggle/genital_skin_color/penis

/datum/preference/tri_bool/genital/penis
	savefile_key = "penis_emissive"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	type_to_check = /datum/preference/choiced/genital/penis
	skin_color_type = /datum/preference/toggle/genital_skin_color/penis

/datum/preference/toggle/penis_taur_mode
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "penis_taur_mode_toggle"
	default_value = FALSE
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS

/datum/preference/toggle/penis_taur_mode/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["penis_taur_mode"] = value

/datum/preference/toggle/penis_taur_mode/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/penis))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/choiced/penis_sheath
	savefile_key = "penis_sheath"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS

/datum/preference/choiced/penis_sheath/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/penis))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/choiced/penis_sheath/init_possible_values()
	return SHEATH_MODES

/datum/preference/choiced/penis_sheath/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["penis_sheath"] = value

/datum/preference/choiced/penis_sheath/create_default_value()
	return SHEATH_NONE

// TESTES

/datum/preference/choiced/genital/testicles
	savefile_key = "feature_testicles"
	relevant_mutant_bodypart = ORGAN_SLOT_TESTICLES
	default_accessory_type = /datum/sprite_accessory/genital/testicles/none

/datum/preference/toggle/genital_skin_tone/testicles
	savefile_key = "testicles_skin_tone"
	relevant_mutant_bodypart = ORGAN_SLOT_TESTICLES
	genital_pref_type = /datum/preference/choiced/genital/testicles

/datum/preference/toggle/genital_skin_tone/testicles/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["testicles_uses_skintones"] = value

/datum/preference/toggle/genital_skin_color/testicles
	savefile_key = "testicles_skin_color"
	relevant_mutant_bodypart = ORGAN_SLOT_TESTICLES
	genital_pref_type = /datum/preference/choiced/genital/testicles

/datum/preference/toggle/genital_skin_color/testicles/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!..()) // Don't apply it if it failed the check in the parent.
		value = FALSE

	target.dna.features["testicles_uses_skincolor"] = value

/datum/preference/tri_color/genital/testicles
	savefile_key = "testicles_color"
	relevant_mutant_bodypart = ORGAN_SLOT_TESTICLES
	type_to_check = /datum/preference/choiced/genital/testicles
	skin_color_type = /datum/preference/toggle/genital_skin_color/testicles

/datum/preference/tri_bool/genital/testicles
	savefile_key = "testicles_emissive"
	relevant_mutant_bodypart = ORGAN_SLOT_TESTICLES
	type_to_check = /datum/preference/choiced/genital/testicles
	skin_color_type = /datum/preference/toggle/genital_skin_color/testicles

/datum/preference/numeric/balls_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "balls_size"
	relevant_mutant_bodypart = ORGAN_SLOT_TESTICLES
	minimum = TESTICLES_MIN_SIZE
	maximum = TESTICLES_MAX_SIZE

/datum/preference/numeric/balls_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/testicles))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/numeric/balls_size/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["balls_size"] = value

/datum/preference/numeric/balls_size/create_default_value()
	return 2

// VAGINA

/datum/preference/choiced/genital/vagina
	savefile_key = "feature_vagina"
	relevant_mutant_bodypart = ORGAN_SLOT_VAGINA
	default_accessory_type = /datum/sprite_accessory/genital/vagina/none

/datum/preference/toggle/genital_skin_tone/vagina
	savefile_key = "vagina_skin_tone"
	relevant_mutant_bodypart = ORGAN_SLOT_VAGINA
	genital_pref_type = /datum/preference/choiced/genital/vagina

/datum/preference/toggle/genital_skin_tone/vagina/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["vagina_uses_skintones"] = value

/datum/preference/toggle/genital_skin_color/vagina
	savefile_key = "vagina_skin_color"
	relevant_mutant_bodypart = ORGAN_SLOT_VAGINA
	genital_pref_type = /datum/preference/choiced/genital/vagina

/datum/preference/toggle/genital_skin_color/vagina/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!..()) // Don't apply it if it failed the check in the parent.
		value = FALSE

	target.dna.features["vagina_uses_skincolor"] = value

/datum/preference/tri_color/genital/vagina
	savefile_key = "vagina_color"
	relevant_mutant_bodypart = ORGAN_SLOT_VAGINA
	type_to_check = /datum/preference/choiced/genital/vagina
	skin_color_type = /datum/preference/toggle/genital_skin_color/vagina

/datum/preference/tri_bool/genital/vagina
	savefile_key = "vagina_emissive"
	relevant_mutant_bodypart = ORGAN_SLOT_VAGINA
	type_to_check = /datum/preference/choiced/genital/vagina
	skin_color_type = /datum/preference/toggle/genital_skin_color/vagina

// UTERUS

/datum/preference/choiced/genital/womb
	savefile_key = "feature_womb"
	relevant_mutant_bodypart = ORGAN_SLOT_WOMB
	default_accessory_type = /datum/sprite_accessory/genital/womb/none

// BREASTS

/datum/preference/choiced/genital/breasts
	savefile_key = "feature_breasts"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS
	default_accessory_type = /datum/sprite_accessory/genital/breasts/none

/datum/preference/toggle/genital_skin_tone/breasts
	savefile_key = "breasts_skin_tone"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS
	genital_pref_type = /datum/preference/choiced/genital/breasts

/datum/preference/toggle/genital_skin_tone/breasts/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["breasts_uses_skintones"] = value

/datum/preference/toggle/genital_skin_color/breasts
	savefile_key = "breasts_skin_color"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS
	genital_pref_type = /datum/preference/choiced/genital/breasts

/datum/preference/toggle/genital_skin_color/breasts/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!..()) // Don't apply it if it failed the check in the parent.
		value = FALSE

	target.dna.features["breasts_uses_skincolor"] = value

/datum/preference/tri_color/genital/breasts
	savefile_key = "breasts_color"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS
	type_to_check = /datum/preference/choiced/genital/breasts
	skin_color_type = /datum/preference/toggle/genital_skin_color/breasts

/datum/preference/tri_bool/genital/breasts
	savefile_key = "breasts_emissive"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS
	type_to_check = /datum/preference/choiced/genital/breasts
	skin_color_type = /datum/preference/toggle/genital_skin_color/breasts

/datum/preference/toggle/breasts_lactation
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "breasts_lactation_toggle"
	default_value = FALSE
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS

/datum/preference/toggle/breasts_lactation/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	target.dna.features["breasts_lactation"] = value

/datum/preference/toggle/breasts_lactation/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/breasts))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/choiced/breasts_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "breasts_size"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS

/datum/preference/choiced/breasts_size/init_possible_values()
	return GLOB.breast_size_to_number

/datum/preference/choiced/breasts_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences) && preferences.read_preference(/datum/preference/toggle/allow_genitals)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/breasts))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/choiced/breasts_size/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["breasts_size"] = GLOB.breast_size_to_number[value]

/datum/preference/choiced/breasts_size/create_default_value()
	return BREAST_SIZE_C

// ANUS

/datum/preference/choiced/genital/anus
	savefile_key = "feature_anus"
	relevant_mutant_bodypart = ORGAN_SLOT_ANUS
	default_accessory_type = /datum/sprite_accessory/genital/anus/none
