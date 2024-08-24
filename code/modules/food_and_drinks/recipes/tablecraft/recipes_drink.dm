
// This is the home of drink related tablecrafting recipes, I have opted to only let players bottle fancy boozes to reduce the number of entries.

///Abstract types for all drink recipes that use bottles and result in another bottle, so that the message_in_a_bottle item is properly transferred.
/datum/crafting_recipe/bottled
	parts = list(/obj/item/reagent_containers/cup/glass/bottle = 1)

///////////////// Booze & Bottles ///////////////////

/datum/crafting_recipe/lizardwine
	name = "Lizard Wine"
	time = 40
	reqs = list(
		/obj/item/organ/external/tail/lizard = 1,
		/datum/reagent/consumable/ethanol = 100
	)
	blacklist = list(/obj/item/organ/external/tail/lizard/fake)
	result = /obj/item/reagent_containers/cup/glass/bottle/lizardwine
	category = CAT_DRINK

/datum/crafting_recipe/bottled/moonshinejug
	name = "Moonshine Jug"
	time = 30
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/datum/reagent/consumable/ethanol/moonshine = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/moonshine
	category = CAT_DRINK

/datum/crafting_recipe/bottled/hoochbottle
	name = "Hooch Bottle"
	time = 30
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/obj/item/storage/box/papersack = 1,
		/datum/reagent/consumable/ethanol/hooch = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/hooch
	category = CAT_DRINK

/datum/crafting_recipe/bottled/blazaambottle
	name = "Blazaam Bottle"
	time = 20
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/datum/reagent/consumable/ethanol/blazaam = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/blazaam
	category = CAT_DRINK

/datum/crafting_recipe/bottled/champagnebottle
	name = "Champagne Bottle"
	time = 30
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/datum/reagent/consumable/ethanol/champagne = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/champagne
	category = CAT_DRINK

/datum/crafting_recipe/bottled/trappistbottle
	name = "Trappist Bottle"
	time = 15
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle/small = 1,
		/datum/reagent/consumable/ethanol/trappist = 50
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/trappist
	category = CAT_DRINK

/datum/crafting_recipe/bottled/goldschlagerbottle
	name = "Goldschlager Bottle"
	time = 30
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/datum/reagent/consumable/ethanol/goldschlager = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/goldschlager
	category = CAT_DRINK

/datum/crafting_recipe/bottled/patronbottle
	name = "Patron Bottle"
	time = 30
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/datum/reagent/consumable/ethanol/patron = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/patron
	category = CAT_DRINK

////////////////////// Non-alcoholic recipes ///////////////////

/datum/crafting_recipe/bottled/holybottle
	name = "Holy Water Flask"
	time = 30
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/datum/reagent/water/holywater = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/holywater
	category = CAT_DRINK

//flask of unholy water is a beaker for some reason, I will try making it a bottle and add it here once the antag freeze is over. t. kryson

/datum/crafting_recipe/bottled/nothingbottle
	name = "Nothing Bottle"
	time = 30
	reqs = list(
		/obj/item/reagent_containers/cup/glass/bottle = 1,
		/datum/reagent/consumable/nothing = 100
	)
	result = /obj/item/reagent_containers/cup/glass/bottle/bottleofnothing
	category = CAT_DRINK

/datum/crafting_recipe/smallcarton
	name = "Small Carton"
	result = /obj/item/reagent_containers/cup/glass/bottle/juice/smallcarton
	time = 10
	reqs = list(/obj/item/stack/sheet/cardboard = 1)
	category = CAT_CONTAINERS

/datum/crafting_recipe/bottled/candycornliquor
	name = "candy corn liquor"
	result = /obj/item/reagent_containers/cup/glass/bottle/candycornliquor
	time = 30
	reqs = list(/datum/reagent/consumable/ethanol/whiskey = 100,
				/obj/item/food/candy_corn = 1,
				/obj/item/reagent_containers/cup/glass/bottle = 1)
	category = CAT_DRINK

/datum/crafting_recipe/bottled/kong
	name = "Kong"
	result = /obj/item/reagent_containers/cup/glass/bottle/kong
	time = 30
	reqs = list(/datum/reagent/consumable/ethanol/whiskey = 100,
				/obj/item/food/monkeycube = 1,
				/obj/item/reagent_containers/cup/glass/bottle = 1)
	category = CAT_DRINK

/datum/crafting_recipe/pruno
	name = "pruno mix"
	result = /obj/item/reagent_containers/cup/glass/bottle/pruno
	time = 30
	reqs = list(/obj/item/storage/bag/trash = 1,
	            /obj/item/food/breadslice/moldy = 1,
	            /obj/item/food/grown = 4,
	            /obj/item/food/candy_corn = 2,
	            /datum/reagent/water = 15)
	category = CAT_DRINK
