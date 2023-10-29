/obj/item/seeds/jurlmah
	name = "pack of jurlmah seeds"
	desc = "These seeds grow into jurlmah plants."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "jurlmah"
	species = "jurlmah"
	plantname = "Jurlmah Plant"
	product = /obj/item/food/grown/jurlmah
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "jurlmah-stage"
	growthstages = 5
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/medicine/cryoxadone = 0.1)

/obj/item/food/grown/jurlmah
	seed = /obj/item/seeds/jurlmah
	name = "jurlmah"
	desc = "It's a little piece of jurlmah."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "jurlmah"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_typepath = /datum/reagent/medicine/cryoxadone
	tastes = list("cold" = 1)
