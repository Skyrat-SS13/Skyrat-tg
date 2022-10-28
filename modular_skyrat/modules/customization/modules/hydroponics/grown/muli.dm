// Muli
/obj/item/seeds/muli
	name = "pack of muli starters"
	desc = "This bacterial colony forms into muli pods."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-muli"
	species = "muli"
	plantname = "Muli Colony"
	product = /obj/item/food/grown/muli
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "muli-grow"
	icon_dead = "muli-dead"
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/muli_juice = 0.1, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/muli
	seed = /obj/item/seeds/muli
	name = "muli pod"
	desc = "A soft, oval-shaped pod. Contains a minty pale-blue juice used for many applications in teshari cuisine."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "muli"
	foodtypes = VEGETABLES
	juice_results = list(/datum/reagent/consumable/muli_juice = 0.3)
	grind_results = list(/datum/reagent/consumable/muli_juice = 0.1)
	tastes = list("mint and savory sweetness" = 1)

/obj/item/food/grown/muli/MakeBakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/baked_muli, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)
