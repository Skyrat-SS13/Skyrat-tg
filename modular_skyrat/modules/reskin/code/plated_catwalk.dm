#define SMOOTH_GROUP_PLATED_CATWALK S_OBJ(71)			///obj/structure/plated_catwalk

/obj/structure/disposalpipe
	plane = FLOOR_PLANE

/obj/structure/cable
	plane = FLOOR_PLANE

/obj/machinery/atmospherics/pipe
	plane = FLOOR_PLANE

/obj/structure/plated_catwalk
	name = "plated catwalk"
	desc = "A durable catwalk for easier maintenance of pipes and wires. Cats hate this thing."
	icon = 'modular_skyrat/modules/reskin/icons/catwalk_plated.dmi'
	icon_state = "catwalk_plated-0"
	base_icon_state = "catwalk_plated"
	density = FALSE
	anchored = TRUE
	armor = list(MELEE = 50, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 80, ACID = 50)
	max_integrity = 50
	layer = 2.465 //GAS_SCRUBBER_LAYER 2.46
	plane = FLOOR_PLANE
	obj_flags = CAN_BE_HIT | BLOCK_Z_OUT_DOWN | BLOCK_Z_IN_UP
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_PLATED_CATWALK)
	canSmoothWith = list(SMOOTH_GROUP_PLATED_CATWALK)

/obj/structure/plated_catwalk/dark
	name = "plated catwalk"
	icon = 'modular_skyrat/modules/reskin/icons/dark_catwalk_plated.dmi'
