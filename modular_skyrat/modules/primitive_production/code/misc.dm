/obj/item/shard/attackby(obj/item/item, mob/user, params)
	//xenoarch hammer, forging hammer, etc.
	if(item.tool_behaviour == TOOL_HAMMER)
		new /obj/effect/decal/cleanable/glass(get_turf(src))
		new /obj/item/stack/ore/glass/zero_cost(get_turf(src))
		user.balloon_alert(user, "[src] shatters!")
		playsound(src, SFX_SHATTER, 30, TRUE)
		qdel(src)
		return TRUE

	return ..()

/obj/item/stack/ore/glass/zero_cost
	points = 0
	merge_type = /obj/item/stack/ore/glass/zero_cost
