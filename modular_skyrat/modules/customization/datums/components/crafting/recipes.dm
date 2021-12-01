/datum/crafting_recipe/food/haggis
	name = "Haggis"
	reqs = list(
		/obj/item/organ/heart = 1,
		/obj/item/organ/liver = 1,
		/obj/item/organ/lungs = 1,
		/obj/item/organ/stomach = 1,
		/obj/item/food/grown/onion = 1,
		/obj/item/food/soup/oatmeal = 1,
		/datum/reagent/consumable/salt = 1,
	)
	result = /obj/item/food/snacks/store/bread/haggis
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/neep_tatty_haggis
	name = "Haggis With Neeps and Tatties"
	reqs = list(
		/obj/item/food/snacks/breadslice/haggis = 1,
		/obj/item/food/grown/potato = 1,
		/obj/item/food/grown/redbeet = 1,
		/obj/item/food/grown/whitebeet = 1
		)
	result = /obj/item/food/snacks/neep_tatty_haggis
	subcategory = CAT_MISCFOOD

/datum/crafting_recipe/food/batter
	name = "Battered Sausage"
	reqs = list(
		/datum/reagent/consumable/beerbatter = 5,
		/obj/item/food/sausage = 1,
	)
	result = /obj/item/food/sausage/battered
	subcategory = CAT_MISCFOOD
