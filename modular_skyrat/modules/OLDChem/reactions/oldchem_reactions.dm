/datum/chemical_reaction/bicaridine
	results = list(/datum/reagent/medicine/bicaridine = 3)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/oxygen = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/kelotane
	results = list(/datum/reagent/medicine/kelotane = 2)
	required_reagents = list(/datum/reagent/carbon = 1, /datum/reagent/silicon = 1)

/datum/chemical_reaction/antitoxin
	results = list(/datum/reagent/medicine/antitoxin = 3)
	required_reagents = list(/datum/reagent/nitrogen = 1, /datum/reagent/silicon = 1, /datum/reagent/potassium = 1)

/datum/chemical_reaction/tricordrazine
	results = list(/datum/reagent/medicine/tricordrazine = 3)
	required_reagents = list(/datum/reagent/medicine/bicaridine = 1, /datum/reagent/medicine/kelotane = 1, /datum/reagent/medicine/antitoxin = 1)

/datum/chemical_reaction/synth_blood
	results = list(/datum/reagent/blood/synthetics = 3)
	required_reagents = list(/datum/reagent/medicine/salglu_solution = 1, /datum/reagent/iron = 1, /datum/reagent/stable_plasma = 1)
	mix_message = "The mixture congeals and gives off a faint copper scent."
	required_temp = 350

/datum/chemical_reaction/preservahyde
	results = list(/datum/reagent/medicine/preservahyde = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/toxin/formaldehyde = 1, /datum/reagent/bromine = 1)
