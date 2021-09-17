GLOBAL_LIST_EMPTY(anti_eorg_teleports)

/obj/effect/landmark/anti_eorg_teleport
	name = "Anti-EORG teleport"

/obj/effect/landmark/anti_eorg_teleport/Initialize(mapload)
	..()
	GLOB.anti_eorg_teleports += loc
	return INITIALIZE_HINT_QDEL
