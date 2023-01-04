// Kiri
/obj/item/seeds/kiri
	name = "pack of kiri starters"
	desc = "This bacterial colony forms into kiri fruits."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-kiri"
	species = "kiri"
	plantname = "Kiri Colony"
	product = /obj/item/food/grown/kiri
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "kiri-grow"
	icon_dead = "kiri-dead"
	lifespan = 60
	endurance = 50
	growthstages = 4
	reagents_add = list(/datum/reagent/consumable/kiri_jelly = 0.04, /datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/food/grown/kiri
	seed = /obj/item/seeds/kiri
	name = "kiri fruit"
	desc = "A bizarre egg-shaped fruit, striped with a vivid pink and yellow color. It feels somewhat firm, but the entire thing is edible. Contains an ultra-sweet jelly typically used in teshari cuisine, or it can be baked by itself for a delightful treat."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "kiri"
	foodtypes = FRUIT | SUGAR
	grind_results = list(/datum/reagent/consumable/kiri_jelly = 0.1)
	distill_reagent = /datum/reagent/consumable/ethanol/shakiri
	tastes = list("ultra-sweet jelly" = 1)

/obj/item/food/grown/kiri/MakeBakeable()
	AddComponent(/datum/component/bakeable, /obj/item/food/baked_kiri, rand(15 SECONDS, 25 SECONDS), TRUE, TRUE)
