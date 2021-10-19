/obj/item/seeds/banana/spider_banana
	name = "pack of leggy banana seeds"
	desc = "They're seeds that grow into banana trees. However, those bananas might be alive."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-spibanana"
	species = "spibanana"
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "spibanana-grow"
	icon_dead = "spibanana-dead"
	plantname = "Leggy Banana Tree"
	product = /obj/item/food/grown/banana/banana_spider_spawnable
	genes = list(/datum/plant_gene/trait/slip)

/obj/item/food/grown/banana/banana_spider_spawnable
	name = "banana spider"
	desc = "You do not know what it is, but you can bet the clown would love it."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "spibanana"
	foodtypes = GROSS | MEAT | RAW | FRUIT
	var/awakening = 0

/obj/item/food/grown/banana/banana_spider_spawnable/attack_self(mob/user)
	if(awakening || isspaceturf(user.loc))
		return
	to_chat(user, "<span class='notice'>You decide to wake up the banana spider...</span>")
	awakening = 1

	spawn(30)
		if(!QDELETED(src))
			var/mob/living/simple_animal/banana_spider/S = new /mob/living/simple_animal/banana_spider(get_turf(src.loc))
			S.visible_message("<span class='notice'>The banana spider chitters as it stretches its legs.</span>")
			qdel(src)