/obj/item/food/bowled
	w_class = WEIGHT_CLASS_NORMAL
	icon = 'icons/obj/food/soupsalad.dmi'
	bite_consumption = 5
	max_volume = 80
	foodtypes = NONE
	eatverbs = list("喝了一口", "吸了一口", "吃了一口", "咽了一口")
	venue_value = FOOD_PRICE_CHEAP

/obj/item/food/bowled/make_germ_sensitive(mapload)
	return // It's in a bowl

/obj/item/food/bowled/wish
	name = "许愿汤"
	desc = "我许愿这是一碗汤."
	icon_state = "wishsoup"
	food_reagents = list(/datum/reagent/water = 10)
	tastes = list("愿望" = 1)

/obj/item/food/bowled/wish/Initialize(mapload)
	. = ..()
	if(prob(25))
		desc = "美梦成真!"
		reagents.add_reagent(/datum/reagent/consumable/nutriment, 9)
		reagents.add_reagent(/datum/reagent/consumable/nutriment/vitamin, 1)

/obj/item/food/bowled/mammi
	name = "婴儿食品糊"
	desc = "一碗糊状的面包和牛奶."
	icon_state = "mammi"
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 11,
		/datum/reagent/consumable/nutriment/vitamin = 2,
	)
	foodtypes = SUGAR | DAIRY
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bowled/spacylibertyduff
	name = "宇宙果冻"
	desc = "from Alfred Hubbard's cookbook."
	icon_state = "spacylibertyduff"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 6,
		/datum/reagent/drug/mushroomhallucinogen = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("果酱" = 1, "蘑菇" = 1)
	foodtypes = VEGETABLES
	crafting_complexity = FOOD_COMPLEXITY_2

/obj/item/food/bowled/amanitajelly
	name = "鹅膏菌果冻"
	desc = "看起来很有毒。"
	icon_state = "amanitajelly"
	bite_consumption = 3
	food_reagents = list(
		/datum/reagent/consumable/nutriment = 7,
		/datum/reagent/drug/mushroomhallucinogen = 3,
		/datum/reagent/toxin/amatoxin = 6,
		/datum/reagent/consumable/nutriment/vitamin = 5,
	)
	tastes = list("果酱" = 1, "蘑菇" = 1)
	foodtypes = VEGETABLES | TOXIC
	crafting_complexity = FOOD_COMPLEXITY_2
