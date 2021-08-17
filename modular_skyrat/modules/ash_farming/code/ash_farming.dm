/turf/open/floor/plating/asteroid/basalt/lava_land_surface/attackby(obj/item/attacking_object, mob/user, params)
	if(istype(attacking_object, /obj/item/food/grown))
		var/planting_chance = 30 //you only have a 30 percent chance of succeeding in planting, unless you are an ashwalker
		if(user?.dna?.species?.id == SPECIES_LIZARD_ASH)
			planting_chance = 80
		var/obj/item/food/grown/attacking_grown = attacking_object
		if(!dug)
			to_chat(user, span_warning("You cannot grow plants on [src] without it being dug first!"))
			return
		if(!attacking_grown.seed)
			to_chat(user, span_warning("[attacking_grown] does not have a seed, it cannot be grown!"))
			return
		if(!do_after(user, 5 SECONDS, target = src))
			to_chat(user, span_warning("You interrupt your planting!"))
			return
		if(!prob(planting_chance))
			to_chat(user, span_warning("[attacking_grown] breaks in your hands!"))
			qdel(attacking_grown)
			return
		var/obj/structure/flora/ash_farming/new_farm = new /obj/structure/flora/ash_farming(src)
		new_farm.planted_seeds = attacking_grown.seed
		new_farm.update_farm()
		return
	return ..()

/obj/structure/flora/ash_farming
	name = "random plant"
	desc = "A plant that has adapted well to the lands of ash."
	///the seed that was planted, lots of info come from seeds
	var/obj/item/seeds/planted_seeds
	var/growing_time = 1 MINUTES

/obj/structure/flora/ash_farming/proc/update_farm()

/obj/structure/flora/ash_farming/attackby(obj/item/used_item, mob/living/user, params)
	if(istype(used_item, /obj/item/shovel))
		to_chat(user, span_notice("You begin digging up [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			return
		to_chat(user, span_notice("You dig up [src]."))
		qdel(src)
		return
	return ..()
