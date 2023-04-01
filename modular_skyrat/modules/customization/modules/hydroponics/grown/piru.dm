// Piru
/obj/item/seeds/piru
	name = "pack of piru starters"
	desc = "This bacterial colony forms into piru fronds."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-piru"
	species = "piru"
	plantname = "Piru Colony"
	product = /obj/item/food/grown/piru
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "piru-grow"
	icon_dead = "piru-dead"
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/piru_flour = 0.25)

/obj/item/food/grown/piru
	seed = /obj/item/seeds/piru
	name = "piru frond"
	desc = "A delicate frond of piru, resembling strands of silk more than leaves. grinds down into piru flour used in teshari cuisine."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "piru"
	foodtypes = VEGETABLES
	grind_results = list(/datum/reagent/consumable/piru_flour = 0)
	tastes = list("chalky dryness" = 1)
