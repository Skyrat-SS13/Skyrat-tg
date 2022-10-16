/turf/closed/wall/mineral/bronze/true

/turf/closed/wall/mineral/bronze/true/Initialize(mapload)
	. = ..()
	new /obj/effect/temp_visual/ratvar/wall(src)
	new /obj/effect/temp_visual/ratvar/beam(src)

/turf/open/floor/bronze/true

/turf/open/floor/bronze/true/Initialize(mapload)
	. = ..()
	new /obj/effect/temp_visual/ratvar/floor(src)
	new /obj/effect/temp_visual/ratvar/beam(src)
