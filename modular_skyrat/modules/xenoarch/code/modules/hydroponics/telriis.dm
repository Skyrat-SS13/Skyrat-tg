/obj/item/seeds/telriis
	name = "pack of telriis seeds"
	desc = "These seeds grow into telriis plants."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "telriis"
	species = "telriis"
	plantname = "Telriis Plant"
	product = /obj/item/food/grown/telriis
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "telriis-stage"
	growthstages = 4
	plant_icon_offset = 7
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/medicine/higadrite = 0.1)

/obj/item/food/grown/telriis
	seed = /obj/item/seeds/telriis
	name = "telriis"
	desc = "It's a little piece of telriis."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "telriis"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_typepath = /datum/reagent/medicine/higadrite
	tastes = list("liver" = 1)
