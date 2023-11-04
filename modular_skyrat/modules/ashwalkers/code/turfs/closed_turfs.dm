/turf/closed/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/flashlight/flare/torch))
		user.dropItemToGround(attacking_item)
		attacking_item.forceMove(src)
		return

	return ..()
