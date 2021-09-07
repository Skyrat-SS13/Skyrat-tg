/obj/item/seeds/thaadra
	name = "pack of thaadra seeds"
	desc = "These seeds grow into thaadra plants."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "thaadra"
	species = "thaadra"
	plantname = "Thaadra Plant"
	product = /obj/item/food/grown/thaadra
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "thaadra-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/silver = 0.1)

/obj/item/food/grown/thaadra
	seed = /obj/item/seeds/thaadra
	name = "thaadra"
	desc = "It's a little piece of thaadra."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "thaadra"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_results = list(/datum/reagent/silver = 0)
	tastes = list("silver" = 1)
