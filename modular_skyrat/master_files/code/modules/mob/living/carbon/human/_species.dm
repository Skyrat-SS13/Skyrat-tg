/datum/species
	var/remove_features = FALSE

/datum/species/abductor
	remove_features = TRUE

/datum/species/skeleton
	remove_features = TRUE

/datum/species/monkey
	remove_features = TRUE // No more monkeys with tits, sorry

/datum/species/on_species_gain(mob/living/carbon/human/human_who_gained_species, datum/species/old_species, pref_load)
	if(remove_features)
		human_who_gained_species.dna.mutant_bodyparts = list()
		human_who_gained_species.dna.body_markings = list()
	. = ..()
