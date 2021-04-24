/datum/chemical_reaction/pcp
	results = list(/datum/reagent/drug/pcp = 1)
	required_reagents = list(/datum/reagent/pcc = 1, /datum/reagent/iron = 2) //iron is just a replacement for magnesium
	required_catalysts = list(/datum/reagent/toxin/plasma = 5)
	reaction_tags = REACTION_TAG_EASY | REACTION_TAG_CHEMICAL

/datum/chemical_reaction/pcc
	results = list(/datum/reagent/pcc = 1)
	required_reagents = list(/datum/reagent/sodium = 1, /datum/reagent/medicine/c2/multiver = 2)
	optimal_ph_min = 1
	optimal_ph_max = 6
	H_ion_release = 0.04
	purity_min = 0.5
	required_temp = 250
	reaction_tags = REACTION_TAG_CHEMICAL