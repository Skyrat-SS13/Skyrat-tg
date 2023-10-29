/obj/item/seeds/vaporsac
	name = "pack of vaporsac seeds"
	desc = "These seeds grow into vaporsac plants."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "vaporsac"
	species = "vaporsac"
	plantname = "Vaporsac Plant"
	product = /obj/item/food/grown/vaporsac
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "vaporsac-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/nitrous_oxide = 0.1)

/obj/item/food/grown/vaporsac
	seed = /obj/item/seeds/vaporsac
	name = "vaporsac"
	desc = "It's a little piece of vaporsac."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "vaporsac"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_typepath = /datum/reagent/nitrous_oxide
	tastes = list("sleep" = 1)
