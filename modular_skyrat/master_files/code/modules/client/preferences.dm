/datum/preferences
	/// Loadout prefs. Assoc list of [typepaths] to [associated list of item info].
	var/list/loadout_list
	/// Associative list, keyed by language typepath, pointing to LANGUAGE_UNDERSTOOD, or LANGUAGE_SPOKEN, for whether we understand or speak the language
	var/list/languages = list()
	/// List of chosen augmentations. It's an associative list with key name of the slot, pointing to a typepath of an augment define
	var/augments = list()
	/// List of chosen preferred styles for limb replacements
	var/augment_limb_styles = list()
	/// Which augment slot we currently have chosen, this is for UI display
	var/chosen_augment_slot
	/// Has to include all information that extra organs from mutant bodyparts would need. (so far only genitals now)
	var/list/features = MANDATORY_FEATURE_LIST
	/// A list containing all of our mutant bodparts
	var/list/list/mutant_bodyparts = list()
	/// A list of all bodymarkings
	var/list/list/body_markings = list()

/// This proc returns an associative list of the default mutant parts of the selected species, with each possible sprite accessory for that mutant part,
/// and the icon for it.
/datum/preferences/proc/build_mutant_bodyparts()
	var/species_id = read_preference(/datum/preference/choiced/species)
	var/datum/species/species = new species_id

	var/list/required_mutant_part_types = list()

	for(var/mutant_part_name in species.default_mutant_bodyparts)
		for(var/accessory_type in GLOB.sprite_accessories[mutant_part_name])
			var/datum/sprite_accessory/sprite_accessory = accessory_type
			required_mutant_part_types[mutant_part_name][sprite_accessory] = icon(sprite_accessory.icon, sprite_accessory.icon_state, EAST)

	return required_mutant_part_types


/datum/preferences/proc/compile_mutant_data(mutant_key)
	var/list/data = list()

	var/list/choices = list()

	for (var/choice in GLOB.sprite_accessories[mutant_key])
		choices += choice

	data["choices"] = choices

	var/list/icons = list()
	for(var/choice in choices)
		icons[choice] = "[mutant_key]___[sanitize_css_class_name(choice)]"

	data["icons"] = icons

	data["name"] = mutant_key

	return data
