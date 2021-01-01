// Modular Booze MIXES, see the following file for the reagents: modular_skyrat\modules\customization\modules\reagents\chemistry\reagents\alcohol_reagents.dm

// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/chemical_reaction/synthanol
	results = list(/datum/reagent/consumable/ethanol/synthanol = 3)
	required_reagents = list(/datum/reagent/lube = 1, /datum/reagent/toxin/plasma = 1, /datum/reagent/fuel = 1)
	mix_message = "The chemicals mix to create shiny, blue substance."

/datum/chemical_reaction/robottears
	results = list(/datum/reagent/consumable/ethanol/synthanol/robottears = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/fuel/oil = 1, /datum/reagent/consumable/sodawater = 1)
	mix_message = "The ingredients combine into a stiff, dark goo."

/datum/chemical_reaction/trinary
	results = list(/datum/reagent/consumable/ethanol/synthanol/trinary = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/orangejuice = 1)
	mix_message = "The ingredients mix into a colorful substance."

/datum/chemical_reaction/servo
	results = list(/datum/reagent/consumable/ethanol/synthanol/servo = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 2, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/hot_coco = 1)
	mix_message = "The ingredients mix into a dark brown substance."

/datum/chemical_reaction/uplink
	results = list(/datum/reagent/consumable/ethanol/synthanol/uplink = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/tequila = 1, /datum/reagent/consumable/ethanol/whiskey = 1)
	mix_message = "The chemicals mix to create a shiny, orange substance."

/datum/chemical_reaction/synthncoke
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthncoke = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/space_cola = 1)
	mix_message = "The chemicals mix to create a smooth, fizzy substance."

/datum/chemical_reaction/synthignon
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthignon = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/wine = 1)
	mix_message = "The chemicals mix to create a fine, red substance." 

// Other Booze

/datum/chemical_reaction/gunfire
	results = list(/datum/reagent/consumable/ethanol/gunfire = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/tea = 3)
	mix_message = "A loud popping begins to fill the air as the drink is mixed."

/datum/chemical_reaction/hellfire
	results = list(/datum/reagent/consumable/ethanol/hellfire = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/ethanol/crevice_spike = 1)
	mix_message = "The liquid begins to churn as it changes to an amber orange and catches on fire."

/datum/chemical_reaction/sins_delight
	results = list(/datum/reagent/consumable/ethanol/sins_delight = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/demonsblood = 2, /datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/ethanol/martini = 1, /datum/reagent/consumable/ethanol/changelingsting = 1)
	mix_message = "The liquid starts swirling, before forming a pink cloud that dissipates in the air."

/datum/chemical_reaction/strawberry_daiquiri
	results = list(/datum/reagent/consumable/ethanol/strawberry_daiquiri = 7)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/berryjuice = 2, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/miami_vice
	results = list(/datum/reagent/consumable/ethanol/miami_vice = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/pina_colada = 1, /datum/reagent/consumable/ethanol/strawberry_daiquiri = 1)

/datum/chemical_reaction/malibu_sunset
	results = list(/datum/reagent/consumable/ethanol/malibu_sunset = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/painkiller = 2, /datum/reagent/consumable/grenadine = 1, /datum/reagent/consumable/orangejuice = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/liz_fizz
	results = list(/datum/reagent/consumable/ethanol/liz_fizz = 5)
	required_reagents = list(/datum/reagent/consumable/triple_citrus = 3, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/hotlime_miami
	results = list(/datum/reagent/consumable/ethanol/hotlime_miami = 2)
	required_reagents = list(/datum/reagent/medicine/ephedrine = 1, /datum/reagent/consumable/ethanol/pina_colada = 1)

// Non-Booze, see modular_skyrat\modules\customization\modules\reagents\chemistry\reagents\drink_reagents.dm

/datum/chemical_reaction/pinkmilk
	results = list(/datum/reagent/consumable/pinkmilk = 2)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/milk = 1)

/datum/chemical_reaction/pinktea
	results = list(/datum/reagent/consumable/pinktea = 5)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/tea/arnold_palmer = 1, /datum/reagent/consumable/sugar = 1)
