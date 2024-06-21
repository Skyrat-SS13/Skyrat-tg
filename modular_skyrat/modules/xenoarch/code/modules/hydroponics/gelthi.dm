/obj/item/seeds/gelthi
	name = "pack of gelthi seeds"
	desc = "These seeds grow into gelthi plants. Lauded by chefs for its unique ability to produce honey, and often hoarded for this very reason."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "gelthi"
	species = "gelthi"
	plantname = "Gelthi Plant"
	product = /obj/item/food/grown/gelthi
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "gelthi-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest, /datum/plant_gene/trait/squash)
	reagents_add = list(/datum/reagent/consumable/sprinkles = 0.1, /datum/reagent/consumable/astrotame = 0.1, /datum/reagent/consumable/honey = 0.2)

/obj/item/food/grown/gelthi
	seed = /obj/item/seeds/gelthi
	name = "gelthi"
	desc = "A cluster of gelthi pods. Each pod contains a different sweetener, and the pods can be juiced into raw sugar."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "gelthi"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_typepath = /datum/reagent/consumable/sugar
	tastes = list("overpowering sweetness" = 1)
