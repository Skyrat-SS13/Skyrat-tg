// Peach
/obj/item/seeds/peach
	name = "pack of peach seeds"
	desc = "These seeds grow into peach trees."
	icon = 'modular_skyrat/modules/modular_items/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-peach"
	species = "peach"
	plantname = "Peach Tree"
	product = /obj/item/food/grown/peach
	lifespan = 65
	endurance = 40
	yield = 3
	growing_icon = 'modular_skyrat/modules/modular_items/icons/obj/hydroponics/growing_fruits.dmi'
	icon_grow = "peach-grow"
	icon_dead = "peach-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/peach
	seed = /obj/item/seeds/peach
	name = "peach"
	desc = "It's fuzzy!"
	icon = 'modular_skyrat/modules/modular_items/icons/obj/hydroponics/harvest.dmi'
	icon_state = "peach"
	filling_color = "#FF4500"
	bite_consumption_mod = 2
	foodtype = FRUIT
	juice_results = list(/datum/reagent/consumable/peachjuice = 0)
	tastes = list("peach" = 1)
