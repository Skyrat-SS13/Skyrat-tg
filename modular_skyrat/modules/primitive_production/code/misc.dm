/obj/item/shard/attackby(obj/item/item, mob/user, params)
	//xenoarch hammer, forging hammer, etc.
	if(item.tool_behaviour == TOOL_HAMMER)
		new /obj/effect/decal/cleanable/glass(get_turf(src))
		new /obj/item/stack/ore/glass(get_turf(src))
		user.balloon_alert(user, "[src] shatters!")
		qdel(src)
		return

	return ..()
