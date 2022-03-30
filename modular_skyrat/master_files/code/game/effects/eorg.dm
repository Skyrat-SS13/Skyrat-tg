/obj/effect/landmark/eorg
	name = "Transport Interchange"
	icon_state = "holding_facility"

GLOBAL_DATUM_INIT(eorg_teleport, /obj/effect/landmark/eorg, null)

/obj/effect/landmark/eorg/Initialize(loc, ...)
	. = ..()
	GLOB.eorg_teleport = src
