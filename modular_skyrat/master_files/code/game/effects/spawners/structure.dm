/obj/effect/spawner/structure/window/reinforced/Initialize(mapload)
	// We check if there's a firelock on the turf already, if so, we don't spawn one :)
	if(!(locate(/obj/machinery/door/firedoor) in get_turf(src)))
		spawn_list |= /obj/machinery/door/firedoor
	. = ..()
