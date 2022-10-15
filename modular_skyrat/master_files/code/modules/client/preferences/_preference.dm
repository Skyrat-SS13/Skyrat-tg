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
