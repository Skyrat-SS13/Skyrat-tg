//THIS FILE HAS BEEN EDITED BY SKYRAT EDIT

/proc/generate_values_for_underwear(list/accessory_list, list/icons, color, icon_offset) //SKYRAT EDIT CHANGE - Colorable Undershirt/Socks
	var/icon/lower_half = icon('icons/blanks/32x32.dmi', "nothing")

	for (var/icon in icons)
		lower_half.Blend(icon('icons/mob/human_parts_greyscale.dmi', icon), ICON_OVERLAY)

	var/list/values = list()

	for (var/accessory_name in accessory_list)
		var/icon/icon_with_socks = new(lower_half)
		var/datum/sprite_accessory/accessory = accessory_list[accessory_name]
		//SKYRAT EDIT CHANGE
		if (accessory_name != "Nude" && accessory)
			var/icon/accessory_icon = icon(accessory.icon, accessory.icon_state)
		//SKYRAT EDIT CHANGE END
			if (color && !accessory.use_static)
				accessory_icon.Blend(color, ICON_MULTIPLY)
			icon_with_socks.Blend(accessory_icon, ICON_OVERLAY)
		icon_with_socks.Crop(10, 1+icon_offset, 22, 13+icon_offset)	//SKYRAT EDIT CHANGE - Colorable Undershirt/Socks

		icon_with_socks.Scale(32, 32)

		values[accessory_name] = icon_with_socks

	return values

/// Backpack preference
/datum/preference/choiced/backpack
	savefile_key = "backpack"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "Backpack"
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE

/datum/preference/choiced/backpack/init_possible_values()
	var/list/values = list()

	values[GBACKPACK] = /obj/item/storage/backpack
	values[GSATCHEL] = /obj/item/storage/backpack/satchel
	values[LSATCHEL] = /obj/item/storage/backpack/satchel/leather
	values[GDUFFELBAG] = /obj/item/storage/backpack/duffelbag

	// In a perfect world, these would be your department's backpack.
	// However, this doesn't factor in assistants, or no high slot, and would
	// also increase the spritesheet size a lot.
	// I play medical doctor, and so medical doctor you get.
	values[DBACKPACK] = /obj/item/storage/backpack/medic
	values[DSATCHEL] = /obj/item/storage/backpack/satchel/med
	values[DDUFFELBAG] = /obj/item/storage/backpack/duffelbag/med

	return values

/datum/preference/choiced/backpack/apply_to_human(mob/living/carbon/human/target, value)
	target.backpack = value

/// Jumpsuit preference
/datum/preference/choiced/jumpsuit
	savefile_key = "jumpsuit_style"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "Jumpsuit"
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE

/datum/preference/choiced/jumpsuit/init_possible_values()
	var/list/values = list()

	values[PREF_SUIT] = /obj/item/clothing/under/color/grey
	values[PREF_SKIRT] = /obj/item/clothing/under/color/jumpskirt/grey

	return values

/datum/preference/choiced/jumpsuit/apply_to_human(mob/living/carbon/human/target, value)
	target.jumpsuit_style = value

/// Socks preference
/datum/preference/choiced/socks
	savefile_key = "socks"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "Socks"
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE

/datum/preference/choiced/socks/init_possible_values()
	return generate_values_for_underwear(GLOB.socks_list, list("human_r_leg", "human_l_leg"), COLOR_ALMOST_BLACK, 0) //SKYRAT EDIT CHANGE - Colorable Undershirt/Socks

/datum/preference/choiced/socks/apply_to_human(mob/living/carbon/human/target, value)
	target.socks = value

//SKYRAT EDIT CHANGE BEGIN - Colorable Undershirt/Socks
/datum/preference/choiced/socks/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "socks_color"

	return data
//SKYRAT EDIT CHANGE END - Colorable Undershirt/Socks

/// Undershirt preference
/datum/preference/choiced/undershirt
	savefile_key = "undershirt"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "Undershirt"
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE

//SKYRAT EDIT CHANGE BEGIN - Colorable Undershirt/Socks
/datum/preference/choiced/undershirt/init_possible_values()
	return generate_values_for_underwear(GLOB.undershirt_list, list("human_chest_m", "human_r_arm", "human_l_arm", "human_r_leg", "human_l_leg", "human_r_hand", "human_l_hand"), COLOR_ALMOST_BLACK,10)

/datum/preference/choiced/undershirt/apply_to_human(mob/living/carbon/human/target, value)
	target.undershirt = value

/datum/preference/choiced/undershirt/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "undershirt_color"

	return data
//SKYRAT EDIT CHANGE END - Colorable Undershirt/Socks

/// Underwear preference
/datum/preference/choiced/underwear
	savefile_key = "underwear"
	savefile_identifier = PREFERENCE_CHARACTER
	main_feature_name = "Underwear"
	category = PREFERENCE_CATEGORY_CLOTHING
	should_generate_icons = TRUE

/datum/preference/choiced/underwear/init_possible_values()
	return generate_values_for_underwear(GLOB.underwear_list, list("human_chest_m", "human_r_leg", "human_l_leg"), COLOR_ALMOST_BLACK, 5) //SKYRAT EDIT CHANGE - Colorable Undershirt/Socks

/datum/preference/choiced/underwear/apply_to_human(mob/living/carbon/human/target, value)
	target.underwear = value

/datum/preference/choiced/underwear/is_accessible(datum/preferences/preferences)
	if (!..(preferences))
		return FALSE

	var/species_type = preferences.read_preference(/datum/preference/choiced/species)
	var/datum/species/species = species_type
	return !(NO_UNDERWEAR in initial(species.species_traits))

/datum/preference/choiced/underwear/compile_constant_data()
	var/list/data = ..()

	data[SUPPLEMENTAL_FEATURE_KEY] = "underwear_color"

	return data

