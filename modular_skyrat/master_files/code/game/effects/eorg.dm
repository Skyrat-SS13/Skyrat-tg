/obj/effect/landmark/eorg
	name = "Transport Interchange"
	icon_state = "holding_facility"

GLOBAL_LIST_INIT(eorg_teleport, list())

/obj/effect/landmark/eorg/Initialize(loc, ...)
	. = ..()
	GLOB.eorg_teleport += src
