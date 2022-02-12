//Realistically, vinegar is made from the aging of bacteria inside alcohol, but this is cool instead
//Real cooks that make "homemade" vinegar use wine. Sometimes it takes months, but efficient manufacturers wait only a week
/datum/chemical_reaction/food/vinegar
	required_catalysts = list(/datum/reagent/toxin/acid = 1)
	required_reagents = list(/datum/reagent/consumable/ethanol/wine = 1)
	results = list(/datum/reagent/consumable/vinegar = 1)

/datum/chemical_reaction/food/vinegar/two
	required_catalysts = list(/datum/reagent/consumable/mold = 1) //Mold can easily come from bad food

//Yoghurt is another one that uses bacteria, except this is heated.
//To make this at least slightly realistic, cream and milk is mixed together at 80 celcius
/datum/chemical_reaction/food/yoghurt
	required_catalysts = list(/datum/reagent/consumable/mold = 1)
	required_reagents = list(/datum/reagent/consumable/cream = 1, /datum/reagent/consumable/milk = 1)
	results = list(/datum/reagent/consumable/yoghurt = 2)
	required_temp = 350

/datum/chemical_reaction/food/quality_oil
	required_catalysts = list(/datum/reagent/consumable/korta_nectar = 1)
	required_reagents = list(/datum/reagent/consumable/cornoil = 1)
	results = list(/datum/reagent/consumable/quality_oil = 1)

/datum/chemical_reaction/food/quality_oil/two
	required_catalysts = list(/datum/reagent/consumable/enzyme = 1)
	required_reagents = list(/datum/reagent/consumable/korta_nectar = 1)

