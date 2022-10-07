// 200 dollars is 200 dollars :(

// ABSTRACT TYPES

/datum/preference/choiced/genital
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	abstract_type = /datum/preference/choiced/genital

/datum/preference/choiced/genital/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list("name" = "None", "color" = list("#FFFFFF", "#FFFFFF", "#FFFFFF"))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart]["name"] = value

/datum/preference/choiced/genital/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	return erp_allowed && (passed_initial_check || allowed)

/datum/preference/choiced/genital/init_possible_values()
	return assoc_to_keys(GLOB.sprite_accessories[relevant_mutant_bodypart])

/datum/preference/toggle/genital_skin_tone
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE
	abstract_type = /datum/preference/toggle/genital_skin_tone
	var/genital_pref_type

/datum/preference/toggle/genital_skin_tone/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/part_name = preferences.read_preference(genital_pref_type)
	var/datum/sprite_accessory/genital/accessory = GLOB.sprite_accessories[relevant_mutant_bodypart]?[part_name]
	if(!accessory?.factual || !accessory.has_skintone_shading)
		return FALSE
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	return erp_allowed && (passed_initial_check || allowed)

/datum/preference/toggle/genital_skin_color
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE
	abstract_type = /datum/preference/toggle/genital_skin_color
	var/genital_pref_type

/datum/preference/toggle/genital_skin_color/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/datum/species/species_type = preferences.read_preference(/datum/preference/choiced/species)
	if(!initial(species_type.use_skintones))
		return FALSE
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(genital_pref_type))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/tri_color/genital
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	check_mode = TRICOLOR_CHECK_ACCESSORY
	abstract_type = /datum/preference/tri_color/genital
	var/skin_color_type

/datum/preference/tri_color/genital/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	var/can_color = TRUE
	/// Checks that the use skin color pref is both enabled and actually accessible. If so, then this is useless.
	if(preferences.read_preference(skin_color_type))
		var/datum/preference/toggle/genital_skin_color/skincolor = GLOB.preference_entries[skin_color_type]
		if(skincolor.is_accessible(preferences))
			can_color = FALSE
	return erp_allowed && can_color && (passed_initial_check || allowed)

/datum/preference/tri_bool/genital
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	check_mode = TRICOLOR_CHECK_ACCESSORY
	abstract_type = /datum/preference/tri_bool/genital
	var/skin_color_type

/datum/preference/tri_bool/genital/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	var/can_color = TRUE
	/// Checks that the use skin color pref is both enabled and actually accessible. If so, then this is useless.
	if(preferences.read_preference(skin_color_type))
		var/datum/preference/toggle/genital_skin_color/skincolor = GLOB.preference_entries[skin_color_type]
		if(skincolor.is_accessible(preferences))
			can_color = FALSE
	return erp_allowed && can_color && (passed_initial_check || allowed)

// PENIS

/datum/preference/choiced/genital/penis
	savefile_key = "feature_penis"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS

/datum/preference/choiced/genital/penis/create_default_value()
	var/datum/sprite_accessory/genital/penis/none/default = /datum/sprite_accessory/genital/penis/none
	return initial(default.name)

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
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/penis))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/numeric/penis_length/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["penis_size"] = value

/datum/preference/numeric/penis_length/create_default_value() // if you change from this to PENIS_MAX_LENGTH the game should laugh at you
	return round((PENIS_MIN_LENGTH + PENIS_MAX_LENGTH) / 2)

/datum/preference/numeric/penis_girth
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "penis_girth"
	relevant_mutant_bodypart = ORGAN_SLOT_PENIS
	minimum = PENIS_MIN_LENGTH
	maximum = PENIS_MAX_GIRTH

/datum/preference/numeric/penis_girth/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/penis))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/numeric/penis_girth/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["penis_girth"] = value

/datum/preference/numeric/penis_girth/create_default_value()
	return round((PENIS_MIN_LENGTH + PENIS_MAX_GIRTH) / 2)

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
	target.dna.features["penis_taur"] = value

/datum/preference/toggle/penis_taur_mode/is_accessible(datum/preferences/preferences)
	if(CONFIG_GET(flag/disable_erp_preferences))
		return FALSE
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
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
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
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

/datum/preference/choiced/genital/testicles/create_default_value()
	var/datum/sprite_accessory/genital/testicles/none/default = /datum/sprite_accessory/genital/testicles/none
	return initial(default.name)

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
	minimum = 0
	maximum = 3

/datum/preference/numeric/balls_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
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
	target.dna.features["vagina_uses_skincolor"] = value

/datum/preference/choiced/genital/vagina/create_default_value()
	var/datum/sprite_accessory/genital/vagina/none/default = /datum/sprite_accessory/genital/vagina/none
	return initial(default.name)

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

/datum/preference/choiced/genital/womb/create_default_value()
	var/datum/sprite_accessory/genital/womb/none/default = /datum/sprite_accessory/genital/womb/none
	return initial(default.name)

// BREASTS

/datum/preference/choiced/genital/breasts
	savefile_key = "feature_breasts"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS

/datum/preference/choiced/genital/breasts/create_default_value()
	var/datum/sprite_accessory/genital/breasts/none/default = /datum/sprite_accessory/genital/breasts/none
	return initial(default.name)

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
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
	var/part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, preferences.read_preference(/datum/preference/choiced/genital/breasts))
	return erp_allowed && part_enabled && (passed_initial_check || allowed)

/datum/preference/choiced/breasts_size
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "breasts_size"
	relevant_mutant_bodypart = ORGAN_SLOT_BREASTS

/datum/preference/choiced/breasts_size/init_possible_values()
	return GLOB.preference_breast_sizes

/datum/preference/choiced/breasts_size/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/erp_allowed = preferences.read_preference(/datum/preference/toggle/master_erp_preferences)
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

/datum/preference/choiced/genital/anus/create_default_value()
	var/datum/sprite_accessory/genital/anus/none/default = /datum/sprite_accessory/genital/anus/none
	return initial(default.name)
