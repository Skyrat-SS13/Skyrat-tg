/obj/structure/disposalpipe
	plane = FLOOR_PLANE

/obj/structure/cable
	plane = FLOOR_PLANE

/obj/machinery/atmospherics/pipe
	plane = FLOOR_PLANE

/obj/structure/lattice/catwalk
	smoothing_groups = list(SMOOTH_GROUP_NORMAL_CATWALK, SMOOTH_GROUP_OPEN_FLOOR)
	canSmoothWith = list(SMOOTH_GROUP_NORMAL_CATWALK)
	layer = CATWALK_LAYER
	plane = FLOOR_PLANE

/obj/structure/lattice/catwalk/Initialize()
	. = ..()
	if(isspaceturf(loc))
		layer = LATTICE_LAYER

/obj/structure/lattice/catwalk/plated
	name = "plated catwalk"
	desc = "A durable catwalk for easier maintenance of pipes and wires. Cats hate this thing."
	icon = 'modular_skyrat/modules/mapping/icons/turf/open/catwalk_plated.dmi'
	icon_state = "catwalk_plated-0"
	base_icon_state = "catwalk_plated"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_PLATED_CATWALK)
	canSmoothWith = list(SMOOTH_GROUP_PLATED_CATWALK)

/obj/structure/lattice/catwalk/plated/dark
	name = "plated catwalk"
	icon = 'modular_skyrat/modules/mapping/icons/turf/open/dark_catwalk_plated.dmi'
