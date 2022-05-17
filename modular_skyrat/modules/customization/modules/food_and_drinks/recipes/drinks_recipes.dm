// Modular Booze MIXES, see the following file for the reagents: modular_skyrat\modules\customization\modules\reagents\chemistry\reagents\alcohol_reagents.dm

// ROBOT ALCOHOL PAST THIS POINT
// WOOO!

/datum/chemical_reaction/drink/synthanol
	results = list(/datum/reagent/consumable/ethanol/synthanol = 3)
	required_reagents = list(/datum/reagent/lube = 1, /datum/reagent/toxin/plasma = 1, /datum/reagent/fuel = 1)
	mix_message = "The chemicals mix to create shiny, blue substance."

/datum/chemical_reaction/drink/robottears
	results = list(/datum/reagent/consumable/ethanol/synthanol/robottears = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/fuel/oil = 1, /datum/reagent/consumable/sodawater = 1)
	mix_message = "The ingredients combine into a stiff, dark goo."

/datum/chemical_reaction/drink/trinary
	results = list(/datum/reagent/consumable/ethanol/synthanol/trinary = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/orangejuice = 1)
	mix_message = "The ingredients mix into a colorful substance."

/datum/chemical_reaction/drink/servo
	results = list(/datum/reagent/consumable/ethanol/synthanol/servo = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 2, /datum/reagent/consumable/cream = 1, /datum/reagent/consumable/hot_coco = 1)
	mix_message = "The ingredients mix into a dark brown substance."

/datum/chemical_reaction/drink/uplink
	results = list(/datum/reagent/consumable/ethanol/synthanol/uplink = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/ethanol/vodka = 1, /datum/reagent/consumable/ethanol/tequila = 1, /datum/reagent/consumable/ethanol/whiskey = 1)
	mix_message = "The chemicals mix to create a shiny, orange substance."

/datum/chemical_reaction/drink/synthncoke
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthncoke = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/space_cola = 1)
	mix_message = "The chemicals mix to create a smooth, fizzy substance."

/datum/chemical_reaction/drink/synthignon
	results = list(/datum/reagent/consumable/ethanol/synthanol/synthignon = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/synthanol = 1, /datum/reagent/consumable/ethanol/wine = 1)
	mix_message = "The chemicals mix to create a fine, red substance."

// Other Booze

/datum/chemical_reaction/drink/gunfire
	results = list(/datum/reagent/consumable/ethanol/gunfire = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 1, /datum/reagent/consumable/tea = 3)
	mix_message = "A loud popping begins to fill the air as the drink is mixed."

/datum/chemical_reaction/drink/hellfire
	results = list(/datum/reagent/consumable/ethanol/hellfire = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/ethanol/crevice_spike = 1)
	mix_message = "The liquid begins to churn as it changes to an amber orange and catches on fire."

/datum/chemical_reaction/drink/sins_delight
	results = list(/datum/reagent/consumable/ethanol/sins_delight = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/demonsblood = 2, /datum/reagent/consumable/ethanol/triple_sec = 1, /datum/reagent/consumable/ethanol/martini = 1, /datum/reagent/consumable/ethanol/changelingsting = 1)
	mix_message = "The liquid starts swirling, before forming a pink cloud that dissipates in the air."

/datum/chemical_reaction/drink/strawberry_daiquiri
	results = list(/datum/reagent/consumable/ethanol/strawberry_daiquiri = 7)
	required_reagents = list(/datum/reagent/consumable/ethanol/rum = 2, /datum/reagent/consumable/limejuice = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/berryjuice = 2, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/miami_vice
	results = list(/datum/reagent/consumable/ethanol/miami_vice = 2)
	required_reagents = list(/datum/reagent/consumable/ethanol/pina_colada = 1, /datum/reagent/consumable/ethanol/strawberry_daiquiri = 1)

/datum/chemical_reaction/drink/malibu_sunset
	results = list(/datum/reagent/consumable/ethanol/malibu_sunset = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/painkiller = 2, /datum/reagent/consumable/grenadine = 1, /datum/reagent/consumable/orangejuice = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/liz_fizz
	results = list(/datum/reagent/consumable/ethanol/liz_fizz = 5)
	required_reagents = list(/datum/reagent/consumable/triple_citrus = 3, /datum/reagent/consumable/ice = 1, /datum/reagent/consumable/cream = 1)

/datum/chemical_reaction/drink/hotlime_miami
	results = list(/datum/reagent/consumable/ethanol/hotlime_miami = 2)
	required_reagents = list(/datum/reagent/medicine/ephedrine = 1, /datum/reagent/consumable/ethanol/pina_colada = 1)

/datum/chemical_reaction/drink/coggrog
	results = list(/datum/reagent/consumable/ethanol/coggrog = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol/cognac = 1, /datum/reagent/fuel = 1, /datum/reagent/consumable/ethanol/screwdrivercocktail = 1)
	mix_message = "You hear faint sounds of gears turning as it mixes."
	mix_sound = 'sound/machines/clockcult/steam_whoosh.ogg'

/datum/chemical_reaction/drink/badtouch
	results = list(/datum/reagent/consumable/ethanol/badtouch = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/cognac = 2, /datum/reagent/consumable/limejuice = 2, /datum/reagent/consumable/orangejuice=1)

/datum/chemical_reaction/drink/marsblast
	results = list(/datum/reagent/consumable/ethanol/marsblast = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/whiskey = 3, /datum/reagent/consumable/dr_gibb = 2)

/datum/chemical_reaction/drink/mercuryblast
	results = list(/datum/reagent/consumable/ethanol/mercuryblast = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/spacemountainwind = 1, /datum/reagent/consumable/ice = 1)

/datum/chemical_reaction/drink/piledriver
	results = list(/datum/reagent/consumable/ethanol/piledriver = 6)
	required_reagents = list(/datum/reagent/consumable/ethanol/screwdrivercocktail = 1, /datum/reagent/consumable/ethanol/rum_coke = 1)

/datum/chemical_reaction/drink/zenstar
	results = list(/datum/reagent/consumable/ethanol/zenstar = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/triple_sec = 2, /datum/reagent/consumable/lemonjuice = 2, /datum/reagent/consumable/grenadine = 1)

/datum/chemical_reaction/drink/appletini
	results = list(/datum/reagent/consumable/ethanol/appletini = 5)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 3, /datum/reagent/consumable/ethanol/hcider = 1, /datum/reagent/consumable/lemonjuice = 1)

/datum/chemical_reaction/drink/quadruple_sec/cityofsin
	results = list(/datum/reagent/consumable/ethanol/quadruple_sec/cityofsin = 4)
	required_reagents = list(/datum/reagent/consumable/ethanol/vodka = 2, /datum/reagent/consumable/ethanol/champagne = 1, /datum/reagent/consumable/berryjuice = 1)

// RACE SPECIFIC DRINKS

/datum/chemical_reaction/drink/coldscales
	results = list(/datum/reagent/consumable/ethanol/coldscales = 3)
	required_reagents = list(/datum/reagent/consumable/tea = 1, /datum/reagent/toxin/slimejelly = 1,  /datum/reagent/consumable/menthol = 1)

/datum/chemical_reaction/drink/oil_drum
	results = list(/datum/reagent/consumable/ethanol/oil_drum = 3)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1,  /datum/reagent/fuel/oil = 1, /datum/reagent/consumable/ethanol/champagne = 12)

/datum/chemical_reaction/drink/nord_king
	results = list(/datum/reagent/consumable/ethanol/nord_king = 10)
	required_reagents = list(/datum/reagent/consumable/ethanol = 5,  /datum/reagent/consumable/honey = 1, /datum/reagent/consumable/ethanol/red_mead = 10)

/datum/chemical_reaction/drink/velvet_kiss
	results = list(/datum/reagent/consumable/ethanol/velvet_kiss = 15) //Limited races use this
	required_reagents = list(/datum/reagent/blood = 5,  /datum/reagent/consumable/tea = 1, /datum/reagent/consumable/ethanol/wine = 10)

/datum/chemical_reaction/drink/abduction_fruit
	results = list(/datum/reagent/consumable/ethanol/abduction_fruit = 3)
	required_reagents = list(/datum/reagent/consumable/limejuice = 10,  /datum/reagent/consumable/berryjuice = 5, /datum/reagent/consumable/watermelonjuice = 10)

/datum/chemical_reaction/drink/bug_zapper
	results = list(/datum/reagent/consumable/ethanol/bug_zapper = 20) //Harder to make
	required_reagents = list(/datum/reagent/consumable/lemonjuice = 10,  /datum/reagent/teslium = 1, /datum/reagent/copper = 10)

/datum/chemical_reaction/drink/mush_crush
	results = list(/datum/reagent/consumable/ethanol/mush_crush = 10)
	required_reagents = list(/datum/reagent/iron = 5,  /datum/reagent/ash = 5, /datum/reagent/toxin/coffeepowder = 10)

/datum/chemical_reaction/drink/hollow_bone
	results = list(/datum/reagent/consumable/ethanol/hollow_bone = 10)
	required_reagents = list(/datum/reagent/toxin/bonehurtingjuice = 10,  /datum/reagent/consumable/soymilk = 15)//Skeletons love milk, and will find soymilk disgusting!

/datum/chemical_reaction/drink/jell_wyrm
	results = list(/datum/reagent/consumable/ethanol/jell_wyrm = 2)
	required_reagents = list(/datum/reagent/toxin/slimejelly = 1,  /datum/reagent/toxin/carpotoxin = 1, /datum/reagent/carbondioxide = 5)
	required_temp = 333 // (59.85'C)

/datum/chemical_reaction/drink/laval_spit
	results = list(/datum/reagent/consumable/ethanol/laval_spit = 20) //Limited use
	required_reagents = list(/datum/reagent/iron = 5,  /datum/reagent/consumable/ethanol/mauna_loa = 10, /datum/reagent/sulfur = 5)
	required_temp = 900 // (626.85'C)

/datum/chemical_reaction/drink/frisky_kitty
	results = list(/datum/reagent/consumable/ethanol/frisky_kitty = 2)
	required_reagents = list(/datum/reagent/consumable/catnip_tea = 1,  /datum/reagent/consumable/milk = 1)
	required_temp = 296 //Just above room temp (22.85'C)

// Non-Booze, see modular_skyrat\modules\customization\modules\reagents\chemistry\reagents\drink_reagents.dm

/datum/chemical_reaction/drink/pinkmilk
	results = list(/datum/reagent/consumable/pinkmilk = 2)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/milk = 1)

/datum/chemical_reaction/drink/pinktea
	results = list(/datum/reagent/consumable/pinktea = 5)
	required_reagents = list(/datum/reagent/consumable/berryjuice = 1, /datum/reagent/consumable/tea/arnold_palmer = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/drink/catnip_tea
	results = list(/datum/reagent/consumable/catnip_tea = 10)
	required_reagents = list(/datum/reagent/consumable/tea = 5, /datum/reagent/pax/catnip = 2)

/datum/chemical_reaction/drink/beerbatter
	results = list(/datum/reagent/consumable/beerbatter = 4)
	required_reagents = list(/datum/reagent/consumable/cooking_oil = 1, /datum/reagent/consumable/ethanol/beer = 1, /datum/reagent/consumable/flour = 1)
	mix_message = "Sizzling and cracking is heard as you beat the mixture into submission."



