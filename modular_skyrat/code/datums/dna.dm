/datum/dna
	var/list/mutant_bodyparts = list()
	features = list("mcolor" = "FFF", "mcolor2" = "FFF", "mcolor3" = "FFF")
	///Body markings of the DNA's owner. This is for storing their original state for re-creating the character. They'll get changed on species mutation
	var/list/body_markings = list()

/datum/dna/proc/initialize_dna(newblood_type, skip_index = FALSE)
	if(newblood_type)
		blood_type = newblood_type
	unique_enzymes = generate_unique_enzymes()
	uni_identity = generate_uni_identity()
	if(!skip_index) //I hate this
		generate_dna_blocks()
	features = species.get_random_features()
	mutant_bodyparts = species.get_random_mutant_bodyparts(features)

/mob/living/carbon/set_species(datum/species/mrace, icon_update = TRUE, var/datum/preferences/pref_load)
	if(mrace && has_dna())
		var/datum/species/new_race
		if(ispath(mrace))
			new_race = new mrace
		else if(istype(mrace))
			new_race = mrace
		else
			return
		deathsound = new_race.deathsound
		dna.species.on_species_loss(src, new_race, pref_load)
		var/datum/species/old_species = dna.species
		dna.species = new_race
		//BODYPARTS AND FEATURES
		var/list/bodyparts_to_add
		var/list/organs_to_build = list()
		if(pref_load)
			dna.features = pref_load.features.Copy()
			dna.real_name = pref_load.real_name
			dna.mutant_bodyparts = pref_load.mutant_bodyparts.Copy()
		else
			dna.mutant_bodyparts = new_race.get_random_mutant_bodyparts(dna.features)

		bodyparts_to_add = dna.mutant_bodyparts.Copy()

		for(var/key in bodyparts_to_add)
			var/datum/sprite_accessory/SP = GLOB.sprite_accessories[key][bodyparts_to_add[key][MUTANT_INDEX_NAME]]
			if(!SP.factual)
				bodyparts_to_add -= key
				continue
			if(SP.organ_type)
				organs_to_build[key] = SP.organ_type
					//Why dont we remove the key from the list here, as it's gonna get added either way?
					//Well there's some jank that makes the organ not properly do it on initializations, which doesnt happen on organ manipulations
					//And this way there is literally no difference in practice
		dna.species.mutant_bodyparts = bodyparts_to_add.Copy()

		dna.species.on_species_gain(src, old_species, pref_load)

		//We have to build them later as they require other DNA information
		for(var/key in organs_to_build)
			var/path = organs_to_build[key]
			var/obj/item/organ/ORG = new path
			ORG.build_from_dna(dna, key)
			ORG.Insert(src, 0, FALSE)

		dna.species.mutant_bodyparts = bodyparts_to_add.Copy()
		//END OF BODYPARTS AND FEATURES
		//dna.species.on_species_gain(src, old_species, pref_load)
		if(ishuman(src))
			qdel(language_holder)
			var/species_holder = initial(mrace.species_language_holder)
			language_holder = new species_holder(src)
		update_atom_languages()	
