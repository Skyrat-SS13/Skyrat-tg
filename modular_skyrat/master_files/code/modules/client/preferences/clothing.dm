/datum/preference/choiced/socks/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "socks_color"

	return data

/datum/preference/choiced/socks/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/undershirt/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "undershirt_color"

	return data

/datum/preference/choiced/undershirt/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/underwear/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/bra
	savefile_key = "bra"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "Bra"
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE

/datum/preference/choiced/bra/init_possible_values()
	return assoc_to_keys_features(SSaccessories.bra_list)

/datum/preference/choiced/bra/icon_for(value)
	var/static/icon/body
	if (isnull(body))
		body = icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_arm")
		body.Blend(icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_arm"), ICON_OVERLAY)
		body.Blend(icon('icons/mob/human/bodyparts_greyscale.dmi', "human_r_hand"), ICON_OVERLAY)
		body.Blend(icon('icons/mob/human/bodyparts_greyscale.dmi', "human_l_hand"), ICON_OVERLAY)
		body.Blend(icon('icons/mob/human/bodyparts_greyscale.dmi', "human_chest_m"), ICON_OVERLAY)

	var/icon/icon_with_bra = icon(body)

	if (value != "Nude")
		var/datum/sprite_accessory/accessory = SSaccessories.bra_list[value]
		icon_with_bra.Blend(icon(accessory.icon, accessory.icon_state), ICON_OVERLAY)

	icon_with_bra.Crop(10, 11, 22, 23) // SKYRAT EDIT CHANGE : ORIGINAL - icon_with_undershirt.Crop(9, 9, 23, 23)
	icon_with_bra.Scale(32, 32)
	return icon_with_bra

/datum/preference/choiced/bra/apply_to_human(mob/living/carbon/human/target, value)
	target.bra = value

/datum/preference/choiced/bra/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "bra_color"

	return data

/datum/preference/choiced/bra/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_type
	return !(TRAIT_NO_UNDERWEAR in species.inherent_traits)

/datum/preference/choiced/bra/create_informed_default_value(datum/preferences/preferences)
	if(preferences.read_preference(/datum/preference/choiced/gender) == FEMALE)
		return /datum/sprite_accessory/bra/sports_bra::name
	return /datum/sprite_accessory/bra/nude::name
