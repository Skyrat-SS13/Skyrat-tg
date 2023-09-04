/obj/item/seeds/shand
	name = "pack of shand seeds"
	desc = "These seeds grow into shand plants."
	icon = 'modular_skyrat/modules/xenoarch/icons/seeds.dmi'
	icon_state = "shand"
	species = "shand"
	plantname = "Shand Plant"
	product = /obj/item/food/grown/shand
	lifespan = 55
	endurance = 35
	yield = 5
	growing_icon = 'modular_skyrat/modules/xenoarch/icons/growing.dmi'
	icon_grow = "shand-stage"
	growthstages = 3
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/pax = 0.1)

/obj/item/food/grown/shand
	seed = /obj/item/seeds/shand
	name = "shand"
	desc = "It's a little piece of shand."
	icon = 'modular_skyrat/modules/xenoarch/icons/harvest.dmi'
	icon_state = "shand"
	filling_color = "#FF4500"
	bite_consumption_mod = 0.5
	foodtypes = FRUIT
	juice_typepath = /datum/reagent/pax
	tastes = list("peace" = 1)
