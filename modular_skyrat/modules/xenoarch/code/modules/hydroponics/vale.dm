/obj/item/seeds/vale
	name = "pack of vale seeds"
	desc = "These seeds grow into vale plants."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "vale"
	species = "vale"
	plantname = "Vale Plant"
	product = /obj/item/food/grown/vale
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "vale-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/medicine/neurine = 0.1)

/obj/item/food/grown/vale
	seed = /obj/item/seeds/vale
	name = "vale"
	desc = "It's a little piece of vale."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "vale"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_results = list(/datum/reagent/medicine/neurine = 0)
	tastes = list("medicine" = 1)
