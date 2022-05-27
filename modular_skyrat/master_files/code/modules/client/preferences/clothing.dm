/datum/preference/choiced/socks/init_possible_values()
	return generate_values_for_underwear(GLOB.socks_list, list("human_r_leg", "human_l_leg"), COLOR_ALMOST_BLACK, 0)

/datum/preference/choiced/socks/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "socks_color"

	return data

/datum/preference/choiced/socks/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(NO_UNDERWEAR in species.species_traits)

/datum/preference/choiced/undershirt/init_possible_values()
	return generate_values_for_underwear(GLOB.undershirt_list, list("human_chest_m", "human_r_arm", "human_l_arm", "human_r_leg", "human_l_leg", "human_r_hand", "human_l_hand"), COLOR_ALMOST_BLACK, 10)

/datum/preference/choiced/undershirt/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "undershirt_color"

	return data

/datum/preference/choiced/undershirt/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(NO_UNDERWEAR in species.species_traits)

/datum/preference/choiced/underwear/init_possible_values()
	return generate_values_for_underwear(GLOB.underwear_list, list("human_chest_m", "human_r_leg", "human_l_leg"), COLOR_ALMOST_BLACK, 5)

/datum/preference/choiced/underwear/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(NO_UNDERWEAR in species.species_traits)
