/obj/item/seeds/banana/spider_banana
	name = "leggy banana seed pack"
	desc = "They're seeds that grow into banana trees. However, those bananas might be alive."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-spibanana"
	species = "spibanana"
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "spibanana-grow"
	icon_dead = "spibanana-dead"
	icon_harvest = "spibanana-harvest"
	plantname = "Leggy Banana Tree"
	product = /obj/item/food/grown/banana/banana_spider_spawnable
	genes = list(/datum/plant_gene/trait/slip)

/obj/item/food/grown/banana/banana_spider_spawnable
	name = "banana spider"
	desc = "You do not know what it is, but you can bet the clown would love it."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "spibanana"
	foodtypes = GORE | MEAT | RAW | FRUIT
	var/awakening = FALSE

/obj/item/food/grown/banana/banana_spider_spawnable/attack_self(mob/user)
	if(awakening || isspaceturf(user.loc))
		return
	to_chat(user, span_notice("You decide to wake up the banana spider..."))
	awakening = TRUE
	addtimer(CALLBACK(src, PROC_REF(spawnspider)), 8 SECONDS)

/obj/item/food/grown/banana/banana_spider_spawnable/proc/spawnspider()
	if(!QDELETED(src))
		var/mob/living/basic/banana_spider/banana_spider = new(get_turf(loc))
		banana_spider.visible_message(span_notice("The banana spider chitters as it stretches its legs"))
		qdel(src)

