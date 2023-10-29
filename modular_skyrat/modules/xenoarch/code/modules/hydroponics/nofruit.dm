/obj/item/seeds/nofruit
	name = "pack of nofruit seeds"
	desc = "These seeds grow into nofruit plants."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "nofruit"
	species = "nofruit"
	plantname = "Nofruit Plant"
	product = /obj/item/food/grown/nofruit
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "nofruit-stage"
	growthstages = 4
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nothing = 0.1, /datum/reagent/consumable/laughter = 0.1)

/obj/item/food/grown/nofruit
	seed = /obj/item/seeds/nofruit
	name = "nofruit"
	desc = "It's a little piece of nofruit."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "nofruit"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_typepath = /datum/reagent/consumable/nothing
	tastes = list("entertainment" = 1)
