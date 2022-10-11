/// A preference for text and text input.
/datum/preference/text
	abstract_type = /datum/preference/text

/datum/preference/text/deserialize(input, datum/preferences/preferences)
	return STRIP_HTML_SIMPLE(input, MAX_FLAVOR_LEN)

/datum/preference/text/create_default_value()
	return ""

/datum/preference/text/is_valid(value)
	return istext(value)

/datum/preference/tri_color
	abstract_type = /datum/preference/tri_color
	var/type_to_check = /datum/preference/toggle/allow_mismatched_parts
	var/check_mode = TRICOLOR_CHECK_BOOLEAN

/datum/preference/tri_color/deserialize(input, datum/preferences/preferences)
	var/list/input_colors = input
	return list(sanitize_hexcolor(input_colors[1]), sanitize_hexcolor(input_colors[2]), sanitize_hexcolor(input_colors[3]))

/datum/preference/tri_color/create_default_value()
	return list("#[random_color()]", "#[random_color()]", "#[random_color()]")

/datum/preference/tri_color/is_valid(list/value)
	return islist(value) && value.len == 3 && (findtext(value[1], GLOB.is_color) && findtext(value[2], GLOB.is_color) && findtext(value[3], GLOB.is_color))

/datum/preference/tri_color/is_accessible(datum/preferences/preferences)
	if (check_mode == TRICOLOR_NO_CHECK || type == abstract_type)
		return ..(preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/part_enabled = preferences.read_preference(type_to_check)
	if(check_mode == TRICOLOR_CHECK_ACCESSORY)
		part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, part_enabled)
	return ((passed_initial_check || allowed) && part_enabled)

/datum/preference/tri_color/apply_to_human(mob/living/carbon/human/target, value)
	if (type == abstract_type)
		return ..()
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_COLOR_LIST] = list(sanitize_hexcolor(value[1]), sanitize_hexcolor(value[2]), sanitize_hexcolor(value[3]))

/datum/preference/tri_bool
	abstract_type = /datum/preference/tri_bool
	var/type_to_check = /datum/preference/toggle/allow_mismatched_parts
	var/check_mode = TRICOLOR_CHECK_BOOLEAN

/datum/preference/tri_bool/deserialize(input, datum/preferences/preferences)
	var/list/input_bools = input
	return list(sanitize_integer(input_bools[1]), sanitize_integer(input_bools[2]), sanitize_integer(input_bools[3]))

/datum/preference/tri_bool/create_default_value()
	return list(FALSE, FALSE, FALSE)

/datum/preference/tri_bool/is_valid(list/value)
	return islist(value) && value.len == 3 && isnum(value[1]) && isnum(value[2]) && isnum(value[3])

/datum/preference/tri_bool/is_accessible(datum/preferences/preferences)
	if(type == abstract_type)
		return ..(preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/emissives_allowed = preferences.read_preference(/datum/preference/toggle/allow_emissives)
	var/part_enabled = preferences.read_preference(type_to_check)
	if(check_mode == TRICOLOR_CHECK_ACCESSORY)
		part_enabled = is_factual_sprite_accessory(relevant_mutant_bodypart, part_enabled)
	return ((passed_initial_check || allowed) && part_enabled && emissives_allowed)

/datum/preference/tri_bool/apply_to_human(mob/living/carbon/human/target, value)
	if (type == abstract_type)
		return ..()
	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = "None", MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_EMISSIVE_LIST] = list(sanitize_integer(value[1]), sanitize_integer(value[2]), sanitize_integer(value[3]))

/**
 * Base class for character feature togglers
 */
/datum/preference/toggle/mutant_toggle
	abstract_type = /datum/preference/toggle/mutant_toggle
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER
	default_value = FALSE

	/// The linked preferences to this toggle. Automatically filled.
	var/list/linked_preference_paths = list()

/datum/preference/toggle/mutant_toggle/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	return TRUE // we dont actually want this to do anything

/datum/preference/toggle/mutant_toggle/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/allowed = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	return passed_initial_check || allowed

/**
 * Base class for choices character features, mainly mutant body parts
 */
/datum/preference/choiced/mutant_choice
	abstract_type = /datum/preference/choiced/mutant_choice
	category = PREFERENCE_CATEGORY_SECONDARY_FEATURES
	savefile_identifier = PREFERENCE_CHARACTER

	/// Path to the default sprite accessory
	var/datum/sprite_accessory/default_accessory_type
	/// Path to the corresponding /datum/preference/toggle to check if part is enabled.
	var/datum/preference/toggle/type_to_check

/datum/preference/choiced/mutant_choice/is_accessible(datum/preferences/preferences)
	var/passed_initial_check = ..(preferences)
	var/overriding = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/part_enabled = is_part_enabled(preferences)
	return (passed_initial_check || overriding) && part_enabled

/datum/preference/choiced/mutant_choice/init_possible_values()
	return assoc_to_keys(GLOB.sprite_accessories[relevant_mutant_bodypart])

/datum/preference/choiced/mutant_choice/create_default_value()
	return initial(default_accessory_type?.name) || "None"

/**
 * Is this part enabled by the player?
 *
 * Arguments:
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant_choice/proc/is_part_enabled(datum/preferences/preferences)
	return preferences.read_preference(type_to_check)

/**
 * Actually rendered. Slimmed down version of the logic in is_available() that actually works when spawning or drawing the character.
 *
 * Returns if feature is visible.
 *
 * Arguments:
 * * target - The character this is being applied to.
 * * preferences - The relevant character preferences.
 */
/datum/preference/choiced/mutant_choice/proc/is_visible(mob/living/carbon/human/target, datum/preferences/preferences)
	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type

	var/species_available = (savefile_key in species.get_features())

	var/overriding = preferences.read_preference(/datum/preference/toggle/allow_mismatched_parts)
	var/part_enabled = is_part_enabled(preferences)
	return (species_available || overriding) && part_enabled

/datum/preference/choiced/mutant_choice/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/preferences)
	if(!preferences || !is_visible(target, preferences))
		value = create_default_value()

	if(!target.dna.mutant_bodyparts[relevant_mutant_bodypart])
		target.dna.mutant_bodyparts[relevant_mutant_bodypart] = list(MUTANT_INDEX_NAME = value, MUTANT_INDEX_COLOR_LIST = list("#FFFFFF", "#FFFFFF", "#FFFFFF"), MUTANT_INDEX_EMISSIVE_LIST = list(FALSE, FALSE, FALSE))
		return TRUE

	target.dna.mutant_bodyparts[relevant_mutant_bodypart][MUTANT_INDEX_NAME] = value
	return TRUE
