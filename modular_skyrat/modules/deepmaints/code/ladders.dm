GLOBAL_LIST_EMPTY(deepmaints_entrances)
GLOBAL_LIST_EMPTY(deepmaints_exits)

/obj/effect/landmark/deepmaints_entrance
	name = "deepmaints entrance ladder spawner"
	icon_state = "navigate"
	anchored = TRUE
	layer = OBJ_LAYER
	plane = GAME_PLANE
	invisibility = INVISIBILITY_ABSTRACT
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

/obj/effect/landmark/Initialize(mapload)
	. = ..()



/obj/effect/landmark/Destroy()
	GLOB.landmarks_list -= src
	return ..()

/obj/structure/deepmaints_entrance
	name = "heavy hatch"
	desc = "An odd, unmarked hatch that leads to somewhere below it. It looks really old, \
		you get the feeling you shouldn't go through it without being prepared for \
		consequences."
	icon = 'modular_skyrat/modules/deepmaints/icons/entrances.dmi'
	icon_state = "hatch"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	anchored = TRUE
