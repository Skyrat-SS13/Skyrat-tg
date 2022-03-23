// Alphabetized by trader. Any trader can use these datums, but this keeps things a bit more organized.

/////////Artifact Shop Employee/////////

/datum/bought_goods/fossil
	name = "fossils"
	cost = 300
	trading_types = list(/obj/item/fossil = TRADER_THIS_TYPE)
	stock = 5

/datum/bought_goods/excavation_junk
	name = "ancient artifacts"
	cost = 250
	trading_types = list(/obj/item/excavation_junk = TRADER_THIS_TYPE)
	stock = 5

/datum/bought_goods/excavation_artifact
	name = "unknown artifacts"
	cost = 350
	trading_types = list(/obj/item/unknown_artifact = TRADER_THIS_TYPE)
	stock = 5

/datum/bought_goods/anomalous_crystal
	name = "anomalous crystals"
	cost = 700
	trading_types = list(/obj/item/anomalous_sliver/crystal = TRADER_THIS_TYPE)
	stock = 4

/////////Medical Supplier/////////

/datum/bought_goods/lungs
	name = "lungs"
	cost = 300
	stock = 5
	trading_types = list(/obj/item/organ/lungs = TRADER_THIS_TYPE)

/datum/bought_goods/heart
	name = "hearts"
	cost = 300
	stock = 5
	trading_types = list(/obj/item/organ/heart = TRADER_THIS_TYPE)

/datum/bought_goods/liver
	name = "livers"
	cost = 300
	stock = 5
	trading_types = list(/obj/item/organ/liver = TRADER_THIS_TYPE)

/datum/bought_goods/reagent/meth
	cost = 40
	reagent_type = /datum/reagent/drug/methamphetamine
	stock = 50

/////////Pet Shop Employee/////////

/datum/bought_goods/pets
	name = "pets"
	cost = 150
	trading_types = list(/mob/living/simple_animal/pet = TRADER_SUBTYPES)

/////////Rock'n'Drill Mining Inc/////////

/datum/bought_goods/stack/iron
	name = "iron ore"
	cost = 10
	trading_types = list(/obj/item/stack/ore/iron = TRADER_THIS_TYPE)

/datum/bought_goods/stack/silver
	name = "silver ore"
	cost = 30
	trading_types = list(/obj/item/stack/ore/silver = TRADER_THIS_TYPE)

/datum/bought_goods/stack/gold
	name = "gold ore"
	cost = 60
	trading_types = list(/obj/item/stack/ore/gold = TRADER_THIS_TYPE)

/datum/bought_goods/stack/uranium
	name = "uranium ore"
	cost = 100
	trading_types = list(/obj/item/stack/ore/uranium = TRADER_THIS_TYPE)

/datum/bought_goods/stack/plasma
	name = "plasma ore"
	cost = 100
	trading_types = list(/obj/item/stack/ore/plasma = TRADER_THIS_TYPE)

/datum/bought_goods/stack/diamond
	name = "diamond ore"
	cost = 200
	trading_types = list(/obj/item/stack/ore/diamond = TRADER_THIS_TYPE)

/////////Toy Shop Employee/////////

/datum/bought_goods/toys
	name = "toys"
	cost = 100
	trading_types = list(/obj/item/toy = TRADER_SUBTYPES,
						/obj/item/toy/figure = TRADER_BLACKLIST_TYPES,
						/obj/item/toy/cards/singlecard = TRADER_BLACKLIST_TYPES)

/datum/bought_goods/toy_figures
	name = "toy figures"
	cost = 150
	trading_types = list(/obj/item/toy/figure = TRADER_SUBTYPES)

/////////Xenolife Collector/////////

/datum/bought_goods/space_carp
	name = "space carps"
	cost = 400
	trading_types = list(/mob/living/simple_animal/hostile/carp = TRADER_TYPES)

/datum/bought_goods/goliath
	name = "goliaths"
	cost = 500
	trading_types = list(/mob/living/simple_animal/hostile/asteroid/goliath = TRADER_TYPES)
