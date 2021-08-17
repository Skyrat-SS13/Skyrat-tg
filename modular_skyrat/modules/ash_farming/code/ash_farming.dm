/turf/open/floor/plating/asteroid/basalt/lava_land_surface

/obj/structure/flora/ash_farming
	name = "random plant"
	desc = "A plant that has adapted well to the lands of ash."

/obj/structure/flora/ash_farming/attackby(obj/item/used_item, mob/living/user, params)
	if(istype(used_item, /obj/item/shovel))
		to_chat(user, span_notice("You begin digging up [src]..."))
		if(!do_after(user, 5 SECONDS, target = src))
			return
		to_chat(user, span_notice("You dig up [src]."))
		qdel(src)
		return
	return ..()
