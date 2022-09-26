/datum/preference/toggle/allow_mismatched_parts
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "allow_mismatched_parts_toggle"
	default_value = FALSE

/datum/preference/toggle/allow_mismatched_parts/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE // we dont actually want this to do anything

/datum/preference/toggle/allow_emissives
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "allow_emissives_toggle" // no 'e' so it goes right after allow_mismatched_parts, not before
	default_value = FALSE

/datum/preference/toggle/allow_emissives/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE // we dont actually want this to do anything

/datum/preference/tri_color/mutant_colors
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "mutant_colors_color"
	check_mode = TRICOLOR_NO_CHECK

/datum/preference/tri_color/mutant_colors/apply_to_human(mob/living/carbon/human/target, value)
	target.dna.features["mcolor"] = sanitize_hexcolor(value[1])
	target.dna.features["mcolor2"] = sanitize_hexcolor(value[2])
	target.dna.features["mcolor3"] = sanitize_hexcolor(value[3])

/datum/preference/toggle/eye_emissives
	savefile_key = "eye_emissives"
	savefile_identifier = PREFERENCE_CHARACTER
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	relevant_species_trait = EYECOLOR

/datum/preference/toggle/eye_emissives/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	var/obj/item/organ/internal/eyes/eyes_organ = target.getorgan(/obj/item/organ/internal/eyes)
	target.emissive_eyes = TRUE
	if (istype(eyes_organ))
		eyes_organ.is_emissive = value && preferences && is_allowed(preferences)

/datum/preference/toggle/eye_emissives/create_default_value()
	return FALSE

/datum/preference/toggle/eye_emissives/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = is_allowed(preferences)
	return passed_initial_check && allowed

/**
 * If eye emissives are actually on.
 */
/datum/preference/toggle/eye_emissives/proc/is_allowed(datum/preferences/preferences)
	return preferences.read_preference(/datum/preference/toggle/allow_emissives)

// Body Markings

/datum/preference/toggle/mutant_toggle/body_markings
	savefile_key = "body_markings_toggle"
	relevant_mutant_bodypart = "body_markings"

/datum/preference/choiced/mutant_choice/body_markings
	savefile_key = "feature_body_markings"
	relevant_mutant_bodypart = "body_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/body_markings
	default_accessory_type = /datum/sprite_accessory/body_markings/none

/datum/preference/tri_color/body_markings
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "body_markings_color"
	relevant_mutant_bodypart = "body_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/body_markings

/datum/preference/tri_bool/body_markings
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "body_markings_emissive"
	relevant_mutant_bodypart = "body_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/body_markings

/// Tails

/datum/preference/toggle/mutant_toggle/tail
	savefile_key = "tail_toggle"
	relevant_mutant_bodypart = "tail"

/datum/preference/choiced/mutant_choice/tail
	savefile_key = "feature_tail"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail
	default_accessory_type = /datum/sprite_accessory/tails/none

/datum/preference/tri_color/tail
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "tail_color"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail

/datum/preference/tri_bool/tail
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "tail_emissive"
	relevant_mutant_bodypart = "tail"
	type_to_check = /datum/preference/toggle/mutant_toggle/tail

/// Snouts

/datum/preference/toggle/mutant_toggle/snout
	savefile_key = "snout_toggle"
	relevant_mutant_bodypart = "snout"

/datum/preference/choiced/mutant_choice/snout
	savefile_key = "feature_snout"
	relevant_mutant_bodypart = "snout"
	type_to_check = /datum/preference/toggle/mutant_toggle/snout
	default_accessory_type = /datum/sprite_accessory/snouts/none

/datum/preference/choiced/mutant_choice/snout/apply_to_human(mob/living/carbon/human/target, value)
	. = ..()

	var/obj/item/bodypart/head/our_head = target.get_bodypart(BODY_ZONE_HEAD)
	if(.)
		our_head.bodytype |= BODYTYPE_SNOUTED
	else
		our_head.bodytype &= ~BODYTYPE_SNOUTED
	our_head.synchronize_bodytypes(target)

/datum/preference/tri_color/snout
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "snout_color"
	relevant_mutant_bodypart = "snout"
	type_to_check = /datum/preference/toggle/mutant_toggle/snout

/datum/preference/tri_bool/snout
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "snout_emissive"
	relevant_mutant_bodypart = "snout"
	type_to_check = /datum/preference/toggle/mutant_toggle/snout

/// Horns

/datum/preference/toggle/mutant_toggle/horns
	savefile_key = "horns_toggle"
	relevant_mutant_bodypart = "horns"

/datum/preference/choiced/mutant_choice/horns
	savefile_key = "feature_horns"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns
	default_accessory_type = /datum/sprite_accessory/horns/none

/datum/preference/tri_color/horns
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "horns_color"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns

/datum/preference/tri_bool/horns
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "horns_emissive"
	relevant_mutant_bodypart = "horns"
	type_to_check = /datum/preference/toggle/mutant_toggle/horns

/// Ears

/datum/preference/toggle/mutant_toggle/ears
	savefile_key = "ears_toggle"
	relevant_mutant_bodypart = "ears"

/datum/preference/choiced/mutant_choice/ears
	savefile_key = "feature_ears"
	relevant_mutant_bodypart = "ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears
	default_accessory_type = /datum/sprite_accessory/ears/none

/datum/preference/tri_color/ears
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ears_color"
	relevant_mutant_bodypart = "ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears

/datum/preference/tri_bool/ears
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ears_emissive"
	relevant_mutant_bodypart = "ears"
	type_to_check = /datum/preference/toggle/mutant_toggle/ears

/// Wings

/datum/preference/toggle/mutant_toggle/wings
	savefile_key = "wings_toggle"
	relevant_mutant_bodypart = "wings"

/datum/preference/choiced/mutant_choice/wings
	savefile_key = "feature_wings"
	relevant_mutant_bodypart = "wings"
	type_to_check = /datum/preference/toggle/mutant_toggle/wings
	default_accessory_type = /datum/sprite_accessory/wings/none

/datum/preference/tri_color/wings
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "wings_color"
	relevant_mutant_bodypart = "wings"
	type_to_check = /datum/preference/toggle/mutant_toggle/wings

/datum/preference/tri_bool/wings
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "wings_emissive"
	relevant_mutant_bodypart = "wings"
	type_to_check = /datum/preference/toggle/mutant_toggle/wings

/// Frills

/datum/preference/toggle/mutant_toggle/frills
	savefile_key = "frills_toggle"
	relevant_mutant_bodypart = "frills"

/datum/preference/choiced/mutant_choice/frills
	savefile_key = "feature_frills"
	relevant_mutant_bodypart = "frills"
	type_to_check = /datum/preference/toggle/mutant_toggle/frills
	default_accessory_type = /datum/sprite_accessory/frills/none

/datum/preference/tri_color/frills
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "frills_color"
	relevant_mutant_bodypart = "frills"
	type_to_check = /datum/preference/toggle/mutant_toggle/frills

/datum/preference/tri_bool/frills
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "frills_emissive"
	relevant_mutant_bodypart = "frills"
	type_to_check = /datum/preference/toggle/mutant_toggle/frills

/// Spines

/datum/preference/toggle/mutant_toggle/spines
	savefile_key = "spines_toggle"
	relevant_mutant_bodypart = "spines"

/datum/preference/choiced/mutant_choice/spines
	savefile_key = "feature_spines"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines
	default_accessory_type = /datum/sprite_accessory/spines/none

/datum/preference/tri_color/spines
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "spines_color"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines

/datum/preference/tri_bool/spines
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "spines_emissive"
	relevant_mutant_bodypart = "spines"
	type_to_check = /datum/preference/toggle/mutant_toggle/spines

/// Caps

/datum/preference/toggle/mutant_toggle/caps
	savefile_key = "caps_toggle"
	relevant_mutant_bodypart = "caps"

/datum/preference/choiced/mutant_choice/caps
	savefile_key = "feature_caps"
	relevant_mutant_bodypart = "caps"
	type_to_check = /datum/preference/toggle/mutant_toggle/caps
	default_accessory_type = /datum/sprite_accessory/caps/none

/datum/preference/tri_color/caps
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "caps_color"
	relevant_mutant_bodypart = "caps"
	type_to_check = /datum/preference/toggle/mutant_toggle/caps

/datum/preference/tri_bool/caps
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "caps_emissive"
	relevant_mutant_bodypart = "caps"
	type_to_check = /datum/preference/toggle/mutant_toggle/caps

/// Moth Antennae

/datum/preference/toggle/mutant_toggle/moth_antennae
	savefile_key = "moth_antennae_toggle"
	relevant_mutant_bodypart = "moth_antennae"

/datum/preference/choiced/mutant_choice/moth_antennae
	savefile_key = "feature_moth_antennae"
	relevant_mutant_bodypart = "moth_antennae"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_antennae
	default_accessory_type = /datum/sprite_accessory/moth_antennae/none

/datum/preference/tri_color/moth_antennae
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "moth_antennae_color"
	relevant_mutant_bodypart = "moth_antennae"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_antennae

/datum/preference/tri_bool/moth_antennae
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "moth_antennae_emissive"
	relevant_mutant_bodypart = "moth_antennae"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_antennae

/// Moth Markings

/datum/preference/toggle/mutant_toggle/moth_markings
	savefile_key = "moth_markings_toggle"
	relevant_mutant_bodypart = "moth_markings"

/datum/preference/choiced/mutant_choice/moth_markings
	savefile_key = "feature_moth_markings"
	relevant_mutant_bodypart = "moth_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_markings
	default_accessory_type = /datum/sprite_accessory/moth_markings/none

/datum/preference/tri_color/moth_markings
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "moth_markings_color"
	relevant_mutant_bodypart = "moth_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_markings

/datum/preference/tri_bool/moth_markings
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "moth_markings_emissive"
	relevant_mutant_bodypart = "moth_markings"
	type_to_check = /datum/preference/toggle/mutant_toggle/moth_markings

/// Fluff

/datum/preference/toggle/mutant_toggle/fluff
	savefile_key = "fluff_toggle"
	relevant_mutant_bodypart = "fluff"

/datum/preference/choiced/mutant_choice/fluff
	savefile_key = "feature_fluff"
	relevant_mutant_bodypart = "fluff"
	type_to_check = /datum/preference/toggle/mutant_toggle/fluff
	default_accessory_type = /datum/sprite_accessory/fluff/moth/none

/datum/preference/tri_color/fluff
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "fluff_color"
	relevant_mutant_bodypart = "fluff"
	type_to_check = /datum/preference/toggle/mutant_toggle/fluff

/datum/preference/tri_bool/fluff
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "fluff_emissive"
	relevant_mutant_bodypart = "fluff"
	type_to_check = /datum/preference/toggle/mutant_toggle/fluff

/// IPC Screens

/datum/preference/toggle/mutant_toggle/ipc_screen
	savefile_key = "ipc_screen_toggle"
	relevant_mutant_bodypart = "ipc_screen"

/datum/preference/choiced/mutant_choice/ipc_screen
	savefile_key = "feature_ipc_screen"
	relevant_mutant_bodypart = "ipc_screen"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_screen
	default_accessory_type = /datum/sprite_accessory/screen/none

/datum/preference/tri_color/ipc_screen
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_screen_color"
	relevant_mutant_bodypart = "ipc_screen"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_screen

/datum/preference/tri_bool/ipc_screen
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_screen_emissive"
	relevant_mutant_bodypart = "ipc_screen"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_screen

/// IPC Antennas

/datum/preference/toggle/mutant_toggle/ipc_antenna
	savefile_key = "ipc_antenna_toggle"
	relevant_mutant_bodypart = "ipc_antenna"

/datum/preference/choiced/mutant_choice/ipc_antenna
	savefile_key = "feature_ipc_antenna"
	relevant_mutant_bodypart = "ipc_antenna"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_antenna
	default_accessory_type = /datum/sprite_accessory/antenna/none

/datum/preference/tri_color/ipc_antenna
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_antenna_color"
	relevant_mutant_bodypart = "ipc_antenna"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_antenna

/datum/preference/tri_bool/ipc_antenna
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_antenna_emissive"
	relevant_mutant_bodypart = "ipc_antenna"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_antenna

/// IPC Chassis

/datum/preference/toggle/mutant_toggle/ipc_chassis
	savefile_key = "ipc_chassis_toggle"
	relevant_mutant_bodypart = "ipc_chassis"

/datum/preference/choiced/mutant_choice/ipc_chassis
	savefile_key = "feature_ipc_chassis"
	relevant_mutant_bodypart = "ipc_chassis"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_chassis
	default_accessory_type = /datum/sprite_accessory/ipc_chassis/none

/datum/preference/tri_color/ipc_chassis
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_chassis_color"
	relevant_mutant_bodypart = "ipc_chassis"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_chassis


/// IPC Head

/datum/preference/toggle/mutant_toggle/ipc_head
	savefile_key = "ipc_head_toggle"
	relevant_mutant_bodypart = "ipc_head"

/datum/preference/choiced/mutant_choice/ipc_head
	savefile_key = "feature_ipc_head"
	relevant_mutant_bodypart = "ipc_head"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_head
	default_accessory_type = /datum/sprite_accessory/ipc_head/none

/datum/preference/tri_color/ipc_head
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "ipc_head_color"
	relevant_mutant_bodypart = "ipc_head"
	type_to_check = /datum/preference/toggle/mutant_toggle/ipc_head


/// Skrell Hair

/datum/preference/toggle/mutant_toggle/skrell_hair
	savefile_key = "skrell_hair_toggle"
	relevant_mutant_bodypart = "skrell_hair"

/datum/preference/choiced/mutant_choice/skrell_hair
	savefile_key = "feature_skrell_hair"
	relevant_mutant_bodypart = "skrell_hair"
	type_to_check = /datum/preference/toggle/mutant_toggle/skrell_hair
	default_accessory_type = /datum/sprite_accessory/skrell_hair/none

/datum/preference/tri_color/skrell_hair
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "skrell_hair_color"
	relevant_mutant_bodypart = "skrell_hair"
	type_to_check = /datum/preference/toggle/mutant_toggle/skrell_hair

/datum/preference/tri_bool/skrell_hair
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "skrell_hair_emissive"
	relevant_mutant_bodypart = "skrell_hair"
	type_to_check = /datum/preference/toggle/mutant_toggle/skrell_hair

/// Taur

/datum/preference/toggle/mutant_toggle/taur
	savefile_key = "taur_toggle"
	relevant_mutant_bodypart = "taur"

/datum/preference/choiced/mutant_choice/taur
	savefile_key = "feature_taur"
	relevant_mutant_bodypart = "taur"
	type_to_check = /datum/preference/toggle/mutant_toggle/taur
	default_accessory_type = /datum/sprite_accessory/taur/none

/datum/preference/tri_color/taur
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "taur_color"
	relevant_mutant_bodypart = "taur"
	type_to_check = /datum/preference/toggle/mutant_toggle/taur

/datum/preference/tri_bool/taur
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "taur_emissive"
	relevant_mutant_bodypart = "taur"
	type_to_check = /datum/preference/toggle/mutant_toggle/taur

/// Xenodorsal

/datum/preference/toggle/mutant_toggle/xenodorsal
	savefile_key = "xenodorsal_toggle"
	relevant_mutant_bodypart = "xenodorsal"

/datum/preference/choiced/mutant_choice/xenodorsal
	savefile_key = "feature_xenodorsal"
	relevant_mutant_bodypart = "xenodorsal"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenodorsal
	default_accessory_type = /datum/sprite_accessory/xenodorsal/none

/datum/preference/tri_color/xenodorsal
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "xenodorsal_color"
	relevant_mutant_bodypart = "xenodorsal"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenodorsal

/datum/preference/tri_bool/xenodorsal
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "xenodorsal_emissive"
	relevant_mutant_bodypart = "xenodorsal"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenodorsal

/// Xeno heads

/datum/preference/toggle/mutant_toggle/xenohead
	savefile_key = "xenohead_toggle"
	relevant_mutant_bodypart = "xenohead"

/datum/preference/choiced/mutant_choice/xenohead
	savefile_key = "feature_xenohead"
	relevant_mutant_bodypart = "xenohead"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenohead
	default_accessory_type = /datum/sprite_accessory/xenohead/none

/datum/preference/tri_color/xenohead
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "xenohead_color"
	relevant_mutant_bodypart = "xenohead"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenohead

/datum/preference/tri_bool/xenohead
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "xenohead_emissive"
	relevant_mutant_bodypart = "xenohead"
	type_to_check = /datum/preference/toggle/mutant_toggle/xenohead


/// Head Accessories - Unless more get added, this is only able to be applied for one person, a donator only thing

/datum/preference/toggle/mutant_toggle/head_acc
	savefile_key = "head_acc_toggle"
	relevant_mutant_bodypart = "head_acc"

/datum/preference/toggle/mutant_toggle/head_acc/is_accessible(datum/preferences/preferences)
	var/ckeycheck = preferences?.parent?.ckey == "whirlsam"
	return ckeycheck && ..(preferences)

/datum/preference/choiced/mutant_choice/head_acc
	savefile_key = "feature_head_acc"
	relevant_mutant_bodypart = "head_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/head_acc
	default_accessory_type = /datum/sprite_accessory/head_accessory/none

/datum/preference/tri_color/head_acc
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "head_acc_color"
	relevant_mutant_bodypart = "head_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/head_acc

/datum/preference/tri_bool/head_acc
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "head_acc_emissive"
	relevant_mutant_bodypart = "head_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/head_acc

/// Neck Accessories - Same as head_acc

/datum/preference/toggle/mutant_toggle/neck_acc
	savefile_key = "neck_acc_toggle"
	relevant_mutant_bodypart = "neck_acc"

/datum/preference/toggle/mutant_toggle/neck_acc/is_accessible(datum/preferences/preferences)
	var/ckeycheck = preferences?.parent?.ckey == "whirlsam"
	return ckeycheck && ..(preferences)

/datum/preference/choiced/mutant_choice/neck_acc
	savefile_key = "feature_neck_acc"
	relevant_mutant_bodypart = "neck_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/neck_acc
	default_accessory_type = /datum/sprite_accessory/neck_accessory/none

/datum/preference/tri_color/neck_acc
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "neck_acc_color"
	relevant_mutant_bodypart = "neck_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/neck_acc

/datum/preference/tri_bool/neck_acc
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "neck_acc_emissive"
	relevant_mutant_bodypart = "neck_acc"
	type_to_check = /datum/preference/toggle/mutant_toggle/neck_acc

