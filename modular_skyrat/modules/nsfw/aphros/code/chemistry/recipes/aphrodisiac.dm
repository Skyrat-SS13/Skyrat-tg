/datum/chemical_reaction/aphro
	results = list(/datum/reagent/drug/aphrodisiac = 6)
	required_reagents = list(/datum/reagent/carbon = 2, /datum/reagent/hydrogen = 2, /datum/reagent/oxygen = 2, /datum/reagent/water = 1)
	required_temp = 400
	mix_message = "The mixture boils off a pink vapor..."//The water boils off, leaving the crocin

/datum/chemical_reaction/aphroplus
	results = list(/datum/reagent/drug/aphrodisiacplus = 1)
	required_reagents = list(/datum/reagent/drug/aphrodisiac = 6, /datum/reagent/phenol = 1)
	required_temp = 400
	mix_message = "The mixture rapidly condenses and darkens in color..."

