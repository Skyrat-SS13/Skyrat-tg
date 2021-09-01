/turf/open/floor/plating/asteroid/basalt/lava_land_surface/attackby(obj/item/attacking_object, mob/user, params)
	if(istype(attacking_object, /obj/item/food/grown))
		var/obj/item/food/grown/attacking_grown = attacking_object
		if(attacking_grown.seed)
			seeding(attacking_grown.seed, attacking_grown, user)
		return
	else if(istype(attacking_object, /obj/item/grown))
		var/obj/item/grown/attacking_grown = attacking_object
		if(attacking_grown.seed)
			seeding(attacking_grown.seed, attacking_grown, user)
		return
	return ..()

/turf/open/floor/plating/asteroid/basalt/lava_land_surface/proc/seeding(obj/item/item_seed, obj/item/deleted_item, mob/user)
	var/obj/structure/flora/ash_farming/find_farm = locate() in contents
	if(find_farm)
		to_chat(user, span_warning("There can only be one farm in a hole at a time!"))
		return
	var/planting_chance = 30 //you only have a 30 percent chance of succeeding in planting, unless you are an ashwalker
	if(iscarbon(user))
		var/mob/living/carbon/carbon_user = user
		if(carbon_user?.dna?.species?.id == SPECIES_LIZARD_ASH)
			planting_chance = 80
	if(!dug)
		to_chat(user, span_warning("You cannot grow plants on [src] without it being dug first!"))
		return
	if(!item_seed)
		to_chat(user, span_warning("[deleted_item] does not have a seed, it cannot be grown!"))
		return
	to_chat(user, span_notice("You begin planting..."))
	if(!do_after(user, 5 SECONDS, target = src))
		to_chat(user, span_warning("You interrupt your planting!"))
		return
	if(!prob(planting_chance))
		to_chat(user, span_warning("[deleted_item] breaks in your hands!"))
		qdel(deleted_item)
		return
	var/obj/structure/flora/ash_farming/new_farm = new /obj/structure/flora/ash_farming(src)
	new_farm.planted_seeds = item_seed
	new_farm.name = new_farm.planted_seeds.plantname
	new_farm.icon = new_farm.planted_seeds.growing_icon
	new_farm.icon_state = "[new_farm.planted_seeds.icon_grow]1"
	new_farm.update_appearance()
	user.visible_message("[user] finished planting [new_farm].", "You finish planting [new_farm].")
	qdel(deleted_item)

/obj/structure/flora/ash_farming
	name = "random plant"
	desc = "A plant that has adapted well to the lands of ash."
	///the seed that was planted, lots of info come from seeds
	var/obj/item/seeds/planted_seeds
	var/growing_time = 1 MINUTES
	var/harvested = TRUE

/obj/structure/flora/ash_farming/Initialize()
	. = ..()
	addtimer(CALLBACK(src, .proc/finish_growing), growing_time)

/obj/structure/flora/ash_farming/proc/finish_growing()
	if(QDELETED(src))
		return
	harvested = FALSE
	icon_state = "[planted_seeds.icon_grow][planted_seeds.growthstages]"
	update_appearance()

/obj/structure/flora/ash_farming/Destroy()
	if(planted_seeds)
		planted_seeds = null
	return ..()

/obj/structure/flora/ash_farming/attack_hand(mob/living/user, list/modifiers)
	if(!harvested)
		to_chat(user, span_notice("You harvest [src]."))
		harvested = TRUE
		icon_state = "[planted_seeds.icon_grow]1"
		var/turf/src_turf = get_turf(src)
		for(var/spawning_food in 1 to 3)
			if(prob(33))
				continue
			if(planted_seeds?.mutatelist?.len >= 1 && prob(10))
				var/obj/item/seeds/choose_seed = pick(planted_seeds.mutatelist)
				var/obj/item/food/grown/chosen_grow = initial(choose_seed.product)
				new chosen_grow(src_turf)
				continue
			var/obj/item/food/grown/spawned_grown = planted_seeds.product
			new spawned_grown(src_turf)
		addtimer(CALLBACK(src, .proc/finish_growing), growing_time)
		return
	return ..()

/obj/structure/flora/ash_farming/attackby(obj/item/used_item, mob/living/user, params)
	if(istype(used_item, /obj/item/shovel))
		to_chat(user, span_notice("You begin digging up [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			return
		to_chat(user, span_notice("You dig up [src]."))
		qdel(src)
		return
	return ..()
