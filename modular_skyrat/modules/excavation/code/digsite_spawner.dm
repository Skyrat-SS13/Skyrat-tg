///This spawner places a digsite on the turf it's on
/obj/effect/spawner/digsite
	name = "digsite spawner"

/obj/effect/spawner/digsite/Initialize()
	..()
	var/turf/my_turf = get_turf(src)
	if(!my_turf.GetComponent(/datum/component/digsite))
		my_turf.AddComponent(/datum/component/digsite)
	return INITIALIZE_HINT_QDEL
