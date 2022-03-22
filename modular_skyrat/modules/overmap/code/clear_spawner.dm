///This spawner clears the terrain of flora, and ScrapeAway's mineral turfs
/obj/effect/spawner/clear
	name = "clear terrain"

/obj/effect/spawner/clear/Initialize()
	..()
	var/turf/my_turf = get_turf(src)
	for(var/obj/structure/flora/flora in my_turf)
		qdel(flora)
	if(ismineralturf(my_turf))
		my_turf.ScrapeAway(flags = CHANGETURF_INHERIT_AIR)
	return INITIALIZE_HINT_QDEL
