/obj/item/seeds/banana/exotic_banana
	name = "pack of exotic banana seeds"
	desc = "They're seeds that grow into banana trees. However, those bananas might be alive."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed_spibanana"
	species = "spiderbanana"
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "spibanana-grow"
	plantname = "Spi Banana Tree"
	product = /obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable
	mutatelist = list()
	genes = list(/datum/plant_gene/trait/slip)

/obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable
	seed = /obj/item/seeds/banana/exotic_banana
	name = "banana spider"
	desc = "You do not know what it is, but you can bet the clown would love it."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "spibanana"
	list_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	foodtype = GROSS | MEAT | RAW | FRUIT
	grind_results = list(/datum/reagent/blood = 20, /datum/reagent/liquidgibs = 5)
	var/awakening = 0

/obj/item/reagent_containers/food/snacks/grown/banana/banana_spider_spawnable/attack_self(mob/user)
	if(awakening || isspaceturf(user.loc))
		return
	to_chat(user, "<span class='notice'>You decide to wake up the banana spider...</span>")
	awakening = 1

	spawn(30)
		if(!QDELETED(src))
			var/mob/living/simple_animal/banana_spider/S = new /mob/living/simple_animal/banana_spider(get_turf(src.loc))
			S.speed += round(10 / max(seed.potency, 1), 1)
			S.visible_message("<span class='notice'>The banana spider chitters as it stretches its legs.</span>")
			qdel(src)