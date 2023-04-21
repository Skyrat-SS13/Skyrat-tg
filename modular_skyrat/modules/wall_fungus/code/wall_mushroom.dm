// WALL EATING FUNGUS!!!!
/obj/item/seeds/wall_mushroom
	name = "pack of wall destroying mycelium"
	desc = "This mycelium grows into something devastating."
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-wallmushroom"
	species = "angel"
	plantname = "Wall Mushroom"
	product = /obj/item/food/grown/mushroom/wall
	lifespan = 50
	endurance = 35
	maturation = 12
	production = 5
	yield = 2
	potency = 35
	growthstages = 3
	genes = list(/datum/plant_gene/trait/plant_type/fungal_metabolism)
	growing_icon = 'modular_skyrat/master_files/icons/obj/hydroponics/growing.dmi'
	icon_grow = "wallmushroom-grow"
	icon_dead = "wallmushroom-dead"
	reagents_add = list(/datum/reagent/drug/mushroomhallucinogen = 0.04, /datum/reagent/toxin/amatoxin = 0.1, /datum/reagent/consumable/nutriment = 0.1)
	rarity = 30
	graft_gene = /datum/plant_gene/trait/plant_type/fungal_metabolism

/obj/item/food/grown/mushroom/wall
	seed = /obj/item/seeds/wall_mushroom
	name = "wall mushroom"
	desc = "<I>Wallosia Virosa</I>: A wall eating mushroom!"
	icon = 'modular_skyrat/master_files/icons/obj/hydroponics/harvest.dmi'
	icon_state = "wallmushroom"
	wine_power = 60



/obj/item/food/grown/mushroom/wall/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	if(!iswallturf(target))
		return ..()
	var/turf/closed/wall/target_wall = target
	if(target_wall.GetComponent(/datum/component/wall_fungus))
		target_wall.balloon_alert(user, "already infested!")
		return ..()
	target_wall.balloon_alert(user, "planting...")
	if(do_after(user, 5 SECONDS, target_wall))
		target_wall.AddComponent(/datum/component/wall_fungus)
		target_wall.balloon_alert(user, "planted!")
		user.log_message("planted [name] on [target_wall.name].", LOG_ATTACK)
		qdel(src)
		return
	return ..()




