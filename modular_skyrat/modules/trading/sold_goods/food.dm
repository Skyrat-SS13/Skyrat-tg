// Alphabetized by trader. Any trader can use these datums, but this keeps things a bit more organized.

/////////Chinese Restaurant/////////

/datum/sold_goods/meatkebab
	path = /obj/item/food/kebab/monkey

/datum/sold_goods/monkeysoup
	path = /obj/item/food/soup/monkeysdelight

/datum/sold_goods/ricepudding
	path = /obj/item/food/salad/ricepudding

/datum/sold_goods/cupramen
	path = /obj/item/reagent_containers/food/drinks/dry_ramen

/////////Farming Apprentice/////////

/datum/sold_goods/cow
	cost = 350
	path = /mob/living/simple_animal/cow

/datum/sold_goods/goat
	cost = 220
	path = /mob/living/simple_animal/hostile/retaliate/goat

/datum/sold_goods/chicken
	cost = 100
	path = /mob/living/simple_animal/chick

/datum/sold_goods/wheat
	cost = 20
	path = /obj/item/food/grown/wheat

/datum/sold_goods/pumpkin
	cost = 40
	path = /obj/item/food/grown/pumpkin

/datum/sold_goods/corn
	cost = 35
	path = /obj/item/food/grown/corn

/////////Pizza Shop Employee/////////

/datum/sold_goods/pizzabox
	cost = 200
	trading_types = list(/obj/item/pizzabox/margherita = TRADER_THIS_TYPE,
						/obj/item/pizzabox/vegetable = TRADER_THIS_TYPE,
						/obj/item/pizzabox/mushroom = TRADER_THIS_TYPE,
						/obj/item/pizzabox/meat = TRADER_THIS_TYPE,
						/obj/item/pizzabox/pineapple = TRADER_THIS_TYPE)

/datum/sold_goods/pizzabox/two
/datum/sold_goods/pizzabox/three
/datum/sold_goods/pizzabox/four
