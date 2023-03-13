/turf/open/indestructible/reebe_void
	name = "void"
	desc = "A white, empty void, quite unlike anything you've seen before."
	icon_state = "reebemap"
	layer = SPACE_LAYER
	baseturfs = /turf/open/indestructible/reebe_void
	planetary_atmos = TRUE
	bullet_bounce_sound = null //forever falling
	tiled_dirt = FALSE


/turf/open/indestructible/reebe_void/Initialize(mapload)
	. = ..()
	icon_state = "reebegame"


/turf/open/indestructible/reebe_void/Enter(atom/movable/movable, atom/old_loc)
	if(!..())
		return FALSE
	else
		if(istype(movable, /obj/structure/window))
			return FALSE
		if(istype(movable, /obj/projectile))
			return TRUE
		return FALSE


/turf/open/indestructible/reebe_void/spawning
	icon_state = "reebespawn"


/turf/open/indestructible/reebe_void/spawning/Initialize(mapload)
	. = ..()
	if(mapload)
		for(var/i in 1 to 3)
			if(prob(1))
				new /obj/structure/fluff/clockwork/alloy_shards/large(src)

			if(prob(2))
				new /obj/structure/fluff/clockwork/alloy_shards/medium(src)

			if(prob(3))
				new /obj/structure/fluff/clockwork/alloy_shards/small(src)

/turf/open/indestructible/reebe_void/spawning/lattices
	icon_state = "reebelattice"

/turf/open/indestructible/reebe_void/spawning/lattices/Initialize(mapload)
	. = ..()
	if(mapload)
		if(prob(95))
			new /obj/structure/lattice(src)

