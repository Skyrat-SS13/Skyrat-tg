/// Species preference
/datum/preference/choiced/species
	savefile_identifier = PREFERENCE_CHARACTER
	savefile_key = "species"
	priority = PREFERENCE_PRIORITY_SPECIES
	randomize_by_default = FALSE

/datum/preference/choiced/species/deserialize(input, datum/preferences/preferences)
	return GLOB.species_list[sanitize_inlist(input, get_choices_serialized(), SPECIES_HUMAN)]

/datum/preference/choiced/species/serialize(input)
	var/datum/species/species = input
	return initial(species.id)

/datum/preference/choiced/species/create_default_value()
	return /datum/species/human

/datum/preference/choiced/species/create_random_value(datum/preferences/preferences)
	return pick(get_choices())

/datum/preference/choiced/species/init_possible_values()
	var/list/values = list()

	for (var/species_id in get_selectable_species())
		values += GLOB.species_list[species_id]

	//SKYRAT EDIT ADDITION
	for (var/species_id in get_customizable_races())
		values += GLOB.species_list[species_id]
	//SKYRAT EDIT END

	return values

/datum/preference/choiced/species/apply_to_human(mob/living/carbon/human/target, value, datum/preferences/prefs)
	target.set_species(value, FALSE, FALSE, prefs?.features.Copy(), prefs?.mutant_bodyparts.Copy(), prefs?.body_markings.Copy()) // SKYRAT EDIT - Customization

	//SKYRAT EDIT ADDITION
	target.dna.update_body_size()

	for(var/organ_key in list(ORGAN_SLOT_VAGINA, ORGAN_SLOT_PENIS, ORGAN_SLOT_BREASTS, ORGAN_SLOT_ANUS))
		var/obj/item/organ/genital/gent = target.getorganslot(organ_key)
		if(gent)
			gent.aroused = prefs.arousal_preview
			gent.update_sprite_suffix()

	if(prefs && length(prefs.augments))
		for(var/key in prefs.augments)
			var/datum/augment_item/aug = GLOB.augment_items[prefs.augments[key]]
			aug.apply(target, prefs = prefs)
//SKYRAT EDIT END

/datum/preference/choiced/species/compile_constant_data()
	var/list/data = list()

	for (var/species_id in (get_selectable_species() + get_customizable_races())) //SKYRAT EDIT CHANGE
		var/species_type = GLOB.species_list[species_id]
		var/datum/species/species = new species_type()

		data[species_id] = list()
		data[species_id]["name"] = species.name
		data[species_id]["desc"] = species.get_species_description()
		data[species_id]["lore"] = species.get_species_lore()
		data[species_id]["icon"] = sanitize_css_class_name(species.name)
		data[species_id]["use_skintones"] = species.use_skintones
		data[species_id]["sexes"] = species.sexes
		data[species_id]["enabled_features"] = species.get_features()
		data[species_id]["perks"] = species.get_species_perks()
		data[species_id]["diet"] =  species.get_species_diet()
		data[species_id]["veteran_only"] = species.veteran_only // SKYRAT EDIT ADDITION - Veteran races

		qdel(species)

	return data
