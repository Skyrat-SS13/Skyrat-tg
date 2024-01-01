/datum/crafting_recipe/food/haggis
	name = "Haggis"
	reqs = list(
		/obj/item/organ/internal/heart = 1,
		/obj/item/organ/internal/liver = 1,
		/obj/item/organ/internal/lungs = 1,
		/obj/item/organ/internal/stomach = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/grown/oat = 1,
		/datum/reagent/consumable/salt = 1,
	)
	result = /obj/item/food/snacks/store/bread/haggis
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/neep_tatty_haggis
	name = "Haggis With Neeps and Tatties"
	reqs = list(
		/obj/item/food/snacks/breadslice/haggis = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/redbeet = 1,
		/obj/item/food/grown/whitebeet = 1
		)
	result = /obj/item/food/snacks/neep_tatty_haggis
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/raw_battered_sausage
	name = "Raw Battered Sausage"
	reqs = list(
		/datum/reagent/consumable/ethanol/beerbatter = 5,
		/obj/item/food/raw_meatball = 1,
		/obj/item/food/meat/rawcutlet = 2
	)
	result = /obj/item/food/raw_sausage/battered
	category = CAT_MISCFOOD

/datum/crafting_recipe/food/shortbread
	name = "Shortbread"
	time = 5
	reqs = list(
		/datum/reagent/consumable/sugar = 5,
		/obj/item/food/pastrybase = 1,
		/obj/item/food/butter = 1
	)
	result = /obj/item/food/cookie/shortbread
	category = CAT_PASTRY

/datum/crafting_recipe/food/tuna
	name = "Can of Tuna"
	time = 40
	reqs = list(/obj/item/stack/sheet/iron = 1,
		/obj/item/food/fishmeat = 2
	)
	result = /obj/item/food/canned/tuna
	category = CAT_SEAFOOD

// Recipes that provide crafting instructions and don't yield any result

/datum/crafting_recipe/food/grill/battered_sausage
	reqs = list(
		/obj/item/food/raw_sausage/battered = 1
	)
	result = /obj/item/food/sausage/battered
